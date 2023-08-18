add_library(Stm32FreeRtos INTERFACE)

target_include_directories(Stm32FreeRtos
INTERFACE
    ${STM32_FREERTOS_SOURCE_DIR}/Source
    ${STM32_FREERTOS_SOURCE_DIR}/Source/include
    ${STM32_FREERTOS_SOURCE_DIR}/Source/CMSIS_RTOS_V2
    ${STM32_FREERTOS_SOURCE_DIR}/Source/portable/GCC/ARM_CM7/r0p1
)

file(GLOB_RECURSE Stm32FreeRtos_HEADERS 
    "${STM32_FREERTOS_SOURCE_DIR}/Source/CMSIS_RTOS_V2/*.h" 
    "${STM32_FREERTOS_SOURCE_DIR}/Source/include/**/*.h"
    "${STM32_FREERTOS_SOURCE_DIR}/Source/portable/GCC/ARM_CM7/*.h"
)

file(GLOB_RECURSE Stm32FreeRtos_SOURCES 
    "${STM32_FREERTOS_SOURCE_DIR}/Source/CMSIS_RTOS_V2/*.c"
    "${STM32_FREERTOS_SOURCE_DIR}/Source/portable/GCC/ARM_CM7/*.c"
)

file(GLOB Stm32FreeRtos_SOURCES2 "${STM32_FREERTOS_SOURCE_DIR}/Source/*.c")
list(APPEND Stm32FreeRtos_SOURCES ${Stm32FreeRtos_SOURCES2} ${STM32_FREERTOS_SOURCE_DIR}/Source/portable/MemMang/heap_4.c)

target_sources(Stm32FreeRtos 
INTERFACE 
    ${Stm32FreeRtos_HEADERS} 
    ${Stm32FreeRtos_SOURCES}
)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Stm32FreeRtos
REQUIRED_VARS 
    Stm32FreeRtos_HEADERS 
    Stm32FreeRtos_SOURCES
)