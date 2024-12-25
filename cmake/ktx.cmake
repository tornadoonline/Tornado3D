###########################################################
#  author: online
#  version: 1.0
#  library: ktx
#  date: 20241126
###########################################################

set(Ktx_SRC_DIR  "${CMAKE_SOURCE_DIR}/third/ktx")
set(Ktx_INSTALL_DIR  "${CMAKE_SOURCE_DIR}/third/build/Ktx")

add_library(Tornado::Ktx INTERFACE IMPORTED)

if(NOT EXISTS "${Ktx_INSTALL_DIR}/include/glad/glad.h")
    if(NOT EXISTS  ${Ktx_SRC_DIR})
        message(FATAL_ERROR "FATAL: Ktx not exist.")
    endif()
    execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory ${Ktx_SRC_DIR}/include ${Ktx_INSTALL_DIR}/include)
endif()
set(KTX_SOURCES
	${Ktx_SRC_DIR}/lib/texture.c
	${Ktx_SRC_DIR}/lib/hashlist.c
	${Ktx_SRC_DIR}/lib/checkheader.c
	${Ktx_SRC_DIR}/lib/swap.c
	${Ktx_SRC_DIR}/lib/memstream.c
	${Ktx_SRC_DIR}/lib/filestream.c
	${Ktx_SRC_DIR}/lib/vkloader.c
)

add_library(ktx ${KTX_SOURCES})
target_include_directories(ktx PUBLIC ${Ktx_SRC_DIR}/include)

add_library(Tornado::Ktx ALIAS ktx)
set(Ktx_INCLUDE_DIR ${Ktx_INSTALL_DIR}/include)
set(Ktx_LIBRARIES ktx)
include_directories(${Ktx_INCLUDE_DIR})
include_directories(D:/Work/Tornado3D/third/tinygltf)