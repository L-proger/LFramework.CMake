add_library(Stm32F7FreeRtos INTERFACE)

target_include_directories(Stm32F7FreeRtos
INTERFACE
    ${Stm32F7FreeRtos_SOURCE_DIR}/Source
    ${Stm32F7FreeRtos_SOURCE_DIR}/Source/include
    ${Stm32F7FreeRtos_SOURCE_DIR}/Source/CMSIS_RTOS_V2
    ${Stm32F7FreeRtos_SOURCE_DIR}/Source/portable/GCC/ARM_CM7/r0p1
)

file(GLOB_RECURSE Stm32F7FreeRtos_HEADERS 
    "${Stm32F7FreeRtos_SOURCE_DIR}/Source/CMSIS_RTOS_V2/*.h" 
    "${Stm32F7FreeRtos_SOURCE_DIR}/Source/include/**/*.h"
    "${Stm32F7FreeRtos_SOURCE_DIR}/Source/portable/GCC/ARM_CM7/*.h"
)

file(GLOB_RECURSE Stm32F7FreeRtos_SOURCES 
    "${Stm32F7FreeRtos_SOURCE_DIR}/Source/CMSIS_RTOS_V2/*.c"
    "${Stm32F7FreeRtos_SOURCE_DIR}/Source/portable/GCC/ARM_CM7/*.c"
)

file(GLOB Stm32F7FreeRtos_SOURCES2 "${Stm32F7FreeRtos_SOURCE_DIR}/Source/*.c")
list(APPEND Stm32F7FreeRtos_SOURCES ${Stm32F7FreeRtos_SOURCES2} ${Stm32F7FreeRtos_SOURCE_DIR}/Source/portable/MemMang/heap_4.c)

target_sources(Stm32F7FreeRtos 
INTERFACE 
    ${Stm32F7FreeRtos_HEADERS} 
    ${Stm32F7FreeRtos_SOURCES}
)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Stm32F7FreeRtos
REQUIRED_VARS 
    Stm32F7FreeRtos_HEADERS 
    Stm32F7FreeRtos_SOURCES
)