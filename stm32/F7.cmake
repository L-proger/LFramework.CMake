


set(MCU_ARCH cortex-m7)
set(MCU_FLOAT_ABI softfp)
set(MCU_FPU fpv4-sp-d16)


set(COMMON_COMPILE_FLAGS -mcpu=${MCU_ARCH} -mthumb -mfloat-abi=${MCU_FLOAT_ABI} -mfpu=${MCU_FPU})
set(C_CXX_COMPILE_FLAGS  -ffunction-sections -fdata-sections -fsigned-char -g -fmessage-length=0)

if(NOT (TARGET STM32::F7))
    add_library(STM32::F7 INTERFACE IMPORTED)

    target_compile_options(STM32::F7 INTERFACE 
        --sysroot="${TOOLCHAIN_SYSROOT}"
        ${COMMON_COMPILE_FLAGS}
    )

    #target_compile_options(STM32::F7 INTERFACE $<$<COMPILE_LANGUAGE:ASM>:-x assembler-with-cpp>)
    target_compile_options(STM32::F7 INTERFACE $<$<COMPILE_LANGUAGE:C>:${C_CXX_COMPILE_FLAGS}>)
    target_compile_options(STM32::F7 INTERFACE $<$<COMPILE_LANGUAGE:CXX>:${C_CXX_COMPILE_FLAGS}>)
    target_compile_options(STM32::F7 INTERFACE $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics>)

    target_link_options(STM32::F7 INTERFACE 
        --sysroot="${TOOLCHAIN_SYSROOT}"
        ${COMMON_COMPILE_FLAGS}
        ${C_CXX_COMPILE_FLAGS} 
        LINKER:-gc-sections 
    )
    
   
    target_link_options(STM32::F7 INTERFACE $<$<CONFIG:RELEASE>:LINKER:--undefined=vTaskSwitchContext,--undefined=HardFault_HandlerC,-undefined=_realloc_r>)

    target_compile_definitions(STM32::F7 INTERFACE 
        STM32F7
        "__weak=__attribute__((weak))"
        "__packed=__attribute__((__packed__))"
    )
endif()