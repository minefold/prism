pil: 
  setup.py -> ZLIB_ROOT = ("/usr/lib/x86_64-linux-gnu", "/usr/include")
  
  ARCHFLAGS="-arch x86_64" python setup.py build
  
overviewer:
  ARCHFLAGS="-arch i386 -arch x86_64" C_INCLUDE_PATH="`pwd`/vendor/pil/libImaging" python ./setup.py build


# state

usernames (HASH)
  whatupdave => '91823746'
  chrislloyd => '89337893'
  willrax    => '89437832'
  
players:playing (HASH)
  whatupdave => '91823746'
  
worlds:91823746:connected_players (SET)
  whatupdave
  
worlds:busy (HASH)
  world2 => i-1234, state:starting, next_state:
  world5 => i-1234, state:stopping, next_state:starting
  
worlds:running (HASH)
  world1 => i-5637, 1.2.3.4, 4001
  
workers:running (HASH)
  i-5678 => 1.2.3.4

workers:i-5678:worlds (SET)
  world1

# queues

players:minute_played
  username:whatupdave, time:[timestamp]
  username:whatupdave, time:[timestamp]
  username:chrislloyd, time:[timestamp]

players:requesting_connection
  whatupdave

players:disconnecting
  mod

workers:not_responding

# game packs

example game pack

World:
  _id: 1234
  runpack:
    name: minecraft
    version: HEAD
    plugins:
      worldguard:
        enabled: true
      dynmap:
        enabled: true
      rpg:
        villages: true



ENV:
  MIN_HEAP_SIZE
  MAX_HEAP_SIZE



