cmake_minimum_required(VERSION 4.1)
project(cvic_3 C ASM_NASM)

set(CMAKE_ASM_NASM_FLAGS "${CMAKE_ASM_NASM_FLAGS} -g -F dwarf")
set(CMAKE_C_STANDARD 11)

add_executable(cvic_3 main.c asm.asm)
