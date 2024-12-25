#pragma once
#include "vulkan/vulkan.hpp"
#include <memory>
#include <vector>

namespace Tornado
{
    class VulkanInstance final
    {
        friend class VulkanDevice;
    public:
        using Ptr = std::shared_ptr<VulkanInstance>;

        auto New()->Ptr;
        VulkanInstance();
        ~VulkanInstance();

        auto getEnabledLayerNames()->std::vector<const char*>;
        auto getEnabledExtensionNames()->std::vector<const char*>;

        auto getSelectedPhysicalDevice()->VkPhysicalDevice;

        auto getGraphicsQueueFamilyIndex() const->uint32_t;
        auto getComputeQueueFamilyIndex() const->uint32_t;
        auto getTransferQueueFamilyIndex() const->uint32_t;

    protected:

        void selectedPhysicalDevice();

    private:
        VkInstance m_instance = VK_NULL_HANDLE;
        VkPhysicalDevice m_selectedPhysicalDevice = VK_NULL_HANDLE;
        VkPhysicalDeviceProperties m_physicalDeviceProperties;
        VkPhysicalDeviceFeatures m_physicalDeviceFeatures;
        VkPhysicalDeviceMemoryProperties m_physicalDeviceMemoryProperties;
        std::vector<VkQueueFamilyProperties> m_queueFamilyProperties;

 
        std::vector<VkPhysicalDevice> m_physicalDevices;
    };
}