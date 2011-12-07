require 'core_ext'
require 'widget/log_line'
require 'widget/pot'
require 'widget/world_process_watcher'
require 'widget/world_line_reader'
require 'widget/system'

require 'widget/plugins'
Dir[File.expand_path('../widget/plugins/*.rb', __FILE__)].each { |f| require f }