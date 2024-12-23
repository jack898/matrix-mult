# CMakeLists.txt

# Minimum CMake version required
cmake_minimum_required(VERSION 3.13)


# Include the Pico SDK
include(pico_sdk_import.cmake)

# Set the project name
project(matrix_mult)



# Initialize the Pico SDK
pico_sdk_init()

# Add the executable
add_executable(main
    main.c
)

# Link the Pico SDK to the executable
target_link_libraries(main pico_stdlib)

# Enable USB and disable UART output (optional)
pico_enable_stdio_usb(main 1)
pico_enable_stdio_uart(main 0)

# Specify the output for the .uf2 file
pico_add_extra_outputs(main)
