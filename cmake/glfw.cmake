###########################################################
#  author: online
#  version: 1.0
#  library: glfw
#  date: 20240105
###########################################################


set(Glfw_SRC_DIR  "${CMAKE_SOURCE_DIR}/third/glfw")
set(Glfw_BUILD_DIR  "${Glfw_SRC_DIR}/build")
set(Glfw_INSTALL_DIR  "${CMAKE_SOURCE_DIR}/third/build/Glfw")

add_library(Tornado::Glfw INTERFACE IMPORTED)

if(NOT EXISTS "${Glfw_INSTALL_DIR}/include/GLFW/glfw3.h")
    if(NOT EXISTS "${Glfw_INSTALL_DIR}/include")
        execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${Glfw_INSTALL_DIR}/include")
    endif()
    if(NOT EXISTS "${Glfw_BUILD_DIR}")
        execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${Glfw_BUILD_DIR}")
    endif()

    if(NOT EXISTS  ${Glfw_SRC_DIR})
        message(FATAL_ERROR "FATAL: Glfw not exist.")
    endif()

    add_custom_target(ext_glfw 
                        COMMAND ${CMAKE_COMMAND}
                            -DCMAKE_INSTALL_PREFIX=${Glfw_INSTALL_DIR}
                            -DBUILD_SHARED_LIBS=ON
                            -DGLFW_BUILD_EXAMPLES=OFF
                            -DGLFW_BUILD_TESTS=OFF
                            -DGLFW_BUILD_DOCS=OFF
                            ..
                        COMMAND ${CMAKE_COMMAND} --build . --config ${CMAKE_BUILD_TYPE} --target install -j ${CPU_THREAD_NUM}
                        WORKING_DIRECTORY ${Glfw_BUILD_DIR}
                        COMMENT "Build Glfw Library.")
    add_dependencies(Tornado::Glfw ext_glfw)
endif()

if(CMAKE_SYSTEM_NAME MATCHES "Windows")
    set_target_properties(Tornado::Glfw PROPERTIES 
                        INTERFACE_INCLUDE_DIRECTORIES "${Glfw_INSTALL_DIR}/include"
                        IMPORTED_LOCATION_DEBUG "${Glfw_INSTALL_DIR}/lib/glfw3dll.lib"
                        IMPORTED_LOCATION_RELEASE "${Glfw_INSTALL_DIR}/lib/glfw3dll.lib"
                        MAP_IMPORTED_CONFIG_MINSIZEREL Release
                        MAP_IMPORTED_CONFIG_RELWITHDEBINFO Release
                        IMPORTED_CONFIGURATIONS Release)
elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
    set_target_properties(Tornado::Glfw PROPERTIES 
                        INTERFACE_INCLUDE_DIRECTORIES "${Glfw_INSTALL_DIR}/include"
                        IMPORTED_LOCATION_DEBUG "${Glfw_INSTALL_DIR}/lib/glfw.so"
                        IMPORTED_LOCATION_RELEASE "${Glfw_INSTALL_DIR}/lib/glfw.so"
                        MAP_IMPORTED_CONFIG_MINSIZEREL Release
                        MAP_IMPORTED_CONFIG_RELWITHDEBINFO Release
                        IMPORTED_CONFIGURATIONS Release)
endif()

get_target_property(Glfw_INCLUDE_DIR Tornado::Glfw INTERFACE_INCLUDE_DIRECTORIES)
if(CMAKE_BUILD_TYPE MATCHES "Debug")
    get_target_property(Glfw_LIBRARIES Tornado::Glfw IMPORTED_LOCATION_DEBUG)
elseif(CMAKE_BUILD_TYPE MATCHES "Release")
    get_target_property(Glfw_LIBRARIES Tornado::Glfw IMPORTED_LOCATION_RELEASE)
endif()

include_directories(${Glfw_INCLUDE_DIR})