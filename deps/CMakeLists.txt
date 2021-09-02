project (deps)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/libmp3lame-CMAKE)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/OGG-Vorbis-CMAKE)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/libshout-CMAKE)

if (WIN32) 
  set(BUILD_SHARED_LIBS OFF) #Windows builds unusable FLAC.lib files otherwise
  #FLAC requires a compiled libogg ahead of building; locating an installed libogg was not working
  #some hacking to tell flac OGG is available, since we know it will be compiled and linked with ShoutVST at the end 
  include_directories(${CMAKE_CURRENT_SOURCE_DIR}/OGG-Vorbis-CMAKE/libogg/include)
  set(OGG_FOUND 1)
else()
  set(BUILD_SHARED_LIBS ON) #Linux fails to link the final libShoutVST.so otherwise
endif ()

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/flac)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/vst_sdk_2.4)

SET(OPTION_BUILD_EXAMPLES OFF CACHE BOOL "FLTK: Builds the many fine example programs.")
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/FLTK)
