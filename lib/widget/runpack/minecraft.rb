require 'fileutils'
require 'targz'

WORLD_OPS = %W(chrislloyd whatupdave)
HEAD_SERVER_JAR = 'https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft_server.jar'

module Widget
  module Runpack
    class Minecraft
      attr_reader :world_id, :port, :options, :level_name
      attr_reader :world_path, :backup_dir, :pid_file
      attr_reader :stdin, :stdout
      
      def initialize world_id, port, options = {}
        @world_id, @port = world_id, port
        @options = options
        
        @world_path = "#{WORLDS}/#{world_id}"
        @pid_file = "#{PID_PATH}/#{world_id}.#{port}"
        
        @properties_path = "#{world_path}/server.properties"
        @backup_dir = "#{ROOT}/backups"
        @level_name = 'level'
        
        @stdin, @stdout = "#{world_path}/world.stdin", "#{world_path}/world.stdout"
        
        @backup_in_progress = false
      end
      
      def info message
        puts "[#{world_id}] #{message}"
      end
      
      def prepare
        op = EM::DefaultDeferrable.new
        EM.defer do
          begin
            FileUtils.mkdir_p world_path
            FileUtils.mkdir_p backup_dir

            prepare_world_dir
            create_server_properties
            create_ops_file
            remove_ban_list
            truncate_server_log
            download_server
            configure_plugins
            Widget::Runpack.serialize world_path, self

            op.succeed
          rescue => e
            op.fail e
          end
        end
        op
      end
      
      def start port, min_heap_size, max_heap_size, *a, &b
        cmd = "java -Xmx#{max_heap_size}M -Xms#{min_heap_size}M -jar server.jar nogui"

        @backup_timer = EM.add_periodic_timer(10 * 60) { backup { info "backup completed" } }

        cb = EM::Callback *a, &b
        Pot.spawn_pot_process world_path, pid_file, cmd, "world.stdin", "world.stdout", "world.stdout" do
          cb.call pid_file
        end
        cb
      end
      
      def world_stopped *a, &b
        cb = EM::Callback *a, &b
        @backup_timer.cancel if @backup_timer
        
        @backup_waiter = EM.add_periodic_timer(10) do
          unless @backup_in_progress
            @backup_waiter.cancel
            backup { cb.call }
          end 
        end
        cb
      end
      
      def backup *a, &b
        cb = EM::Callback *a, &b
        @backup_in_progress = true
        stop_world_save
        EM.add_timer 3 do
          EM.defer do
            backup_retries = 10
            begin
              info "Starting backup:#{backup_retries}"
              create_and_upload_backup
              start_world_save
              info "backup finished"
              cb.call
            rescue => e
              info "BACKUP ERROR: #{e.message}\n#{e.backtrace}"
              retry if (backup_retries -= 1) > 0
              info "FATAL BACKUP ERROR"
            end
          end
        end
        cb
      end
      
      def stop_world_save
        send_line "save-off"
        send_line "save-all"
      end
      
      def start_world_save
        send_line "save-on"
      end
      
      def prepare_world_dir
        if data_file = Storage.new.worlds.files.get(options['data_file'])
          archive = "#{backup_dir}/#{world_id}.tar.gz"
          File.open(archive, "w") {|tar| tar.write data_file.body }
          TarGz.new.extract backup_dir, archive

          # find world and level dirs
          level_dir = File.dirname(`find #{backup_dir} -iname level\.dat | head -n1`.strip)
          extracted_world_dir = File.dirname level_dir
          @level_name = File.basename level_dir

          # move to world_path
          puts "extracted world dir:#{extracted_world_dir} => #{world_path}"
          FileUtils.rm_rf world_path
          FileUtils.mv extracted_world_dir, world_path

          info "using existing world backup:#{options['data_file']} level_data:#{world_path}/#{level_name}"
        else
          info "no backup found for:#{options['data_file']} creating new world data"
        end
      end
      
      def create_and_upload_backup
        world_archive = "#{ROOT}/backups/#{world_id}.tar.gz"

        # having this file present lets others know there is a backup in process
        FileUtils.mkdir_p File.dirname(world_archive)
        FileUtils.touch world_archive

        # tar gz world
        info "Archiving #{world_path} to #{world_archive}"
        result = TarGz.new.archive WORLDS, world_id, world_archive, exclude:'server.jar'
        info result unless $?.exitstatus == 0
        raise "error archiving world" unless $?.exitstatus == 0

        directory = Storage.new.worlds

        backup_time = Time.now
        backup_file = "#{world_id}.#{backup_time.to_i}.tar.gz"
        upload_retries = 10
        begin
          # TODO: stop storing this file
          File.open(world_archive) do |world_archive_file|
            key = "#{world_id}.tar.gz"
            info "Uploading #{key} #{upload_retries}"
            file = directory.files.create(
              :key    => key,
              :body   => world_archive_file,
              :public => false
            )
          end

          File.open(world_archive) do |world_archive_file|
            info "Uploading #{backup_file} #{upload_retries}"
            file = directory.files.create(
              :key    => backup_file,
              :body   => world_archive_file,
              :public => false
            )
          end

          set_backup_info backup_file, backup_time

          FileUtils.rm_f world_archive
        rescue => e
          info "UPLOAD ERROR: #{e.message}\n#{e.backtrace}"
          retry if (upload_retries -= 1) > 0
        end
      end
      
      def configure_plugins
        options['plugins'].each do |plugin|
          name, version = plugin['name'], plugin['version']
          
          info "adding plugin #{name} #{version}"
          download_pack_file "plugins/#{name}/#{version}/#{name}.jar", "plugins/#{name}.jar"
        end
      end
      
      def create_server_properties
        properties = server_properties.map {|values| values.join('=')}
        info "world settings #{properties.join ' '}"
        File.open(@properties_path, 'w') do |file| 
          file.puts properties.join "\n"
        end
      end
      
      def create_ops_file
        ops = WORLD_OPS | options['ops']

        if File.exists? "#{world_path}/ops.txt"
          File.open("#{world_path}/ops.txt") do |file|
            ops = ops | file.read.split("\n")
          end
        end

        File.open("#{world_path}/ops.txt", "w") do |file|
          file.puts ops.join("\n")
          file.puts
        end
      end
      
      def remove_ban_list
        FileUtils.rm_f("#{world_path}/banned-players.txt")
      end
      
      def truncate_server_log
        server_log = File.join(world_path, "server.log")
        File.open(server_log, "w") {|file| file.print }
      end
      
      def download_server
        info "downloading minecraft server version:#{options['version']}"
        if options['version'] == 'HEAD'
          info `curl --silent --show-error -RL #{HEAD_SERVER_JAR} -o '#{world_path}/server.jar'`
        else
          download_pack_file 'server.jar', 'server.jar'
        end
      end
      
      def download_pack_file remote_file, local_file
        remote_path = "minecraft/#{options['version']}/#{remote_file}"
        server_key = Storage.new.game_servers.files.get(remote_path)
        raise "File not found: #{remote_path}" unless server_key

        File.open("#{world_path}/#{local_file}", 'w') {|f| f.write(server_key.body) }
        # File.write("#{world_path}/#{local_file}", server_key.body)
      end
      
      def server_properties
        { "allow-flight"     => false,
          "allow-nether"     => true,
          "level-name"       => level_name,
          "level-seed"       => options['seed'].to_s,
          "level-type"       => options['level_type'] || 'DEFAULT',
          "max-players"      => 1000,
          "online-mode"      => (options['online_mode'].nil? ? true : options['online_mode']).to_s,
          "difficulty"       => options['difficulty'].to_s,
          "gamemode"         => options['game_mode'].to_s,
          "pvp"              => (options['pvp'] || false).to_s,
          "server-ip"        => "0.0.0.0",
          "server-port"      => port,
          "spawn-animals"    => (options['spawn_animals'] || false).to_s,
          "spawn-monsters"   => (options['spawn_monsters'] || false).to_s,
          "view-distance"    => 10,
          "white-list"       => false
        }
      end
      
      def mongo
        @mongo ||= MinefoldDb.connection
      end
      
      def mongo_worlds
        mongo['worlds']
      end

      def mongo_world world_id
        mongo_worlds.find_one('_id' => BSON::ObjectId(world_id))
      end
      
      def server_versions
        mongo['game_servers'].find(name: 'minecraft')
      end
      
      def set_backup_info backup_file, backup_time
        info "backed up world to file:#{backup_file} time:#{backup_time.to_i}"
        mongo_worlds.update(
          {'_id' => BSON::ObjectId(world_id.to_s)}, 
          {'$set' => {
            'backed_up_at'    => backup_time,
            'world_data_file' => backup_file
          }}
        )
      end
      
      def send_line line
        File.open(stdin, 'a') {|f| f.puts line }
      end
      
    end
  end
end