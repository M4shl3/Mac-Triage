#!/bin/bash

targetsource=${BASH_SOURCE[0]}
targetname=${targetsource/$targetpath/}
FILE_STDERR="${computername}/${computername}_Processing_Details.txt"
exec 2> >(tee -a "${FILE_STDERR}" >&2)


echo ""
echo -e "\n** Now running ${targetname} target **" | tee -a "${computername}/${computername}""_Processing_Details.txt"



printf "\nHashing collected files. Please be patient, this may take some time\n\n"
filehashesfile="${computername}""_File_Hashes.txt"
printf "\nCalculating MD5 hash of collected files.\n\n"
printf "==========MD5 HASHES==========\n" >> "${computername}/${computername}""_File_Hashes.txt"
find ${computername}/ -type f \( ! -name ${filehashesfile} \) -exec md5 {} \; >> "${computername}/${computername}""_File_Hashes.txt"
echo >> "${computername}/${computername}""_File_Hashes.txt"
printf "\nCalculating SHA256 hash of collected files.\n\n"
printf "==========SHA256 HASHES==========\n" >> "$computername/$computername""_File_Hashes.txt"
find ${computername}/ -type f \( ! -name ${filehashesfile} \) -exec shasum -a 256 {} \; >>  "${computername}/${computername}""_File_Hashes.txt"


echo ""
echo -e "** Completed running $targetname target **\n" | tee -a "${computername}/${computername}""_Processing_Details.txt"
echo ""
return