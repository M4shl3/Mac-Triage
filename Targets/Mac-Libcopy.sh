#!/bin/bash

targetsource=${BASH_SOURCE[0]}
targetname=${targetsource/$targetpath/}
FILE_STDERR="${computername}/${computername}_Processing_Details.txt"
exec 2> >(tee -a "${FILE_STDERR}" >&2)


echo ""
echo -e "\n** Now running ${targetname} target **" | tee -a "${computername}/${computername}""_Processing_Details.txt"


#Library base Edit Start 
if [ -d "/Library" ]; then
    # Copy Preferences Directory
    echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/Library/Preferences" | tee -a "${computername}/${computername}""_Processing_Details.txt"
	mkdir -p ${computername}/${cname}-Triage/Library/Preferences
    cp -rf "/Library/Preferences/"* ${computername}/${cname}-Triage/Library/Preferences 
	# Copy Logs Directory
	echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/Library/Logs" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    mkdir -p ${computername}/${cname}-Triage/Library/Logs
    cp -rf "/Library/Logs/"* $computername/${cname}-Triage/Library/Logs
	# Copy LaunchDaemons Directory
	echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/Library/LaunchDaemons" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    mkdir -p ${computername}/${cname}-Triage/Library/LaunchDaemons
    cp -rf "/Library/LaunchDaemons/"* $computername/${cname}-Triage/Library/LaunchDaemons
	# TCC database Files
	echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/Library/Application Support/com.apple.TCC" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    mkdir -p "${computername}/${cname}-Triage/Library/Application Support/com.apple.TCC"
    cp -rf "/Library/Application Support/com.apple.TCC/"* "$computername/${cname}-Triage/Library/Application Support/com.apple.TCC"
	# logKext Directory
	echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/Library/Application Support/logKext" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    mkdir -p "${computername}/${cname}-Triage/Library/Application Support/logKext"
    cp -rf "/Library/Application Support/logKext/"* "$computername/${cname}-Triage/Library/Application Support/logKext"
	# CrashReporter Directory
	echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/Library/Application Support/CrashReporter" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    mkdir -p "${computername}/${cname}-Triage/Library/Application Support/CrashReporter"
    cp -rf "/Library/Application Support/CrashReporter/"* "$computername/${cname}-Triage/Library/Application Support/CrashReporter"
else
    echo -e "** Directory /Library/ does not exist ***" | tee -a "${computername}/${computername}""_Processing_Details.txt"
fi
#Library base Edit End


#Library System Edit Start
if [ -d "/System/Library" ]; then
    # Copy LaunchDaemons Directory
    echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/System/Library/LaunchDaemons" | tee -a "${computername}/${computername}""_Processing_Details.txt"
	mkdir -p ${computername}/${cname}-Triage/System/Library/LaunchDaemons
    cp -rf "/System/Library/LaunchDaemons/"* ${computername}/${cname}-Triage/System/Library/LaunchDaemons 
	# Copy LaunchAgents Directory
	echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/System/Library/LaunchAgents" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    mkdir -p ${computername}/${cname}-Triage/System/Library/LaunchAgents
    cp -rf "/System/Library/LaunchAgents/"* $computername/${cname}-Triage/System/Library/LaunchAgents
	# Copy CoreServices/SystemVersion.plist Directory
	echo -e "\nCommand Run: mkdir -p ${computername}/${cname}-Triage/System/Library/CoreServices/SystemVersion.plist" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    mkdir -p ${computername}/${cname}-Triage/System/Library/CoreServices
    cp -f "/System/Library/CoreServices/SystemVersion.plist" "$computername/${cname}-Triage/System/Library/CoreServices/"

else
    echo -e "** Directory /System/Library does not exist ***" | tee -a "${computername}/${computername}""_Processing_Details.txt"
fi

#Library System Edit End

echo ""
echo -e "** Completed running ${targetname} target **\n" | tee -a "${computername}/${computername}""_Processing_Details.txt"
echo ""
return
