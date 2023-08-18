add_library(Stm32CmsisDevice INTERFACE)

target_include_directories(Stm32CmsisDevice
INTERFACE
    ${STM32_CMSIS_DEVICE_SOURCE_DIR}/Include
)

file(GLOB_RECURSE Stm32CmsisDevice_HEADERS "${STM32_CMSIS_DEVICE_SOURCE_DIR}/Include/*.h")

set(Stm32CmsisDevice_SOURCES 
    ${STM32_CMSIS_DEVICE_SOURCE_DIR}/Source/Templates/system_stm32f7xx.c
    ${STM32_CMSIS_DEVICE_SOURCE_DIR}/Source/Templates/gcc/startup_stm32f746xx.s
)

target_compile_definitions(Stm32CmsisDevice
INTERFACE
    STM32${MCU_FAMILY}${MCU_CORE}${MCU_LINE}xx
)


target_sources(Stm32CmsisDevice 
INTERFACE 
    ${Stm32CmsisDevice_HEADERS}
    ${Stm32CmsisDevice_SOURCES}
)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Stm32CmsisDevice
REQUIRED_VARS 
    Stm32CmsisDevice_HEADERS 
    Stm32CmsisDevice_SOURCES
)