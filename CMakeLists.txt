cmake_minimum_required(VERSION 3.7)
project("Tornado")

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/bin)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/bin)

add_definitions(-DNOMINMAX)

if(NOT EXISTS "${CMAKE_SOURCE_DIR}/third/build")
    execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_SOURCE_DIR}/third/build")
endif()

if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release")
endif()

include_directories(./src)

include(cmake/vulkan.cmake)
include(cmake/eigen3.cmake)
# include(cmake/glm.cmake)
include(cmake/assimp.cmake)
include(cmake/glad.cmake)
# include(cmake/glfw.cmake)
include(cmake/stb.cmake)
# include(cmake/imgui.cmake)
include(cmake/ktx.cmake)

add_subdirectory(src/engine)
# add_subdirectory(src/utils)

include_directories(src/engine)
add_executable(${CMAKE_PROJECT_NAME}_0 main.cxx)
target_link_libraries(${CMAKE_PROJECT_NAME}_0 Engine)
# add_dependencies(${CMAKE_PROJECT_NAME}_0 Tornado::Ktx)

# if(CMAKE_BUILD_TYPE MATCHES "Debug")
#   set(RUNTIME_OUTPUT_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG})
# elseif(CMAKE_BUILD_TYPE MATCHES "Release")
#   set(RUNTIME_OUTPUT_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE})
# endif()

# if(NOT EXISTS "${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}/glfw3.dll")
#   file(COPY ${CMAKE_SOURCE_DIR}/third/build/Glfw/bin/glfw3.dll DESTINATION "${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}")
# endif()
