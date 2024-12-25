#include "VulkanDevice.h"
#include "VulkanTools.h"
namespace Tornado
{
    auto VulkanDevice::New(const VulkanInstance::Ptr& instancePtr)->Ptr
    {
        return std::make_shared<VulkanDevice>(instancePtr);
    }

    VulkanDevice::VulkanDevice(const VulkanInstance::Ptr& instancePtr)
    {
        auto _enabledLayerNames     = getEnabledLayerNames();
        auto _enabledExtensionNames = getEnabledExtensionNames();
        auto _enabledFeatures       = getEnabledFeatures();

        VkDeviceQueueCreateInfo _deviceQueueCreateInfo{};
        _deviceQueueCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO;
        _deviceQueueCreateInfo.pNext = nullptr;
        _deviceQueueCreateInfo.flags = 0;
        _deviceQueueCreateInfo.queueFamilyIndex;
        _deviceQueueCreateInfo.queueCount;
        _deviceQueueCreateInfo.pQueuePriorities;

        VkDeviceCreateInfo _deviceCreateInfo{};
        _deviceCreateInfo.sType = VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO;
        _deviceCreateInfo.pNext = nullptr;
        _deviceCreateInfo.flags = 0;
        _deviceCreateInfo.queueCreateInfoCount = 1;
        _deviceCreateInfo.pQueueCreateInfos = &_deviceQueueCreateInfo;
        _deviceCreateInfo.enabledLayerCount = (uint32_t)_enabledLayerNames.size();
        _deviceCreateInfo.ppEnabledLayerNames = _enabledLayerNames.data();
        _deviceCreateInfo.enabledExtensionCount = (uint32_t)_enabledExtensionNames.size();
        _deviceCreateInfo.ppEnabledExtensionNames = _enabledExtensionNames.data();
        _deviceCreateInfo.pEnabledFeatures = &_enabledFeatures;

        VK_CHECK_RESULT(vkCreateDevice(m_selectedPhysicalDevice, &_deviceCreateInfo, nullptr, &m_device));
    }

    VulkanDevice::~VulkanDevice()
    {

    }

    auto VulkanDevice::getEnabledLayerNames()->std::vector<const char*>
    {
        std::vector<const char*> enabledLayerNames;


        return enabledLayerNames;
    }

    auto VulkanDevice::getEnabledExtensionNames()->std::vector<const char*>
    {
        std::vector<const char*> enabledExtensionNames;


        return enabledExtensionNames;
    }

    auto VulkanDevice::getEnabledFeatures()->VkPhysicalDeviceFeatures
    {
        return m_enabledFeatures;
    }



}