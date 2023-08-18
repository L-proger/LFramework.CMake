
include(FetchContent)
FetchContent_Declare(Stm32F7Hal                           
    GIT_REPOSITORY https://github.com/STMicroelectronics/stm32f7xx_hal_driver.git
    GIT_TAG v1.3.0
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    GIT_PROGRESS TRUE
)

FetchContent_Declare(Stm32F7FreeRtos
    GIT_REPOSITORY https://github.com/STMicroelectronics/stm32_mw_freertos.git
    GIT_TAG v10.2.1
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    GIT_PROGRESS TRUE
)

FetchContent_Declare(Stm32F7CmsisDevice
    GIT_REPOSITORY https://github.com/STMicroelectronics/cmsis_device_f7.git
    GIT_TAG v1.2.8
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    GIT_PROGRESS TRUE
)

FetchContent_Declare(Stm32F7CmsisCore
    GIT_REPOSITORY https://github.com/STMicroelectronics/cmsis_core.git
    GIT_TAG v5.6.0_cm7
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    GIT_PROGRESS TRUE
)


function(FetchStm32F7Hal)
    FetchContent_MakeAvailable(Stm32F7Hal)
    string(TOLOWER Stm32F7Hal LOWER_NAME)
    set(Stm32F7Hal_SOURCE_DIR ${${LOWER_NAME}_SOURCE_DIR} PARENT_SCOPE)
    
endfunction()

function(FetchStm32F7FreeRtos)
    FetchContent_MakeAvailable(Stm32F7FreeRtos)
    string(TOLOWER Stm32F7FreeRtos LOWER_NAME)
    set(Stm32F7FreeRtos_SOURCE_DIR ${${LOWER_NAME}_SOURCE_DIR} PARENT_SCOPE)
endfunction()

function(FetchStm32F7CmsisDevice)
    FetchContent_MakeAvailable(Stm32F7CmsisDevice)
    string(TOLOWER Stm32F7CmsisDevice LOWER_NAME)
    set(Stm32F7CmsisDevice_SOURCE_DIR ${${LOWER_NAME}_SOURCE_DIR} PARENT_SCOPE)
endfunction()

function(FetchStm32F7CmsisCore)
    FetchContent_MakeAvailable(Stm32F7CmsisCore)
    string(TOLOWER Stm32F7CmsisCore LOWER_NAME)
    set(Stm32F7CmsisCore_SOURCE_DIR ${${LOWER_NAME}_SOURCE_DIR} PARENT_SCOPE)
endfunction()
