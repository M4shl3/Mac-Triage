#!/bin/bash

targetsource=${BASH_SOURCE[0]}
targetname=${targetsource/$targetpath/}
FILE_STDERR="${computername}/${computername}_Processing_Details.txt"
exec 2> >(tee -a "${FILE_STDERR}" >&2)

echo ""
echo -e "\n** Now running ${targetname} target **" | tee -a "${computername}/${computername}_Processing_Details.txt"

#Private Directory Edit Start 
if [ -d "/private" ]; then
    # copy etc Directory
    if [ -d "/private/etc" ]; then
        echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/private/etc" | tee -a "${computername}/${computername}_Processing_Details.txt"
        mkdir -p "${computername}/${cname}-Triage/private/etc"
        echo -e "\nCommand Run: cp -rf /private/etc/* ${computername}/${cname}-Triage/private/etc" | tee -a "${computername}/${computername}_Processing_Details.txt"
        cp -rf "/private/etc/"* "${computername}/${cname}-Triage/private/etc"
    else
        echo -e "** Directory /private/etc/ does not exist ***" | tee -a "${computername}/${computername}_Processing_Details.txt"
    fi

    # Copy root directory
    if [ -d "/private/var/root" ]; then    
        # Copying Library files
        echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/private/var/root/Library" | tee -a "${computername}/${computername}_Processing_Details.txt"
        mkdir -p "${computername}/${cname}-Triage/private/var/root/Library/Preferences"
		mkdir -p "${computername}/${cname}-Triage/private/var/root/Library/Logs"
		mkdir -p "${computername}/${cname}-Triage/private/var/root/Library/Application Support"
        cp -rf "/private/var/root/Library/Preferences/"* "${computername}/${cname}-Triage/private/var/root/Library/Preferences"
		cp -rf "/private/var/root/Library/Logs/"* "${computername}/${cname}-Triage/private/var/root/Library/Logs"
		cp -rf "/private/var/root/Library/Application Support/"* "${computername}/${cname}-Triage/private/var/root/Library/Application Support"
        # Copying bash_history file
        echo -e "\nCommand Run: cp -f /private/var/root/.bash_history ${computername}/${cname}-Triage/private/var/root/.bash_history" | tee -a "${computername}/${computername}_Processing_Details.txt"
        cp -f "/private/var/root/.bash_history" "${computername}/${cname}-Triage/private/var/root/.bash_history"
    else
        echo -e "** Directory /private/var/root does not exist ***" | tee -a "${computername}/${computername}_Processing_Details.txt"
    fi

    # Copy tmp Directory
    if [ -d "/private/var/tmp" ]; then    
        # Copying tmp directory
        echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/private/var/tmp" | tee -a "${computername}/${computername}_Processing_Details.txt"
        mkdir -p "${computername}/${cname}-Triage/private/var/tmp"
        cp -rf "/private/var/tmp/"* "${computername}/${cname}-Triage/private/var/tmp"
    else
        echo -e "** Directory /private/var/tmp does not exist ***" | tee -a "${computername}/${computername}_Processing_Details.txt"
    fi

    # copy log directory
    echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/private/var/log" | tee -a "${computername}/${computername}_Processing_Details.txt"
    mkdir -p "${computername}/${cname}-Triage/private/var/log"
    echo -e "\nCommand Run: cp -rf /private/var/log/* ${computername}/${cname}-Triage/private/var/log" | tee -a "${computername}/${computername}_Processing_Details.txt"
    cp -rf "/private/var/log/"* "${computername}/${cname}-Triage/private/var/log"

    # copy battery life directory
    echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/private/var/db/powerlog/Library/BatteryLife" | tee -a "${computername}/${computername}_Processing_Details.txt"
    mkdir -p "${computername}/${cname}-Triage/private/var/db/powerlog/Library/BatteryLife"
    echo -e "\nCommand Run: cp -rf /private/var/db/powerlog/Library/BatteryLife/* ${computername}/${cname}-Triage/private/var/db/powerlog/Library/BatteryLife" | tee -a "${computername}/${computername}_Processing_Details.txt"
    cp -rf "/private/var/db/powerlog/Library/BatteryLife/"* "${computername}/${cname}-Triage/private/var/db/powerlog/Library/BatteryLife"

    # copy Knowledge directory    
    echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/private/var/db/CoreDuet/Knowledge" | tee -a "${computername}/${computername}_Processing_Details.txt"
    mkdir -p "${computername}/${cname}-Triage/private/var/db/CoreDuet/Knowledge"
    echo -e "\nCommand Run: cp -rf /private/var/db/CoreDuet/Knowledge/* ${computername}/${cname}-Triage/private/var/db/CoreDuet/Knowledge" | tee -a "${computername}/${computername}_Processing_Details.txt"
    cp -rf "/private/var/db/CoreDuet/Knowledge/"* "${computername}/${cname}-Triage/private/var/db/CoreDuet/Knowledge"
else
    echo -e "** Directory /private does not exist ***" | tee -a "${computername}/${computername}_Processing_Details.txt"
fi
#Private Directory Edit End

echo ""
echo -e "** Completed running ${targetname} target **\n" | tee -a "${computername}/${computername}_Processing_Details.txt"
echo ""
return