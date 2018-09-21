# !/bin/bash
echo ""
echo "***** Start of script *****"
if [ $# -ne 1 ]
then
    echo "ERROR: script have to been run as \" ./buildDebug.sh name_of_output \""
    echo "INFO: it is missing name of output"
    exit -1
fi

outName=$1

if [ ! -d "build" ]
then
mkdir build
retValue=$?
   if [  $retValue -eq 0 ]
   then
        echo "INFO: build directory is not create. Run command\" mkdir build \" "
        cd build
   else 
        echo "ERROR: Problem with creating of directory build"
        exit -1
   fi 
else
   cd build
   retValue=$?
   if [  $retValue -eq 0 ]
   then
       rm *
       echo "INFO: From build/ directory was deleted all files"
   else
        echo "ERROR: command cd build was not successful"
        exit -1
   fi    
   
fi
actDir=$(pwd)
message="INFO: Working directory: $actDir"

echo $message

echo "*** COMPILING MESSAGES ***"

../compiler/bin/clpru  --include_path="../compiler/pru/include"  --include_path="../pru_code" --include_path="../compiler/include" --define=am3358 --define=pru0 -g --diag_warning=225 --diag_wrap=off --display_error_number --hardware_mac=on --preproc_with_compile --preproc_dependency="main.d_raw"  ../pru_code/main.c

 
../compiler/bin/clpru  --define=am3358 --define=pru0 -g --diag_warning=225 --diag_wrap=off --display_error_number --hardware_mac=on -z -m"$outName.map"  --heap_size=0x100 --stack_size=0x100 -i"../compiler/lib" -i"../compiler/include" --reread_libs --diag_wrap=off --display_error_number --warn_sections --xml_link_info="$outName_linkInfo.xml" --rom_model -o "$outName.out" "./main.obj" "../compiler/pru/include/AM335x_PRU.cmd"  -llibc.a 
retValue=$?
 if [  $retValue -eq 0 ]
   then
    echo "INFO: The file was succesful building. Path for PRU file is build/$outName.out"
 fi