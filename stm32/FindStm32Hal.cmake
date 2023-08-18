add_library(Stm32Hal INTERFACE)

target_include_directories(Stm32Hal
INTERFACE
    ${STM32_HAL_SOURCE_DIR}/Inc
    ${STM32_HAL_SOURCE_DIR}/Inc/Legacy
)

file(GLOB_RECURSE Stm32Hal_HEADERS "${STM32_HAL_SOURCE_DIR}/Inc/*.h")
file(GLOB_RECURSE Stm32Hal_SOURCES "${STM32_HAL_SOURCE_DIR}/Src/*.c")
list(FILTER Stm32Hal_SOURCES EXCLUDE REGEX ".*_template.c$")

target_sources(Stm32Hal
INTERFACE 
    ${Stm32Hal_HEADERS}
    ${Stm32Hal_SOURCES}
)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Stm32Hal
REQUIRED_VARS 
    Stm32Hal_HEADERS 
    Stm32Hal_SOURCES
)