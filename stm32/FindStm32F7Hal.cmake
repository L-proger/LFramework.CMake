add_library(Stm32F7Hal INTERFACE)

target_include_directories(Stm32F7Hal
INTERFACE
    ${Stm32F7Hal_SOURCE_DIR}/Inc
    ${Stm32F7Hal_SOURCE_DIR}/Inc/Legacy
)

file(GLOB_RECURSE Stm32F7Hal_HEADERS "${Stm32F7Hal_SOURCE_DIR}/Inc/*.h")
file(GLOB_RECURSE Stm32F7Hal_SOURCES "${Stm32F7Hal_SOURCE_DIR}/Src/*.c")
list(FILTER Stm32F7Hal_SOURCES EXCLUDE REGEX ".*_template.c$")

target_sources(Stm32F7Hal
INTERFACE 
    ${Stm32F7Hal_HEADERS}
    ${Stm32F7Hal_SOURCES}
)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Stm32F7Hal
REQUIRED_VARS 
    Stm32F7Hal_HEADERS 
    Stm32F7Hal_SOURCES
)