add_library(Stm32UsbDevice INTERFACE)

target_include_directories(Stm32UsbDevice
INTERFACE
    ${STM32_USB_DEVICE_SOURCE_DIR}/Core/Inc
)

file(GLOB_RECURSE Stm32UsbDevice_HEADERS "${STM32_USB_DEVICE_SOURCE_DIR}/Core/Inc/*.h")
file(GLOB_RECURSE Stm32UsbDevice_SOURCES "${STM32_USB_DEVICE_SOURCE_DIR}/Core/Src/*.c")
list(FILTER Stm32UsbDevice_SOURCES EXCLUDE REGEX ".*_template.c$")
list(FILTER Stm32UsbDevice_HEADERS EXCLUDE REGEX ".*_template.h$")

target_sources(Stm32UsbDevice
INTERFACE 
    ${Stm32UsbDevice_HEADERS}
    ${Stm32UsbDevice_SOURCES}
)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Stm32UsbDevice
REQUIRED_VARS 
    Stm32UsbDevice_HEADERS 
    Stm32UsbDevice_SOURCES
)