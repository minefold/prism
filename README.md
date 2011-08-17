pil: 
  setup.py -> ZLIB_ROOT = ("/usr/lib/x86_64-linux-gnu", "/usr/include")
  
  ARCHFLAGS="-arch x86_64" python setup.py build
  
overviewer:
  ARCHFLAGS="-arch i386 -arch x86_64" C_INCLUDE_PATH="`pwd`/vendor/pil/libImaging" python ./setup.py build


players:user_id (HASH)
  whatupdave => '91823746'
  chrislloyd => '89337893'
  willrax    => '89437832'

players:world_id (HASH)
  whatupdave => '91823746'
  chrislloyd => '89337893'
  willrax    => '89437832'

prism:active_connections (SET)
  willrax
  
worlds:running (HASH)
  world1 => i-5637, 1.2.3.4, 4001
  
workers:running (SET)
  i-5678
  
workers:i-5678:worlds (SET)
  world1

  
players:connecting (LIST)
  whatupdave
  
players:waiting (LIST)
  whatupdave
  chrislloyd
  
players:disconnecting (LIST)
  mod


prism:
  on connection 
    extract username
    LPUSH username onto players:connecting queue
    subscribe to connection_info:@username
  
  on connection_info : status
    status:
      world_running: host, port
        SADD players:connected
        proxy client to host:port
        
      unknown_player
        disconnect client
    
  on disconnect
    LPUSH username onto players:disconnecting queue
    


player_coordinator:
  on startup
    BLPOP players:connecting
    BLPOP players:disconnecting
    
  on player_connecting : username
    mongo get user_id, world_id
    HSET players:user_id
    HSET players:world_id
    LPUSH players:waiting
    
    
  on player_disconnecting : username
    if last player out
      stop_world
    
      
world_coordinator:
  on startup
    BLPOP players:waiting
    
  on player_started_waiting
    world running?
      
    determine if world needs starting
    determine if worker needs starting
    
    
    