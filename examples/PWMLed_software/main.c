#include <stdint.h>                                     // needed for pru_iep.h
#include "resource_table_empty.h"
#include "pru_cfg.h"                                    // needed to initialize OCP
#include "pru_iep.h"                                    // needed for pru IEP counter

// See http://elinux.org/Ti_AM33XX_PRUSSv2: P9_30 is set by __R30 bit 2
#define R30_out_bit_1 2
#define R30_out_bit_2 5

// Clock cycles to wait (note: PRU's run at 200MHz, so 100M equals 0.5s)
#define wait 100000000

// The PRU registers __R30 and __R31 for GPIO (__R30 used here switch the LED on / off)
volatile register unsigned int __R30;
volatile register unsigned int __R31;

void reset_iep(void);
int read_iep(void);
int init();
int delay_us(int uSeconds);
void pwmSoft(int pwmValue, int pinOut);

int main(void)
{
        
    init();
    int varPWM;
    char increment = 1;
        // variables can not be declared in for loops
      
        // loop a defined amount
        while (1)
        {   if(increment == 1){
                for(varPWM = 0; varPWM < 1000000; varPWM = varPWM + 1000){
                    pwmSoft(varPWM, R30_out_bit_1);
                    
                }
                increment = 0;
            } else {
                for(; varPWM > 0; varPWM = varPWM - 1000){
                    pwmSoft(varPWM, R30_out_bit_1);
                }
                increment = 1;
            }
            
        }

//__halt();

        return 0;
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

int init(){
    // Initialize OCP (formerly known as ocp_init() in assembly
        CT_CFG.SYSCFG_bit.STANDBY_INIT = 0;
        return 1;
}

int delay_us(int uSeconds){
    reset_iep();
    while (read_iep() < (uSeconds*200)) {}
    return 1;
}
// pwm can be from 0 to 1000  
void pwmSoft(int pwmCount, int pinOut){
    if(pwmCount > 1000000){
        pwmCount = 1000000;
    }
    if(pwmCount > 0){
        __R30 |= (1 << pinOut );
    } else {
        pwmCount = 0;
    }
    reset_iep();
    while (read_iep() < pwmCount) {}
    
    __R30 &= ~(1 << pinOut );
    reset_iep();
    while (read_iep() < (1000000-pwmCount)) {}
}


