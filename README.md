# FPGA-Microcontroller Accelerated Matrix Multiplication
Authors: Jack Burton, Ha Nguyen, Michael Zhou, Camran Aduli

This project demonstrates accelerated matrix multiplication on FPGAs;
it stores two 3x3 matrices on a microcontroller, and serially streams them to
an FPGA which multiplies them and visualizes them along with their product matrix.

For more details, see the report.pdf _coming soon_

This was a final project for [ES4: Introduction to Digital Logic](https://www.ece.tufts.edu/es/4/) 
at Tufts University, Fall 2024.

## Description

Matrix multiplication can be computationally expensive on modern computers, requiring
repeated transfers between memory levels and heavy processor use. FPGAs, on the other hand,
often feature various embedded DSP blocks, which can all perform math operations in parallel.
Utilizing these blocks for matrix multiplication can significantly speed up the procedure, and
our goal was to make a proof-of-concept of this idea. The two 3x3 matrices consist of 8-bit
unsigned integers, and are specified as global variables in the C or MicroPython project.

### Matrix Sender
The matrix sending script was written for a Raspberry Pi Pico, and
we created equivalently functioning versions in MicroPython and embedded C.
Both projects contain the two 3x3 matrices of 8-bit unsigned integers as global variables,
and they convert these into matrices with the numbers' binary representations. These
matrices are then serially streamed to the FPGA over a clock signal generated on
a separate pin.

See the Matrix_Sender_C or Matrix_Sender_Python folders for more specific information on each version.

### FPGA Multiplier and VGA Display
The FPGA receives the matrix values and utilizes the DSPs to multiply the two matrices.
These two input matrices, as well as the product, are then streamed to VGA, where each matrix
is shown as 3x3 RGB boxes. VGA RGB is limited to 6-bits, so only 2^6 can be represented visually even
though 2^8 is supported.

## Devices and Specifications
The MicroPython sender should be portable to other microcontrollers, but the
embedded C version relies on the Pico SDK, so it may require rewriting for other controllers.
The following devices/software were used for development:

**Microcontroller:** Raspberry Pi Pico

**FPGA:** Lattice iCE40UP5K (UPDuino v3.1)

**Software**
* [PyCharm 2024.2](https://www.jetbrains.com/pycharm/)
* [Raspberry Pi Pico SDK 2.1.0](https://github.com/raspberrypi/pico-sdk)
* [MicroPython for PyCharm](https://plugins.jetbrains.com/plugin/9777-micropython)
* [Lattice Radiant 2024.2](https://www.latticesemi.com/latticeradiant)

## Usage
1. Set up the pin connections between the FPGA and microcontroller according to
your Matrix Sender pinout configuration (see their READMEs)

2. Flash the microcontroller with the Matrix Sending software for your desired
matrix

3. Flash the FPGA with the multiplier-display project, and connect the appropriate
VGA pins. If this flash works properly, you should see Sierpenski triangles as the
background with a blank space in the middle for the matrices to populate.

4. If all connections are wired properly, when you reboot or reflash the microcontroller
you should see the two input matrices and their product in that order, top to bottom.

This entire matrix multiplication occurs in 1 clock cycle, utilizing all of the FPGA's DSPs in parallel,
whereas each multiply operation on its own takes 3-7 clock cycles on an average
modern CPU.

## Acknowledgments
[How to Use PyCharm with Raspberry Pi Pico W and MicroPython](https://www.instructables.com/How-to-Use-PyCharm-With-Raspberry-Pi-Pico-W-and-Mi/)

[Pico SDK Documentation](https://www.raspberrypi.com/documentation/pico-sdk/)

[MicroPython Documentation](https://docs.micropython.org/en/latest/)

[UPDuino Documentation](https://upduino.readthedocs.io/en/latest/introduction/introduction.html)

Prof. Bell and the amazing TAs for ES4!

