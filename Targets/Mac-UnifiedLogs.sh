#!/bin/bash

targetsource=${BASH_SOURCE[0]}
targetname=${targetsource/$targetpath/}
FILE_STDERR="${computername}/${computername}_Processing_Details.txt"
exec 2> >(tee -a "${FILE_STDERR}" >&2)


echo ""
echo -e "\n** Now running ${targetname} target **" | tee -a "${computername}/${computername}""_Processing_Details.txt"

#Unified Log collection
#Checking for administrator privileges. We need this to actually collect the Unified Logs
if [[ $EUID -ne 0 ]]; then
	echo -e "You do not have root permissions. Skipping Unified Log copying"
	printf "You do not have root permissions. Skipping Unified Log copying\n" >> "${computername}/${computername}""_Processing_Details.txt"
else
	#Creating the directory for the Unified Logs 
	echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/UnifiedLogs" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    mkdir -p ${computername}/${cname}-Triage/UnifiedLogs
    #Actually collection the Unified Logs, since the permissions check passed
    echo -e "\nCommand Run: sudo log collect --output ${computername}/${cname}-Triage/UnifiedLogs/${computername}.logarchive" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    sudo log collect --output ${computername}/${cname}-Triage/UnifiedLogs/${computername}.logarchive
fi


echo ""
echo -e "** Completed running ${targetname} target **\n" | tee -a "${computername}/${computername}""_Processing_Details.txt"
echo ""
return