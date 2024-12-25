###########################################################
#  author: online
#  version: 1.0
#  library: stb
#  date: 20241125
###########################################################

set(Vulkan_SDK_DIR  "C:/VulkanSDK/1.3.280.0")
list(APPEND CMAKE_PREFIX_PATH ${Vulkan_SDK_DIR})
find_package(Vulkan)

# message(STATUS ${Vulkan_INCLUDE_DIRS})
# message(STATUS ${Vulkan_LIBRARIES})

include_directories(${Vulkan_INCLUDE_DIRS})