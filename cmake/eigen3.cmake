###########################################################
#  author: online
#  version: 1.0
#  library: eigen
#  date: 20241126
###########################################################

set(Eigen_SRC_DIR  "${CMAKE_SOURCE_DIR}/third/eigen")
set(Eigen_BUILD_DIR  "${Eigen_SRC_DIR}/build")
set(Eigen_INSTALL_DIR  "${CMAKE_SOURCE_DIR}/third/build/Eigen")
add_library(Tornado::Eigen INTERFACE IMPORTED)

execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${Eigen_INSTALL_DIR}/include")
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${Eigen_BUILD_DIR}")

if(NOT EXISTS  ${Eigen_SRC_DIR})
    message(FATAL_ERROR "FATAL: Eigen not exist.")
endif()
message(STATUS ${CMAKE_SOURCE_DIR}/third/eigen/build)
add_custom_target(ext_eigen 
                    COMMAND ${CMAKE_COMMAND}
                        -DCMAKE_INSTALL_PREFIX=${CMAKE_SOURCE_DIR}/third/build/Eigen
                        ..
                    COMMAND ${CMAKE_COMMAND} --build . --config ${CMAKE_BUILD_TYPE} --target install -j ${CPU_THREAD_NUM}
                    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/third/eigen/build
                    COMMENT "Build Eigen Library.")
add_dependencies(Tornado::Eigen ext_eigen)


set(Eigen_INCLUDE_DIR ${Eigen_INSTALL_DIR}/include/eigen3)
include_directories(${Eigen_INCLUDE_DIR})
