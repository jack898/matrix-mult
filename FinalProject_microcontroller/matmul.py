# Basic Numpy Matrix Multiplier
# Author: Jack Burton
# Purpose: Time basic matrix multiplication in various ways in Python,
# to compare timing with our FPGA matrix multiplication.

import numpy as np
import timeit
import warnings

# Suppress overflow warnings
warnings.filterwarnings("ignore", category=RuntimeWarning)


# Creates two 3x3 matrices with random 8-bit integers
matrix_a = np.random.randint(0, 256, size=(3, 3), dtype=np.uint8)
matrix_b = np.random.randint(0, 256, size=(3, 3), dtype=np.uint8)

# Multiply matrices using nested for loops
def for_mult():
    result = np.zeros((3, 3), dtype=np.uint8)
    for i in range(3):
        for j in range(3):
            result[i, j] = (
                matrix_a[i, 0] * matrix_b[0, j] +
                matrix_a[i, 1] * matrix_b[1, j] +
                matrix_a[i, 2] * matrix_b[2, j]
            )
    return result

# Hard coding multiply accumulates
def hardcoded_mult():
    result = np.array([
        [
            matrix_a[0, 0] * matrix_b[0, 0] + matrix_a[0, 1] * matrix_b[1, 0] + matrix_a[0, 2] * matrix_b[2, 0],
            matrix_a[0, 0] * matrix_b[0, 1] + matrix_a[0, 1] * matrix_b[1, 1] + matrix_a[0, 2] * matrix_b[2, 1],
            matrix_a[0, 0] * matrix_b[0, 2] + matrix_a[0, 1] * matrix_b[1, 2] + matrix_a[0, 2] * matrix_b[2, 2]
        ],
        [
            matrix_a[1, 0] * matrix_b[0, 0] + matrix_a[1, 1] * matrix_b[1, 0] + matrix_a[1, 2] * matrix_b[2, 0],
            matrix_a[1, 0] * matrix_b[0, 1] + matrix_a[1, 1] * matrix_b[1, 1] + matrix_a[1, 2] * matrix_b[2, 1],
            matrix_a[1, 0] * matrix_b[0, 2] + matrix_a[1, 1] * matrix_b[1, 2] + matrix_a[1, 2] * matrix_b[2, 2]
        ],
        [
            matrix_a[2, 0] * matrix_b[0, 0] + matrix_a[2, 1] * matrix_b[1, 0] + matrix_a[2, 2] * matrix_b[2, 0],
            matrix_a[2, 0] * matrix_b[0, 1] + matrix_a[2, 1] * matrix_b[1, 1] + matrix_a[2, 2] * matrix_b[2, 1],
            matrix_a[2, 0] * matrix_b[0, 2] + matrix_a[2, 1] * matrix_b[1, 2] + matrix_a[2, 2] * matrix_b[2, 2]
        ]
    ], dtype=np.uint8)
    return result

# Time the nested for loops multiply
execution_time_forloops = timeit.timeit(for_mult, number=1)

# Time the hardcoded multiply accumulate
execution_time_hardcoded = timeit.timeit(hardcoded_mult, number=1)


result_forloops = for_mult()
result_hardcoded = hardcoded_mult()
print("\nMatrix results:")
print("\n For loops:\n")
print(result_forloops)
print("\n Harcoded:\n")
print(result_hardcoded)

print("\nTiming results:")
print(f"\nTime taken to multiply matrices once (for loops): {execution_time_forloops:.6f} seconds")
print(f"\nTime taken to multiply matrices once (hardcoded): {execution_time_hardcoded:.6f} seconds")
