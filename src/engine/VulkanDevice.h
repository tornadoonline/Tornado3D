#pragma once
#include "vulkan/vulkan.hpp"
#include <memory>
#include <vector>

#include "VulkanInstance.h"

namespace Tornado
{
    class VulkanDevice final
    {
    public:
        using Ptr = std::shared_ptr<VulkanDevice>;

        auto New(const VulkanInstance::Ptr&)->Ptr;
        VulkanDevice(const VulkanInstance::Ptr&);
        ~VulkanDevice();

        auto getEnabledLayerNames()->std::vector<const char*>;
        auto getEnabledExtensionNames()->std::vector<const char*>;
        auto getEnabledFeatures()->VkPhysicalDeviceFeatures;

    protected:

    private:
        VkDevice m_device = VK_NULL_HANDLE;
        VkPhysicalDeviceFeatures m_enabledFeatures;


        VkPhysicalDevice m_selectedPhysicalDevice = VK_NULL_HANDLE;
    };
}