add_library(Stm32F7CmsisCore INTERFACE)

target_include_directories(Stm32F7CmsisCore
INTERFACE
    ${Stm32F7CmsisCore_SOURCE_DIR}/Core/Include
    ${Stm32F7CmsisCore_SOURCE_DIR}/RTOS2/Include
)


file(GLOB_RECURSE Stm32F7CmsisCore_HEADERS "${Stm32F7CmsisCore_SOURCE_DIR}/Core/Include/*.h" "${Stm32F7CmsisCore_SOURCE_DIR}/RTOS2/Include/*.h")
#file(GLOB_RECURSE cmsis_device_f7_SOURCES1 "${cmsis_device_f7_SOURCE_DIR}/Src/**/*.c")

target_sources(Stm32F7CmsisCore 
INTERFACE 
    ${Stm32F7CmsisCore_HEADERS1}
)



include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Stm32F7CmsisCore
REQUIRED_VARS 
    Stm32F7CmsisCore_HEADERS 
    #Stm32F7CmsisCore_SOURCES
)
