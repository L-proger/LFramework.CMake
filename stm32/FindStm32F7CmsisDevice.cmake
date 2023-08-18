add_library(Stm32F7CmsisDevice INTERFACE)

target_include_directories(Stm32F7CmsisDevice
INTERFACE
    ${Stm32F7CmsisDevice_SOURCE_DIR}/Include

)

file(GLOB_RECURSE Stm32F7CmsisDevice_HEADERS "${Stm32F7CmsisDevice_SOURCE_DIR}/Include/*.h")

set(Stm32F7CmsisDevice_SOURCES 
    ${Stm32F7CmsisDevice_SOURCE_DIR}/Source/Templates/system_stm32f7xx.c
    ${Stm32F7CmsisDevice_SOURCE_DIR}/Source/Templates/gcc/startup_stm32f746xx.s
)

target_sources(Stm32F7CmsisDevice 
INTERFACE 
    ${Stm32F7CmsisDevice_HEADERS}
    ${Stm32F7CmsisDevice_SOURCES}
)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Stm32F7CmsisDevice
REQUIRED_VARS 
    Stm32F7CmsisDevice_HEADERS 
    Stm32F7CmsisDevice_SOURCES
)