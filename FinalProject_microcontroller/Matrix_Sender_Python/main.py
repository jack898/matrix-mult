'''
Matrix Stream
12/10/24
Purpose: 
 * Sends two 3x3 matrices of 8-bit numbers to
   a peripheral serially as 8 bit binary values. 
 * Produces master clock, practically limited to ~40kHz on the Pi Pico due 
   to Python execution time constraints

Authors: Jack Burton, Ha Nguyen, Michael Zhou, Camran Aduli
'''
import machine
from machine import Timer, Pin
import time


# Overclock Pi Pico to 280MHz from 125MHz
# NOTE: May need to adjust overclocking based on your microcontroller
machine.freq(280_000_000)  



# Converts array of base-10 numbers into array of 8-bit binary representations
def num_to_bit_array(num_array):
    bit_array = [int(bit) for num in num_array for bit in f"{num:08b}"]
    return bit_array

# Converts array of 8-bit binary representations to array of base-10 numbers
def bit_array_to_numbers(bit_array):
    grouped_bits = [bit_array[i:i + 8] for i in range(0, len(bit_array), 8)]
    numbers = [int("".join(map(str, bits)), 2) for bits in grouped_bits]
    return numbers


# Arrays of base-10 numbers to multiply
A_nums = [1, 0, 0, 0, 0, 1, 0, 1, 60]
B_nums = [1, 0, 0, 0, 0, 1, 0, 1, 0]

# Convert above matrices to bit form
B = num_to_bit_array(B_nums)
A = num_to_bit_array(A_nums)

# Counter for reading out values
counter = 0

''' 
PIN MAPPINGS
    pin_out: Serial transmission of matrix values
    pin_clk: Master clock
    pin_reset: Reset signal
    pin_start: Start signal
'''
pin_out = Pin(15, Pin.OUT)
pin_clk = Pin(21, Pin.OUT)
pin_reset = Pin(13, Pin.OUT)
pin_start = Pin(12, Pin.OUT)


# Initialization Logic
pin_reset.value(1)
pin_start.value(0)
time.sleep(0.1)
pin_start.value(1)
time.sleep(1)

# Sends matrix values by bit on each clock cycle, and produces clock signal
while True:
    # Resets on first increment
    pin_reset.value(counter == 0)

    # Sending each matrix over by bit
    if counter < 73:
        pin_out.value(A[counter-1])
    elif counter < 145:
        pin_out.value(B[counter-73])

    # Increment counter and iterate clock one cycle
    # Clock frequency is limited to ~40kHz maximum on Pi Pico due to while 
    # loop overhead
    counter = counter + 1
    pin_val = not pin_clk.value()
    pin_clk.value(pin_val)
    pin_clk.value(not pin_val)
