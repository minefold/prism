pil: 
  ARCHFLAGS="-arch x86_64" python setup.py build
  
overviewer:
  ARCHFLAGS="-arch i386 -arch x86_64" C_INCLUDE_PATH="`pwd`/vendor/pil/libImaging" python ./setup.py build