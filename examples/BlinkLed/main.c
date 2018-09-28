#include <stdint.h>                                     // needed for pru_iep.h
#include "resource_table_empty.h"
#include "pru_cfg.h"                                    // needed to initialize OCP
#include "pru_iep.h"                                    // needed for pru IEP counter

// See http://elinux.org/Ti_AM33XX_PRUSSv2: P9_30 is set by __R30 bit 2
#define R30_out_bit 2

// Clock cycles to wait (note: PRU's run at 200MHz, so 100M equals 0.5s)
#define wait 100000000

// The PRU registers __R30 and __R31 for GPIO (__R30 used here switch the LED on / off)
volatile register unsigned int __R30;
volatile register unsigned int __R31;

void led_output( char high )
{
    if (high)
                __R30 |= (1 << R30_out_bit );
    else
                __R30 &= ~(1 << R30_out_bit );
}

void reset_iep(void)
{
        // Set counter to 0
        CT_IEP.TMR_CNT = 0x0;
        // Enable counter
        CT_IEP.TMR_GLB_CFG = 0x11;
}

int read_iep(void)
{
        // Return counter content
        return CT_IEP.TMR_CNT;
}

int main(void)
{
        // Initialize OCP (formerly known as ocp_init() in assembly
        CT_CFG.SYSCFG_bit.STANDBY_INIT = 0;

        // variables can not be declared in for loops
        int i;

        // loop a defined amount
        for ( i = 0; i < 5 ; i++)
        {
                // reset the IEP clock
                reset_iep();

                // wait by polling the IEP counter, then switch LED on
                while (read_iep()<wait) {}
                led_output(1);

                // another wait method, then switch LED off
                __delay_cycles(wait);
                led_output(0);
        }

        __halt();

        return 0;
}
