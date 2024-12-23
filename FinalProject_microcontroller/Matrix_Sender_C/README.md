# C Matrix Sender

This embedded C project stores two 3x3 matrices in arrays of 8-bit unsigned integers, converts them to their 8-bit binary representations, and serially streams the values to an FPGA over a controller clock which it generates.

## Usage
### Precompiled Options
Compiled for the Raspberry Pi Pico
1. Hold down the BOOTSEL button while plugging in the Pico
2. Upload the desired uf2 file to the Pico
3. Attach outputs per the pinout and view the results
### Compilation
1. Download required build tools and libraries:
```sudo apt install cmake gcc-arm-none-eabi libnewlib-arm-none-eabi build-essential1```
2. Download the [Pico SDK](https://github.com/raspberrypi/pico-sdk)
3. Change the PICO_SDK_PATH environment variable to the path to the pico-sdk directory
4. Modify main.c as desired, setting the global pin mapping, frequency, and input matrices
5. Make a build directory and CD into it
6. Run cmake ..
7. Run make, and the uf2 should be generated

## Acknowledgments
[How to Program Raspberry Pi Pico with the Arduino IDE](https://www.tomshardware.com/how-to/program-raspberry-pi-pico-with-arduino-ide), for setting up the Pico SDK environment for compilation