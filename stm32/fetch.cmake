if (DEFINED STM32_DEVICE AND NOT STM32_DEVICE STREQUAL "")
    string(REGEX MATCH "STM(32|8)(F|L|H|W|U)([0-9])([^A-Z]+)([A-Z])(.)" STM32_DEVICE_ ${STM32_DEVICE}])
    set(MCU_FAMILY ${CMAKE_MATCH_2})
    set(MCU_CORE ${CMAKE_MATCH_3})
    set(MCU_LINE ${CMAKE_MATCH_4})

    message("MCU_FAMILY: ${MCU_FAMILY}")
    message("MCU_CORE: ${MCU_CORE}")
    message("MCU_LINE: ${MCU_LINE}")

    set(STM32_FAMILY_EX "${MCU_FAMILY}${MCU_CORE}" )

    message("STM32_FAMILY_EX: ${STM32_FAMILY_EX}")
else()
    message("STM32_DEVICE not defined")
endif()



set(STM32_FAMILIES                     F7           )
set(STM32_HAL_DEFAULT_VERSION          v1.3.0       )
set(STM32_FREERTOS_DEFAULT_VERSION     v10.2.1      )
set(STM32_CMSIS_DEVICE_DEFAULT_VERSION v1.2.8       )

set(STM32_CMSIS_CORE_DEFAULT_VERSION   v5.6.0       )

set(STM32_USB_DEVICE_DEFAULT_VERSION   v2.11.2      )
set(STM32_USB_HOST_DEFAULT_VERSION     v3.5.1       )

include(FetchContent)

FetchContent_Declare(stm32_usb_host
    GIT_REPOSITORY https://github.com/STMicroelectronics/stm32_mw_usb_host.git
    GIT_TAG ${STM32_USB_HOST_DEFAULT_VERSION}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    GIT_PROGRESS TRUE
)

FetchContent_Declare(stm32_usb_device
    GIT_REPOSITORY https://github.com/STMicroelectronics/stm32_mw_usb_device.git
    GIT_TAG ${STM32_USB_DEVICE_DEFAULT_VERSION}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    GIT_PROGRESS TRUE
)

function(FetchStm32UsbDevice)
    string(TOLOWER ${STM32_FAMILY_EX} STM32_FAMILY_EX_LOWER_CASE)
    FetchContent_MakeAvailable(stm32_usb_device)
    set(STM32_USB_DEVICE_SOURCE_DIR ${stm32_usb_device_SOURCE_DIR} PARENT_SCOPE)
endfunction()

function(FetchStm32UsbHost)
    string(TOLOWER ${STM32_FAMILY_EX} STM32_FAMILY_EX_LOWER_CASE)
    FetchContent_MakeAvailable(stm32_usb_host)
    set(STM32_USB_HOST_SOURCE_DIR ${stm32_usb_host_SOURCE_DIR} PARENT_SCOPE)
endfunction()



FetchContent_Declare(stm32_cmsis_core
    GIT_REPOSITORY https://github.com/STMicroelectronics/cmsis_core.git
    GIT_TAG ${STM32_CMSIS_CORE_DEFAULT_VERSION}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    GIT_PROGRESS TRUE
)


set(ARRAY_INDEX 0)
foreach(FAMILY ${STM32_FAMILIES})
    string(TOLOWER ${FAMILY} STM_FAMILY_LOWER_CASE)

    if (DEFINED STM32_HAL_VERSION AND NOT STM32_HAL_VERSION STREQUAL "")

    else()
        list(GET STM32_HAL_DEFAULT_VERSION ${ARRAY_INDEX} STM32_HAL_VERSION)
    endif()
    message("STM32_HAL_VERSION: ${STM32_HAL_VERSION}")

    if (DEFINED STM32_FREERTOS_VERSION AND NOT STM32_FREERTOS_VERSION STREQUAL "")

    else()
        list(GET STM32_FREERTOS_DEFAULT_VERSION ${ARRAY_INDEX} STM32_FREERTOS_VERSION)
    endif()
    message("STM32_FREERTOS_VERSION: ${STM32_FREERTOS_VERSION}")

    
    if (DEFINED STM32_CMSIS_DEVICE_VERSION AND NOT STM32_CMSIS_DEVICE_VERSION STREQUAL "")

    else()
        list(GET STM32_CMSIS_DEVICE_DEFAULT_VERSION ${ARRAY_INDEX} STM32_CMSIS_DEVICE_VERSION)
    endif()
    message("STM32_CMSIS_DEVICE_VERSION: ${STM32_CMSIS_DEVICE_VERSION}")

    #CMSIS Device
    FetchContent_Declare(stm32_cmsis_device_${STM_FAMILY_LOWER_CASE}
        GIT_REPOSITORY https://github.com/STMicroelectronics/cmsis_device_${STM_FAMILY_LOWER_CASE}.git
        GIT_TAG ${STM32_CMSIS_DEVICE_VERSION}
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        GIT_PROGRESS TRUE
    )

    #Hal
    FetchContent_Declare(stm32_hal_${STM_FAMILY_LOWER_CASE}                        
        GIT_REPOSITORY https://github.com/STMicroelectronics/stm32${STM_FAMILY_LOWER_CASE}xx_hal_driver.git
        GIT_TAG ${STM32_HAL_VERSION}
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        GIT_PROGRESS TRUE
    )

    #FreeRTOS
    FetchContent_Declare(stm32_freertos
        GIT_REPOSITORY https://github.com/STMicroelectronics/stm32_mw_freertos.git
        GIT_TAG ${STM32_FREERTOS_VERSION}
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        GIT_PROGRESS TRUE
    )

    math(EXPR ARRAY_INDEX "${ARRAY_INDEX} + 1")
endforeach()






function(FetchStm32Hal)
    string(TOLOWER ${STM32_FAMILY_EX} STM32_FAMILY_EX_LOWER_CASE)
    FetchContent_MakeAvailable(stm32_hal_${STM32_FAMILY_EX_LOWER_CASE} )
    set(STM32_HAL_SOURCE_DIR ${stm32_hal_${STM32_FAMILY_EX_LOWER_CASE}_SOURCE_DIR} PARENT_SCOPE)
endfunction()

function(FetchStm32FreeRtos)
    FetchContent_MakeAvailable(stm32_freertos)
    set(STM32_FREERTOS_SOURCE_DIR ${stm32_freertos_SOURCE_DIR} PARENT_SCOPE)
endfunction()

function(FetchStm32CmsisDevice)
    string(TOLOWER ${STM32_FAMILY_EX} STM32_FAMILY_EX_LOWER_CASE)
    FetchContent_MakeAvailable(stm32_cmsis_device_${STM32_FAMILY_EX})
    set(STM32_CMSIS_DEVICE_SOURCE_DIR ${stm32_cmsis_device_${STM32_FAMILY_EX_LOWER_CASE}_SOURCE_DIR} PARENT_SCOPE)
endfunction()

function(FetchStm32CmsisCore)
    FetchContent_MakeAvailable(STM32_CMSIS_CORE)
    set(STM32_CMSIS_CORE_SOURCE_DIR ${stm32_cmsis_core_SOURCE_DIR} PARENT_SCOPE)
endfunction()
