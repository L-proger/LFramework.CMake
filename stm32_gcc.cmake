if(NOT DEFINED TOOLCHAIN_DIR)
    if(CMAKE_HOST_UNIX)
        file(GLOB TOOLCHAIN_DIRS "/usr/local/gcc-arm-none-eabi-*")
    else()
        file(GLOB TOOLCHAIN_DIRS "C:/Program Files (x86)/GNU Arm Embedded Toolchain/*" "C:/Program Files (x86)/Arm GNU Toolchain arm-none-eabi/*")
    endif()
   
    if(TOOLCHAIN_DIRS)
        list(GET TOOLCHAIN_DIRS 0 TOOLCHAIN_DIR)
        message("FOUND ARM GCC Toolchain Directory: ${TOOLCHAIN_DIR}")
    endif()
endif()


GET_FILENAME_COMPONENT(STM32_CMAKE_DIR ${CMAKE_CURRENT_LIST_FILE} DIRECTORY)
list(APPEND CMAKE_MODULE_PATH ${STM32_CMAKE_DIR})

set(EXE_SUFFIX "")

set(CMAKE_LIBRARY_ARCHITECTURE arm-none-eabi)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_SYSTEM_VERSION 1)


set(TOOLCHAIN_PREFIX "${CMAKE_LIBRARY_ARCHITECTURE}-")
set(TOOLCHAIN_BIN_PATH "${TOOLCHAIN_DIR}/bin")
set(TOOLCHAIN_INC_PATH "${TOOLCHAIN_DIR}/${CMAKE_LIBRARY_ARCHITECTURE}/include")
set(TOOLCHAIN_LIB_PATH "${TOOLCHAIN_DIR}/${CMAKE_LIBRARY_ARCHITECTURE}/lib")
set(TOOLCHAIN_SYSROOT  "${TOOLCHAIN_DIR}/${CMAKE_LIBRARY_ARCHITECTURE}")




find_program(CMAKE_C_COMPILER NAMES ${TOOLCHAIN_PREFIX}gcc HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_CXX_COMPILER NAMES ${TOOLCHAIN_PREFIX}g++ HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_ASM_COMPILER NAMES ${TOOLCHAIN_PREFIX}gcc HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_CPPFILT NAMES ${TOOLCHAIN_PREFIX}c++filt HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_DEBUGGER NAMES ${TOOLCHAIN_PREFIX}gdb HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_OBJCOPY NAMES ${TOOLCHAIN_PREFIX}objcopy HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_OBJDUMP NAMES ${TOOLCHAIN_PREFIX}objdump HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_SIZE NAMES ${TOOLCHAIN_PREFIX}size HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_AS NAMES ${TOOLCHAIN_PREFIX}as HINTS ${TOOLCHAIN_BIN_PATH})
find_program(CMAKE_AR NAMES ${TOOLCHAIN_PREFIX}ar HINTS ${TOOLCHAIN_BIN_PATH})


set(CMAKE_EXECUTABLE_SUFFIX_C   .elf)
set(CMAKE_EXECUTABLE_SUFFIX_CXX .elf)
set(CMAKE_EXECUTABLE_SUFFIX_ASM .elf)




set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)



#set(COMMON_FLAGS "-mcpu=${MCU_ARCH} -mthumb -mfloat-abi=${MCU_FLOAT_ABI} -mfpu=${MCU_FPU} -ffunction-sections -fdata-sections -fsigned-char -g  -fmessage-length=0 -D__weak=__attribute__((weak)) -D__packed=__attribute__((__packed__))")
#
#set(CMAKE_CXX_FLAGS "${COMMON_FLAGS} -std=c++17 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics" CACHE INTERNAL "cxx compiler flags")
#set(CMAKE_C_FLAGS "${COMMON_FLAGS} -std=c11" CACHE INTERNAL "c compiler flags")
#
#set(CMAKE_EXE_LINKER_FLAGS "-Wl,-gc-sections -specs=nosys.specs -specs=nano.specs" CACHE INTERNAL "exe compiler flags")
#SET(CMAKE_ASM_FLAGS "-mthumb -mcpu=${MCU_ARCH} -mfpu=${MCU_FPU} -mfloat-abi=${MCU_FLOAT_ABI} -x assembler-with-cpp" CACHE INTERNAL "asm compiler flags")
#
#
#include(fetch_utils)



if(NOT (TARGET GCC::Specs::NoSys))
    add_library(GCC::Specs::NoSys INTERFACE IMPORTED)
    target_link_options(GCC::Specs::NoSys INTERFACE 
        -specs=nosys.specs
    )
endif()

if(NOT (TARGET GCC::Specs::Nano))
    add_library(GCC::Specs::Nano INTERFACE IMPORTED)
    target_link_options(GCC::Specs::Nano INTERFACE 
        -specs=nano.specs
    )
endif()

function(gcc_add_linker_script TARGET VISIBILITY SCRIPT_PATH)
    get_filename_component(SCRIPT_PATH "${SCRIPT_PATH}" ABSOLUTE)
    target_link_options(${TARGET} ${VISIBILITY} -T "${SCRIPT_PATH}")
endfunction()

function(gcc_generate_bin_file TargetName)
    add_custom_command(
        TARGET ${TargetName}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E echo "Generating flash image ${TargetName}.bin"
        COMMAND ${CMAKE_OBJCOPY} -O binary ${TargetName}${CMAKE_EXECUTABLE_SUFFIX_C} ${TargetName}.bin
        BYPRODUCTS ${TargetName}.bin
    )
endfunction()



function(gcc_print_target_size TargetName)
    add_custom_command(
        TARGET ${TargetName}
        POST_BUILD
	    COMMAND ${CMAKE_COMMAND} -E echo "Invoking: GCC Print Size"
        COMMAND ${CMAKE_SIZE} ${TargetName}${CMAKE_EXECUTABLE_SUFFIX_C}
    )
endfunction()
