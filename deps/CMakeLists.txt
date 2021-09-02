project (deps)
set(BUILD_SHARED_LIBS ON) 

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/libmp3lame-CMAKE)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/ogg)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/vorbis)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/libshout-CMAKE)

if (WIN32) 
	set(BUILD_SHARED_LIBS OFF) #Windows builds unusable FLAC.lib files otherwise
	set(OGG_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/OGG-Vorbis-CMAKE/libogg/include)
	set(OGG_LIBRARY "${CMAKE_CURRENT_SOURCE_DIR}/OGG-Vorbis-CMAKE/libogg/lib/ogg.lib")
else()
  #set(BUILD_SHARED_LIBS ON) #Linux fails to link the final libShoutVST.so otherwise
endif ()


add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/flac)

add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/vst_sdk_2.4)

set(OPTION_BUILD_SHARED_LIBS ON CACHE BOOL " " FORCE)
set(FLTK_BUILD_TEST OFF CACHE BOOL " " FORCE)
SET(FLTK_BUILD_EXAMPLES OFF)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/fltk)
