add_library(Stm32CmsisCore INTERFACE)

target_include_directories(Stm32CmsisCore
INTERFACE
    ${STM32_CMSIS_CORE_SOURCE_DIR}/Core/Include
    ${STM32_CMSIS_CORE_SOURCE_DIR}/RTOS2/Include
)


file(GLOB_RECURSE Stm32CmsisCore_HEADERS "${STM32_CMSIS_CORE_SOURCE_DIR}/Core/Include/*.h" "${STM32_CMSIS_CORE_SOURCE_DIR}/RTOS2/Include/*.h")
#file(GLOB_RECURSE cmsis_device_f7_SOURCES1 "${cmsis_device_f7_SOURCE_DIR}/Src/**/*.c")

target_sources(Stm32CmsisCore 
INTERFACE 
    ${Stm32CmsisCore_HEADERS1}
)



include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Stm32CmsisCore
REQUIRED_VARS 
    Stm32CmsisCore_HEADERS 
    #Stm32CmsisCore_SOURCES
)
