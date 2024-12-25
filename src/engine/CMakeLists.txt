cmake_minimum_required(VERSION 3.7)
project("Engine")

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/bin)

if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
endif()
file(GLOB engine_cpp_src *.cpp)
# file(GLOB engine_hpp_src *.h)

add_library(Engine ${engine_cpp_src})
target_link_libraries(Engine ${Vulkan_LIBRARIES})
# add_dependencies(Engine Tornado::Glfw Tornado::Glm)

# if(NOT EXISTS "${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}/glfw3.dll")
#   file(COPY ${CMAKE_SOURCE_DIR}/third/build/Glfw/bin/glfw3.dll DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}")
# endif()
