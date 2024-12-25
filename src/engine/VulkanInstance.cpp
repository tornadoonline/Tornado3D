#include "VulkanInstance.h"
#include "VulkanTools.h"
namespace Tornado
{
    auto VulkanInstance::New()->Ptr
    {
        return std::make_shared<VulkanInstance>();
    }

    VulkanInstance::VulkanInstance()
    {

        auto _enabledLayerNames     = getEnabledLayerNames();
        auto _enabledExtensionNames = getEnabledExtensionNames();

        VkApplicationInfo _applicationInfo{};
        _applicationInfo.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
        _applicationInfo.pNext = 0;
        _applicationInfo.pApplicationName = "Tornado";
        _applicationInfo.applicationVersion = VK_MAKE_VERSION(1, 0, 0);
        _applicationInfo.pEngineName = "Tornado Engine";
        _applicationInfo.engineVersion = VK_MAKE_VERSION(1, 0, 0);
        _applicationInfo.apiVersion = VK_API_VERSION_1_3;

        VkInstanceCreateInfo _instanceCreateInfo{};
        _instanceCreateInfo.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
        _instanceCreateInfo.pNext = nullptr;
        _instanceCreateInfo.flags = 0;
        _instanceCreateInfo.pApplicationInfo = &_applicationInfo;
        _instanceCreateInfo.enabledLayerCount = (uint32_t)_enabledLayerNames.size();
        _instanceCreateInfo.ppEnabledLayerNames = _enabledLayerNames.data();
        _instanceCreateInfo.enabledExtensionCount = (uint32_t)_enabledExtensionNames.size();
        _instanceCreateInfo.ppEnabledExtensionNames = _enabledExtensionNames.data();
        VK_CHECK_RESULT(vkCreateInstance(&_instanceCreateInfo, nullptr, &m_instance));
        selectedPhysicalDevice();
        uint32_t _queueFamilyPropertyCount = 0;
        vkGetPhysicalDeviceQueueFamilyProperties(m_selectedPhysicalDevice, &_queueFamilyPropertyCount, nullptr);
        std::vector<VkQueueFamilyProperties> _queueFamilyProperties(_queueFamilyPropertyCount);
        vkGetPhysicalDeviceQueueFamilyProperties(m_selectedPhysicalDevice, &_queueFamilyPropertyCount, _queueFamilyProperties.data());
        m_queueFamilyProperties.swap(_queueFamilyProperties);
    }

    VulkanInstance::~VulkanInstance()
    {

    }

    auto VulkanInstance::getEnabledLayerNames()->std::vector<const char*>
    {
        std::vector<const char*> _enabledLayerNames;

        return _enabledLayerNames;
    }

    auto VulkanInstance::getEnabledExtensionNames()->std::vector<const char*>
    {
        std::vector<const char*> _enabledExtensionNames;

        return _enabledExtensionNames;
    }

    auto VulkanInstance::getSelectedPhysicalDevice()->VkPhysicalDevice
    {
        return m_selectedPhysicalDevice;
    }

    void VulkanInstance::selectedPhysicalDevice()
    {
        uint32_t _physicalDeviceCount = 0;
        vkEnumeratePhysicalDevices(m_instance, &_physicalDeviceCount, nullptr);
        std::vector<VkPhysicalDevice> _physicalDevices(_physicalDeviceCount);
        vkEnumeratePhysicalDevices(m_instance, &_physicalDeviceCount, _physicalDevices.data());
        m_physicalDevices.swap(_physicalDevices);

        // Todo
        m_selectedPhysicalDevice = m_physicalDevices[0];

        vkGetPhysicalDeviceProperties(m_selectedPhysicalDevice, &m_physicalDeviceProperties);
        vkGetPhysicalDeviceFeatures(m_selectedPhysicalDevice, &m_physicalDeviceFeatures);
        vkGetPhysicalDeviceMemoryProperties(m_selectedPhysicalDevice, &m_physicalDeviceMemoryProperties);

    }


    auto VulkanInstance::getGraphicsQueueFamilyIndex() const->uint32_t
    {
        for (auto i = 0; i < m_queueFamilyProperties.size(); i++) {
            if (((m_queueFamilyProperties[i].queueFlags & VK_QUEUE_COMPUTE_BIT) || (m_queueFamilyProperties[i].queueFlags & VK_QUEUE_TRANSFER_BIT))
                && ((m_queueFamilyProperties[i].queueFlags & VK_QUEUE_GRAPHICS_BIT) == 0)) {
                return i;
            }
        }

		for (auto i = 0; i < m_queueFamilyProperties.size(); i++) {
			if ((m_queueFamilyProperties[i].queueFlags & VK_QUEUE_GRAPHICS_BIT) == VK_QUEUE_GRAPHICS_BIT) {
				return i;
			}
		}

		throw std::runtime_error("Could not find a matching queue family index");

    }

    auto VulkanInstance::getComputeQueueFamilyIndex() const->uint32_t
    {
        for (auto i = 0; i < m_queueFamilyProperties.size(); i++) {
            if ((m_queueFamilyProperties[i].queueFlags & VK_QUEUE_COMPUTE_BIT)
                && ((m_queueFamilyProperties[i].queueFlags & VK_QUEUE_GRAPHICS_BIT) == 0)) {
                return i;
            }
        }

		for (auto i = 0; i < m_queueFamilyProperties.size(); i++) {
			if ((m_queueFamilyProperties[i].queueFlags & VK_QUEUE_COMPUTE_BIT) == VK_QUEUE_COMPUTE_BIT) {
				return i;
			}
		}

		throw std::runtime_error("Could not find a matching queue family index");
    }

    auto VulkanInstance::getTransferQueueFamilyIndex() const->uint32_t
    {
        for (auto i = 0; i < m_queueFamilyProperties.size(); i++) {
            if ((m_queueFamilyProperties[i].queueFlags & VK_QUEUE_TRANSFER_BIT)
                && ((m_queueFamilyProperties[i].queueFlags & VK_QUEUE_GRAPHICS_BIT) == 0)) {
                return i;
            }
        }

		for (auto i = 0; i < m_queueFamilyProperties.size(); i++) {
			if ((m_queueFamilyProperties[i].queueFlags & VK_QUEUE_TRANSFER_BIT) == VK_QUEUE_TRANSFER_BIT) {
				return i;
			}
		}

		throw std::runtime_error("Could not find a matching queue family index");
    }

}