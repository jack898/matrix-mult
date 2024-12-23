/* C Matrix Stream
   12/10/24
   
   Purpose: Sends two 3x3 matrices of 8-bit numbers to
   a peripheral serially as 8 bit binary values. Produces master clock
   for sending values.

   Authors: Jack Burton, Ha Nguyen, Michael Zhou, Camran Aduli
*/

#include "/home/password/matrix/pico-sdk/src/common/pico_stdlib_headers/include/pico/stdlib.h"
#include "/home/password/matrix/pico-sdk/src/rp2_common/hardware_clocks/include/hardware/clocks.h"
#include <stdint.h>

/* Globals
 *
 *  CLOCK_FREQ: Defines overclock frequency, in kHz, for controller
 *      NOTE: Currently clocked at 250MHz, maximum safe overclock for the Pi Pico.
 *          For other microcontrollers, adjust as appropriate.
 * 
 *  CLK_PIN: Master clock; 1 bit sent per master clock cycle.
 *  OUT_PIN: Bit stream for each 8-bit number.
 *  RESET_PIN: Reset signal to clear input matrices.
 *  START_PIN: Start signal to begin matrix multiplication.
*/
const uint32_t CLOCK_FREQ = 250000;
const uint CLK_PIN = 21;
const uint OUT_PIN = 15;
const uint RESET_PIN = 13;
const uint START_PIN = 12;

// Input matrices in unsigned base-10 form
uint8_t A_nums[] = {5, 0, 4, 1, 2 ,3, 5, 4, 0};
uint8_t B_nums[] = {1, 0, 0, 0, -1, 0, 0, 1, 0};

// num_to_bit_array
// Purpose: Converts array of base-10 numbers into array of 8-bit binary representations
// Returns: None; sets bit_array pointer to bit array
void num_to_bit_array(uint8_t *nums, uint8_t num_count, uint8_t *bit_array) {
    for (int i = 0; i < num_count; i++) {
        for (int j = 7; j >= 0; j--) {
            bit_array[i * 8 + (7 - j)] = (nums[i] >> j) & 1;
        }
    }
}

// Main driver
// Purpose: Overclock controller and serially stream bit arrays over pin_out. 
// Also produces master clock over pin_clk.
// Returns: Int indicating successful execution
int main() {
    // Attempt to overclock system clock
    bool success = set_sys_clock_khz(CLOCK_FREQ, true);
    
    // Map GPIO pinouts
    const uint pin_out = OUT_PIN;
    const uint pin_clk = CLK_PIN;
    const uint pin_reset = RESET_PIN;
    const uint pin_start = START_PIN;

    // Initialize GPIO pins as outputs
    gpio_init(pin_out);
    gpio_set_dir(pin_out, GPIO_OUT);
    gpio_init(pin_clk);
    gpio_set_dir(pin_clk, GPIO_OUT);
    gpio_init(pin_reset);
    gpio_set_dir(pin_reset, GPIO_OUT);
    gpio_init(pin_start);
    gpio_set_dir(pin_start, GPIO_OUT);

    // Convert base-10 matrices to base-2 matrices
    uint8_t A[72], B[72];
    num_to_bit_array(A_nums, sizeof(A_nums), A);
    num_to_bit_array(B_nums, sizeof(B_nums), B);

    // Initialization logic
    gpio_put(pin_reset, 1);
    gpio_put(pin_start, 0);
    sleep_ms(100);
    gpio_put(pin_start, 1);
    sleep_ms(100);
    gpio_put(pin_reset, 0);

    // Bit counters
    int counter = 0;
    const int total_bits = 144; // Total bits for A and B
    int other_count = 0;

    // Main logic loop to serially stream bits for each number in each matrix,
    // and toggle the clock
    while (1) {

        if (counter < total_bits) {
            if (counter < 72) { // First matrix being sent
                gpio_put(pin_out, A[counter]);
            } else { // Second matrix being sent
                gpio_put(pin_out, B[counter - 72]);
            }
            counter++; // Iterating counter
        } else { // Reset counter back to 0 after both inputs sent
            counter = 0; 
        }

        // Clock cycle
        gpio_put(pin_clk, 1);
        sleep_us(1); 
        gpio_put(pin_clk, 0);
        sleep_us(1); 
    }

    return 0;
}
