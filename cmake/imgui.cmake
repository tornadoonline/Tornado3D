# ###########################################################
# #  author: online
# #  version: 1.0
# #  library: imgui
# #  date: 20240105
# ###########################################################

# set(Imgui_SRC_DIR  "${CMAKE_SOURCE_DIR}/third/imgui")
# set(Imgui_INSTALL_DIR  "${CMAKE_SOURCE_DIR}/third/build/imgui")

# option(USE_GLFW "Use Glfw Show" ON)
# option(USE_Win32 "Use Win32 Show" OFF)

# file(GLOB imgui_hpp_src ${Imgui_SRC_DIR}/*.h)
# file(GLOB imgui_cpp_src ${Imgui_SRC_DIR}/*.cpp)

# if(USE_GLFW)
#     set(imgui_impl_hpp_src ${Imgui_SRC_DIR}/backends/imgui_impl_glfw.h ${Imgui_SRC_DIR}/backends/imgui_impl_opengl3.h ${Imgui_SRC_DIR}/backends/imgui_extra_keys.h)
#     set(imgui_impl_cpp_src ${Imgui_SRC_DIR}/backends/imgui_impl_glfw.cpp ${Imgui_SRC_DIR}/backends/imgui_impl_opengl3.cpp)
# endif()
# if(USE_Win32)
# endif()

# add_library(imgui ${imgui_impl_cpp_src} ${imgui_impl_hpp_src} ${imgui_hpp_src} ${imgui_cpp_src})
# add_dependencies(imgui Tornado::Glfw)
# target_compile_definitions(imgui PUBLIC IMGUI_DISABLE_OBSOLETE_FUNCTIONS)

# # if(NOT EXISTS "${Imgui_INSTALL_DIR}/include/imgui.h")
#     foreach(imgui_hpp ${imgui_hpp_src})
#         file(COPY ${imgui_hpp} DESTINATION "${Imgui_INSTALL_DIR}/include")
#     endforeach()
#     foreach(imgui_impl_hpp ${imgui_impl_hpp_src})
#         file(COPY ${imgui_impl_hpp} DESTINATION "${Imgui_INSTALL_DIR}/include")
#     endforeach()
# # endif()

# if(NOT EXISTS  ${Imgui_SRC_DIR})
#     message(FATAL_ERROR "FATAL: Imgui not exist.")
# endif()

# add_library(Tornado::Imgui ALIAS imgui)
# set(Imgui_INCLUDE_DIR ${Imgui_INSTALL_DIR}/include)
# set(Imgui_LIBRARIES imgui)
# include_directories(${Imgui_INCLUDE_DIR})