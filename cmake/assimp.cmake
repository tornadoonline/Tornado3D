###########################################################
#  author: online
#  version: 1.0
#  library: assimp
#  date: 20240105
###########################################################


set(Assimp_SRC_DIR  "${CMAKE_SOURCE_DIR}/third/assimp")
set(Assimp_BUILD_DIR  "${Assimp_SRC_DIR}/build")
set(Assimp_INSTALL_DIR  "${CMAKE_SOURCE_DIR}/third/build/Assimp")

add_library(Tornado::Assimp INTERFACE IMPORTED)

if(NOT EXISTS "${Assimp_INSTALL_DIR}/include/assimp/Importer.hpp")
    if(NOT EXISTS "${Assimp_INSTALL_DIR}/include")
        execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${Assimp_INSTALL_DIR}/include")
    endif()
    if(NOT EXISTS "${Assimp_BUILD_DIR}")
        execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${Assimp_BUILD_DIR}")
    endif()

    if(NOT EXISTS  ${Assimp_SRC_DIR})
        message(FATAL_ERROR "FATAL: Assimp not exist.")
    endif()

    add_custom_target(ext_assimp 
                        COMMAND ${CMAKE_COMMAND}
                            -DCMAKE_INSTALL_PREFIX=${Assimp_INSTALL_DIR}
                            -DBUILD_SHARED_LIBS=ON
                            -DASSIMP_BUILD_ZLIB=ON
                            -DASSIMP_BUILD_ASSIMP_TOOLS=OFF
                            -DASSIMP_BUILD_TESTS=OFF
                            -DASSIMP_INSTALL_PDB=OFF
                            -DASSIMP_WARNINGS_AS_ERRORS=OFF
                            ..
                        COMMAND ${CMAKE_COMMAND} --build . --config ${CMAKE_BUILD_TYPE} --target install -j ${CPU_THREAD_NUM}
                        WORKING_DIRECTORY ${Assimp_BUILD_DIR}
                        COMMENT "Build Assimp Library.")
    add_dependencies(Tornado::Assimp ext_assimp)
endif()

if(CMAKE_SYSTEM_NAME MATCHES "Windows")
    set_target_properties(Tornado::Assimp PROPERTIES 
                        INTERFACE_INCLUDE_DIRECTORIES "${Assimp_INSTALL_DIR}/include"
                        IMPORTED_LOCATION_DEBUG "${Assimp_INSTALL_DIR}/lib/assimp-vc142-mt.lib"
                        IMPORTED_LOCATION_RELEASE "${Assimp_INSTALL_DIR}/lib/assimp-vc142-mt.lib"
                        MAP_IMPORTED_CONFIG_MINSIZEREL Release
                        MAP_IMPORTED_CONFIG_RELWITHDEBINFO Release
                        IMPORTED_CONFIGURATIONS Release)
elseif(CMAKE_SYSTEM_NAME MATCHES "Linux")
    set_target_properties(Tornado::Assimp PROPERTIES 
                        INTERFACE_INCLUDE_DIRECTORIES "${Assimp_INSTALL_DIR}/include"
                        IMPORTED_LOCATION_DEBUG "${Assimp_INSTALL_DIR}/lib/assimp-vc142-mt.so"
                        IMPORTED_LOCATION_RELEASE "${Assimp_INSTALL_DIR}/lib/assimp-vc142-mt.so"
                        MAP_IMPORTED_CONFIG_MINSIZEREL Release
                        MAP_IMPORTED_CONFIG_RELWITHDEBINFO Release
                        IMPORTED_CONFIGURATIONS Release)
endif()

get_target_property(Assimp_INCLUDE_DIR Tornado::Assimp INTERFACE_INCLUDE_DIRECTORIES)
if(CMAKE_BUILD_TYPE MATCHES "Debug")
    get_target_property(Assimp_LIBRARIES Tornado::Assimp IMPORTED_LOCATION_DEBUG)
elseif(CMAKE_BUILD_TYPE MATCHES "Release")
    get_target_property(Assimp_LIBRARIES Tornado::Assimp IMPORTED_LOCATION_RELEASE)
endif()

include_directories(${Assimp_INCLUDE_DIR})
