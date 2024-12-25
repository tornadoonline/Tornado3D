###########################################################
#  author: online
#  version: 1.0
#  library: glm
#  date: 20241126
###########################################################

set(Glm_SRC_DIR  "${CMAKE_SOURCE_DIR}/third/glm")
set(Glm_BUILD_DIR  "${Glm_SRC_DIR}/build")
set(Glm_INSTALL_DIR  "${CMAKE_SOURCE_DIR}/third/build/Glm")
add_library(Tornado::Glm INTERFACE IMPORTED)

execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${Glm_INSTALL_DIR}/include")
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${Glm_BUILD_DIR}")

if(NOT EXISTS  ${Glm_SRC_DIR})
    message(FATAL_ERROR "FATAL: Glm not exist.")
endif()
add_custom_target(ext_glm 
                    COMMAND ${CMAKE_COMMAND}
                        -DCMAKE_INSTALL_PREFIX=${CMAKE_SOURCE_DIR}/third/build/Glm
                        ..
                    COMMAND ${CMAKE_COMMAND} --build . --config ${CMAKE_BUILD_TYPE} --target install -j ${CPU_THREAD_NUM}
                    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/third/glm/build
                    COMMENT "Build Glm Library.")
add_dependencies(Tornado::Glm ext_glm)


if(CMAKE_SYSTEM_NAME MATCHES "Windows")
    set_target_properties(Tornado::Glm PROPERTIES 
                        INTERFACE_INCLUDE_DIRECTORIES "${Glm_INSTALL_DIR}/include"
                        IMPORTED_LOCATION_DEBUG "${Glm_INSTALL_DIR}/lib/glm_static.lib"
                        IMPORTED_LOCATION_RELEASE "${Glm_INSTALL_DIR}/lib/glm_static.lib"
                        MAP_IMPORTED_CONFIG_MINSIZEREL Release
                        MAP_IMPORTED_CONFIG_RELWITHDEBINFO Release
                        IMPORTED_CONFIGURATIONS Release)
elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
    set_target_properties(Tornado::Glm PROPERTIES 
                        INTERFACE_INCLUDE_DIRECTORIES "${Glm_INSTALL_DIR}/include"
                        IMPORTED_LOCATION_DEBUG "${Glm_INSTALL_DIR}/lib/glm_static.so"
                        IMPORTED_LOCATION_RELEASE "${Glm_INSTALL_DIR}/lib/glm_static.so"
                        MAP_IMPORTED_CONFIG_MINSIZEREL Release
                        MAP_IMPORTED_CONFIG_RELWITHDEBINFO Release
                        IMPORTED_CONFIGURATIONS Release)
endif()

set(Glm_INCLUDE_DIR ${Glm_INSTALL_DIR}/include)
include_directories(${Glm_INCLUDE_DIR})
