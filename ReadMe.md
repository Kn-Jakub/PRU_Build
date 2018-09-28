
# Compiling and building C-application for PRU (FleX-d) *Full branche*

This project explains compiling the **C code** and build runable application for **PRU** (Programable Realtime Unit) that is part of BeagleBone black processor. It contains all parts libraries, includes directories and compilator for PRU development. It is able to download Lite version for compiling on the embedded device (Beaglebone) or download the full version with main libraries for programing and compiling on the personal computer.

Complementary project for FleX-d (https://github.com/FleX-d)

## Directories TREE for build runable program for PRU

It is necessary to order files and directories in your computer into following tree.

                      compiler/ ______ bin/
                      /        L______ include/        
                     /         L______ lib/
                    /          L______ pru/
    
    */PRU_Build/

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
All files that are needed for PRU project compiling are on the github.
Branches: 
* 'Full' (size - about 140MB) - all compilers/libraries/includes that are installed by CCS (Code Composer Studio)

1.  Clone repository Kn-Jakub/PRU_Build

        git clone https://github.com/Kn-Jakub/PRU_Build.git
2.  Switch between branches ('Full')

        git checkout Full
Now is computer prepared for compiling test PRU project. The example code is in *pru_code/* folder. All code information are writing in *main.c* file.

**NOTE:** If it is needed some else libreries/includes for compiling project, the files can be added:

libraries -> *compiler/lib/*

includes -> *compiler/include/*

## Compiling .c file to .obj file
For beginers or testers is writting *buildDebug.sh* script that compile and build output file for PRU automatically. 

    cd path_PRU_Build
    ./buildDebug.sh output_file_name
    
#### Detailed information
The main compiler for PRU is clpru in *compiler/bin/clpru*. All information about compiler options will be showed in terminal after writting

    cd path_PRU_Build
    compiler/bin/clpru 
    
The fallowing command compile *pru_code/main.c* file in debug version.

**NOTE:** It is neccessary run this command from */PRU_Build/build/* directory.

    ../compiler/bin/clpru  --include_path="../compiler/pru/include"  --include_path="../pru_code" --include_path="../compiler/include" --define=am3358 --define=pru0 -g --diag_warning=225 --diag_wrap=off --display_error_number --hardware_mac=on --preproc_with_compile --preproc_dependency="main.d_raw"  ../pru_code/main.c


## Building .obj file to .out file for PRU
**NOTE:** This command is needed, if it was only compiled C-code and it created *.obj* file

The fallowing command build *build/test.out* file in debug version.

**NOTE:** It is neccessary run this command from *PRU_Build/build/* directory.

    ../compiler/bin/clpru --define=am3358 --define=pru0 -g --diag_warning=225 --diag_wrap=off --display_error_number --endian=little --hardware_mac=on -z -m"test.map"  --heap_size=0x100 --stack_size=0x100 -i"../compiler/lib" -i"../compiler/include" --reread_libs --diag_wrap=off --display_error_number --warn_sections --xml_link_info="test_linkInfo.xml" --rom_model -o "test.out" "./main.obj" "../compiler/pru/include/AM335x_PRU.cmd"  -llibc.a 

*test.out* - is name of output file, it can be changed

*main.obj* - is name of file after compiling of main.c file

## Flashing from PC to BB-PRU
**WARNING:** These instructions are created for FleX-d platform and may be required by another method the flashing on other distributions (Debian,...).

1. Copy the .out file to BeagleBone through SSH

        scp path_to_file user@ip.add.of.BBB:/home/user/PRU/
    
**NOTE:** */home/user/PRU/* have to been created on BeagleBone before copying

2.  Flashing to PRU

        rmmod -f pru_rproc
        cp name_of_.out_file /lib/firmware/am355x-pru0-fw
        modprobe pru_rproc



