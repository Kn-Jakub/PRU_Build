
# Compiling and building C-application for PRU (FleX-d)

This project explains compiling the C code and build runable application for PRU(Programable Realtime Unit) that is part of BeagleBone black processor. It contains all parts libraries, includes directories and compilator for PRU development. It is able to download Lite version for compiling on the embedded device (Beaglebone) or download the full version with main libraries for programing and compiling on the personal computer.

## TREE for build runable program for PRU

It is necessary to order files and directories in your computer into following tree. For non-editing resources downloaded from github.

                      compiler/ ______ bin/
                      /        L______ include/        
                     /         L______ lib/
                    /          L______ pru/
    
    */PRU_Project/

                   |\
                   | \
                   |  \
                   |   pru_code/ ______ main.c
                   |\           L______ othersFiles *.c/.h*
                   | \
                   |  \
                   |   build/ ____ [Here will be placed the final files after success compiling and building]
                   |
                   |
                    L___ buildDebug.sh
                    L___ buildRelease.sh
              
## Preparing of enviroment for compiling of BB-PRU project 

## Compiling .c file to .obj file

    ../compiler/bin/clpru -v3 --include_path="../compiler/pru/include"  --include_path="../" --include_path="../compiler/include" --define=am3358 --define=pru0 -g --diag_warning=225 --diag_wrap=off --display_error_number --endian=little --hardware_mac=on --preproc_with_compile --preproc_dependency="main.d_raw"  ../main.c


## Building .obj file to .out file for PRU

    ../compiler/bin/clpru -v3 --define=am3358 --define=pru0 -g --diag_warning=225 --diag_wrap=off --display_error_number --endian=little --hardware_mac=on -z -m"test.map"  --heap_size=0x100 --stack_size=0x100 -i"../compiler/lib" -i"../compiler/include" --reread_libs --diag_wrap=off --display_error_number --warn_sections --xml_link_info="test_linkInfo.xml" --rom_model -o "test.out" "./main.obj" "../compiler/pru/include/AM335x_PRU.cmd"  -llibc.a 


