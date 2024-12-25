###########################################################
#  author: online
#  version: 1.0
#  library: glad
#  date: 20240105
###########################################################

set(Glad_SRC_DIR  "${CMAKE_SOURCE_DIR}/third/glad-4.1")
set(Glad_INSTALL_DIR  "${CMAKE_SOURCE_DIR}/third/build/Glad")

add_library(Tornado::Glad INTERFACE IMPORTED)

if(NOT EXISTS "${Glad_INSTALL_DIR}/include/glad/glad.h")
    if(NOT EXISTS  ${Glad_SRC_DIR})
        message(FATAL_ERROR "FATAL: Glad not exist.")
    endif()
    execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${Glad_SRC_DIR}/include ${Glad_INSTALL_DIR}/include)
endif()
add_library(glad ${Glad_SRC_DIR}/src/glad.c)

add_library(Tornado::Glad ALIAS glad)
set(Glad_INCLUDE_DIR ${Glad_INSTALL_DIR}/include)
set(Glad_LIBRARIES glad)
include_directories(${Glad_INCLUDE_DIR})