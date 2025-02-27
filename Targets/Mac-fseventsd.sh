#!/bin/bash

targetsource=${BASH_SOURCE[0]}
targetname=${targetsource/$targetpath/}
FILE_STDERR="${computername}/${computername}_Processing_Details.txt"
exec 2> >(tee -a "${FILE_STDERR}" >&2)


echo ""
echo -e "\n** Now running ${targetname} target **" | tee -a "${computername}/${computername}""_Processing_Details.txt"
#Looking for fseventsd for new MAC versions
if [ -e /System/Volumes/Data/.fseventsd ];
then
	#Creating the proper directory
	echo -e "\nComamnd Run: mkdir -p $computername/${cname}-Triage/fsevents" | tee -a "${computername}/${computername}""_Processing_Details.txt"
	mkdir -p $computername/${cname}-Triage/fsevents
	#Copying the FSEvents files
	echo -e "\nCommand Run: cp -r /System/Volumes/Data/.fseventsd $computername/${cname}-Triage/fsevents" | tee -a "${computername}/${computername}""_Processing_Details.txt"
	cp -r /System/Volumes/Data/.fseventsd $computername/${cname}-Triage/fsevents
else
   echo -e "\nThe FSEvents files under the directory /System/Volumes/Data/.fseventsd were not found on this system." | tee -a "${computername}/${computername}""_Processing_Details.txt"
fi

#Looking for fseventsd for old MAC versions
if [ -e /.fseventsd ];
then
    #Creating the proper directory
    echo -e "\nComamnd Run: mkdir -p $computername/${cname}-Triage/fsevents" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    mkdir -p $computername/${cname}-Triage/fsevents
    #Copying the FSEvents files
    echo -e "\nCommand Run: cp -r /.fseventsd $computername/${cname}-Triage/fsevents" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    cp -r /.fseventsd $computername/${cname}-Triage/fsevents
else
   echo -e "\nThe FSEvents files under the directory /.fseventsd were not found on this system." | tee -a "${computername}/${computername}""_Processing_Details.txt"
fi

echo ""
echo -e "** Completed running ${targetname} target **\n" | tee -a "${computername}/${computername}""_Processing_Details.txt"
echo ""
return