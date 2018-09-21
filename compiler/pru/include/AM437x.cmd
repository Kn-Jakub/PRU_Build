/****************************************************************************/
/*  AM437x.cmd                                                              */
/*  Copyright (c) 2014  Texas Instruments Incorporated                      */
/*  Author: Rafael de Souza                                                 */
/*                                                                          */
/*    Description: This file is a sample linker command file that can be    */
/*                 used for linking programs built with the C compiler and  */
/*                 running the resulting .out file on an AM437x device.     */
/*                 Use it as a guideline.  You will want to                 */
/*                 change the memory layout to match your specific          */
/*                 target system.  You may want to change the allocation    */
/*                 scheme according to the size of your program.            */
/*                                                                          */
/****************************************************************************/

#ifdef A9_CORE     /* A9 memory map */
MEMORY
{
    SRAM:     o = 0x402F0000  l = 0x00010000  /* 64kB internal SRAM */
    L3OCMC0:  o = 0x40300000  l = 0x00010000  /* 64kB L3 OCMC SRAM */
    M3SHUMEM: o = 0x44D00000  l = 0x00004000  /* 16kB M3 Shared Unified Code Space */
    M3SHDMEM: o = 0x44D80000  l = 0x00002000  /* 8kB M3 Shared Data Memory */
    DDR0:     o = 0x80000000  l = 0x80000000  /* 2GB external DDR Bank 0 */
}

SECTIONS
{
    .text          >  L3OCMC0
    .stack         >  L3OCMC0
    .bss           >  L3OCMC0
    .cio           >  L3OCMC0
    .const         >  L3OCMC0
    .data          >  L3OCMC0
    .switch        >  L3OCMC0
    .sysmem        >  L3OCMC0
    .far           >  L3OCMC0
    .args          >  L3OCMC0
    .ppinfo        >  L3OCMC0
    .ppdata        >  L3OCMC0
  
    /* TI-ABI or COFF sections */
    .pinit         >  L3OCMC0
    .cinit         >  L3OCMC0
  
    /* EABI sections */
    .binit         >  L3OCMC0
    .init_array    >  L3OCMC0
    .neardata      >  L3OCMC0
    .fardata       >  L3OCMC0
    .rodata        >  L3OCMC0
}
#endif             /* A8 memory map */

#ifdef ICSS1_PRU_CORE    /* ICSS1 PRU memory map */
MEMORY
{
    PAGE 0:
      PRUIMEM:   o = 0x00000000  l = 0x00002000  /* 8kB PRU Instruction RAM */
    PAGE 1:
      PRUDMEM:   o = 0x00000000  l = 0x00002000  /* 8kB PRU Data RAM */
	PAGE 2:
      SHAREDMEM: o = 0x00010000  l = 0x00008000  /* 32kB Shared RAM */
}

SECTIONS
{
    .text:_c_int00 >  0x0
    .text          >  PRUIMEM, PAGE 0
    .bss           >  PRUDMEM, PAGE 1
    .data          >  PRUDMEM, PAGE 1
    .rodata        >  PRUDMEM, PAGE 1
    .farbss        >  SHAREDMEM, PAGE 2
    .fardata       >  SHAREDMEM, PAGE 2
    .rofardata     >  SHAREDMEM, PAGE 2
    .sysmem        >  PRUDMEM, PAGE 1
    .stack         >  PRUDMEM, PAGE 1
    .init_array    >  PRUDMEM, PAGE 1
	.cinit         >  PRUDMEM, PAGE 1
	.args          >  PRUDMEM, PAGE 1
}
#endif             /* ICSS1 PRU memory map */

#ifdef ICSS0_PRU_CORE    /* ICSS1 PRU memory map */
MEMORY
{
    PAGE 0:
      PRUIMEM:   o = 0x00000000  l = 0x00001000  /* 4kB PRU Instruction RAM */
    PAGE 1:
      PRUDMEM:   o = 0x00000000  l = 0x00001000  /* 4kB PRU Data RAM */
}

SECTIONS
{
    .text:_c_int00 >  0x0
    .text          >  PRUIMEM, PAGE 0
    .bss           >  PRUDMEM, PAGE 1
    .data          >  PRUDMEM, PAGE 1
    .rodata        >  PRUDMEM, PAGE 1
    .sysmem        >  PRUDMEM, PAGE 1
    .stack         >  PRUDMEM, PAGE 1
    .init_array    >  PRUDMEM, PAGE 1
	.cinit         >  PRUDMEM, PAGE 1
	.args          >  PRUDMEM, PAGE 1
}
#endif             /* ICSS0 PRU memory map */

