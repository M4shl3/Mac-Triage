#!/bin/bash


targetsource=${BASH_SOURCE[0]}
targetname=${targetsource/$targetpath/}
FILE_STDERR="${computername}/${computername}_Processing_Details.txt"
exec 2> >(tee -a "${FILE_STDERR}" >&2)


echo ""
echo -e "\n** Now running ${targetname} target **" | tee -a "${computername}/${computername}""_Processing_Details.txt"


# Spotlight files found under ./Spotlight-V100
if [[ $EUID -eq 0 && ${swvers} =~ '10.14' && -d "/.Spotlight-V100/" ]]; then
    #Copy Spotlight files & folders
	echo -e "\n** Either directory /.Spotlight-V100/ does not exist\nor you do not have the needed permissions to copy the file ***" | tee -a "${computername}/${computername}""_Processing_Details.txt"	
elif [[ $EUID -eq 0 && -d "/.Spotlight-V100/" ]]; then
    #Copy Spotlight files & folders	
	echo -e "\nCommand Run: cp -rf /.Spotlight-V100/ ${computername}/${cname}-Triage/Spotlight" | tee -a "${computername}/${computername}""_Processing_Details.txt"
	cp -rf "/.Spotlight-V100/" ${computername}/${cname}-Triage/Spotlight
else
	echo -e "\n** Either directory /.Spotlight-V100/ does not exist\nor you do not have the needed permissions to copy the file ***" | tee -a "${computername}/${computername}""_Processing_Details.txt"
fi

# SpotLight for newer versions 
#Spotlight Start
echo ""
echo -e "\n** Now running SpotLight **" | tee -a "${computername}/${computername}""_Processing_Details.txt"
#Looking for spotlight
if [ -e /System/Volumes/Data/.Spotlight-V100 ];
then
	#Creating the proper directory
	echo -e "\nComamnd Run: mkdir -p $computername/${cname}-Triage/spotlight" | tee -a "${computername}/${computername}""_Processing_Details.txt"
	mkdir -p $computername/${cname}-Triage/spotlight
	#Copying the spotlight files
	echo -e "\nCommand Run: cp -r /System/Volumes/Data/.Spotlight-V100 $computername/${cname}-Triage/spotlight" | tee -a "${computername}/${computername}""_Processing_Details.txt"
	cp -r /System/Volumes/Data/.Spotlight-V100 $computername/${cname}-Triage/spotlight
else
   echo -e "\nThe Spotlight files under the directory /System/Volumes/Data/.Spotlight-V100 were not found on this system." | tee -a "${computername}/${computername}""_Processing_Details.txt"
fi

echo ""
echo -e "** Completed running SpotLight **\n" | tee -a "${computername}/${computername}""_Processing_Details.txt"
echo ""
# SpotLight End
	
echo ""
echo -e "** Completed running ${targetname} target **\n" | tee -a "${computername}/${computername}""_Processing_Details.txt"
echo ""
return