###########################################################
#  author: online
#  version: 1.0
#  library: stb
#  date: 20240105
###########################################################

set(Stb_SRC_DIR  "${CMAKE_SOURCE_DIR}/third/stb")
set(Stb_INSTALL_DIR  "${CMAKE_SOURCE_DIR}/third/build/Stb")

if(NOT EXISTS "${Stb_INSTALL_DIR}/stb_image.h")
    file(GLOB stb_hpp_src ${Stb_SRC_DIR}/*.h)
    foreach(stb_hpp ${stb_hpp_src})
        file(COPY ${stb_hpp} DESTINATION ${Stb_INSTALL_DIR})
    endforeach()
    if(NOT EXISTS  ${Stb_SRC_DIR})
        message(FATAL_ERROR "FATAL: Stb not exist.")
    endif()

endif()

set(Stb_INCLUDE_DIR ${Stb_INSTALL_DIR})
include_directories(${Stb_INCLUDE_DIR})
add_definitions(-DSTB_IMAGE_IMPLEMENTATION -DSTB_IMAGE_STATIC)
