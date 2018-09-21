#include <stdint.h>
#include "resource_table_empty.h"

/**
 * This is example application for compiling C-code in the linux terminal and build binari file with posix .out, that is executable on PRU.
 * 
 * Main information:
 *  - it is defined two registers __R30 is set-up register and set the state on outputs pin, __R31 is readable register for reading the states on pins.
 *  - in *for* cycle is set bit 2 (P9-27) and bit 5 (P9-30)
 *  - it is necessary have able the pin controling by PRU in device tree
 *  - __delay_cycles() is fucntion for delay and parameter is the number of cycles, that pru will be waiting. One cykle take 5 ns. 
 * 
 */

/** Defining of write register __R30 and read register __R31**/
volatile register unsigned int __R31, __R30;

int main(void) {
    __R30 = __R30 | ((1 << 5) | (1 << 2)); // Set of logical 1 in register on 2. and 5. position
    
    for(;;) // Never ending story
    {
        __R30 = __R30 | (1 << 5); // Turn on first LED
        __R30 = __R30 & ~(1 << 2);// Turn off second LED
        __delay_cycles(300000000);
        
        __R30 = __R30 | (1 << 2);
        __delay_cycles(200000000);
        
        __R30 = __R30 & ~(1 << 5);
        __delay_cycles(300000000);
        
        __R30 = __R30 | (1 << 5);
        __delay_cycles(200000000);
        
    }

    // Send interrupt to host and halt
   // __R31 = 32 | 3;
    //__halt();
    return 0;
}
