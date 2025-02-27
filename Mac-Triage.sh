#!/bin/bash


# Define creator names
CREATORS="a1l4m & M4shl3"
RELEASE_DATE="28 Feb 2025"
echo ""
echo "==========================================="
echo "          🚀 Mac Triage Tool 🚀            "
echo "          Created by: $CREATORS            "
echo "          Released In: $RELEASE_DATE       "
echo "==========================================="
echo ""

# Some Important definitions
ScriptStart=$(date +%s)
lrcbuildname="Mac Triage Collection"
scriptname=$(basename "$0")
#Getting directory from where the script is running
get_script_dir () {
    SOURCE="${BASH_SOURCE[0]}"
    # Whole $SOURCE is a symlink, resolve it
    while [ -h "${SOURCE}" ]; do
        DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"
        SOURCE="$( readlink "$SOURCE" )"
        [[ ${SOURCE} != /* ]] && SOURCE="${DIR}/${SOURCE}"
        done
    DIR="$( cd -P "$( dirname "${SOURCE}" )" && pwd )"
    echo "${DIR}"
}     
directorywherescriptrunsfrom=$(get_script_dir)        
targetpath="${directorywherescriptrunsfrom}/Targets/"
runningfromexternal="no"
swversion=$(sw_vers -productVersion)
cname=$(hostname -s)
ts=$(date +%Y%m%d_%H%M%S)
computername=${cname}\_${ts}
mkdir -p "${computername}/${cname}-Triage"
FILE_STDERR="${computername}/${computername}_Processing_Details.txt"
exec 2> >(tee -a "${FILE_STDERR}" >&2)

echo -e "\nComputername: ${cname}" | tee -a "${computername}/${computername}""_Processing_Details.txt"
echo -e "\nmkdir -p ${computername}" | tee -a "${computername}/${computername}""_Processing_Details.txt"



#Checking for administrator privileges.
if [[ $EUID -ne 0 ]]; then
	echo "You do not have root permissions. Skipping FSEvents copying"
	printf "You do not have root permissions. Skipping FSEvents copying\n" >> "${computername}/${computername}""_Processing_Details.txt"
else
	#Running FSEventsd target
	echo ""
	echo "***** Beginning Mac FSEventsd target *****"
	source "${directorywherescriptrunsfrom}/Targets/Mac-fseventsd.sh"
	echo "***** Ending Mac FSEventsd target *****"
	echo ""
fi


#Unified Logs
#Running UnifiedLogs target
echo ""
echo "***** Beginning Mac UnifiedLogs target *****"
source "${directorywherescriptrunsfrom}/Targets/Mac-UnifiedLogs.sh"
echo "***** Ending Mac UnifiedLogs target *****"
echo ""

#Spotlight
#Running Spotlight target
echo ""
echo "***** Beginning Mac Spotlight target *****"
source "${directorywherescriptrunsfrom}/Targets/Mac-Spotlight.sh"
echo "***** Ending Mac Spotlight target *****"
echo ""


#All Users
#Running All Users  target
echo ""
echo "***** Beginning Mac All Users information target *****"
source "${directorywherescriptrunsfrom}/Targets/Mac-AllUsers.sh"
echo "***** Ending Mac All Users target *****"
echo ""

#Running Private Copy  target
echo ""
echo "***** Beginning Mac Private Copy target *****"
source "${directorywherescriptrunsfrom}/Targets/Mac-privCopy.sh"
echo "***** Ending Mac Private Copy target *****"
echo ""

#Running Library copy target
echo ""
echo "***** Beginning Mac Library Copy target *****"
source "${directorywherescriptrunsfrom}/Targets/Mac-Libcopy.sh"
echo "***** Ending Mac Library Copy target *****"
echo ""

#Full file listing
echo -e "\nCommand Run: ls -alR /" | tee -a "${computername}/${computername}""_Processing_Details.txt"
echo -ne '\n' | ls -alR / 1>> ${computername}/Full_file_listing.txt

#PROCESSING DETAILS AND HASHES
#Running hashing target
echo ""
echo "***** Beginning Mac LRC hashing target *****"
source "${directorywherescriptrunsfrom}/Targets/Mac-LRCHashing.sh"
echo "***** Ending Mac LRC hashing target *****"
echo ""


#CHMOD CLEANUP
#Checking for administrator privileges. We need to chmod directories, just in case
if [[ $EUID -ne 0 ]]; then
	echo -e "\nYou do not have root permissions. Skipping chmod cleanup" | tee -a "${computername}/${computername}""_Processing_Details.txt"
else
#Running chmod just to clean up
	echo ""
	echo -e "\n***** Beginning chmod cleanup *****" | tee -a "${computername}/${computername}""_Processing_Details.txt"
	echo -e "\n** sudo chmod -R 0755 ${computername}/ ***" | tee -a "${computername}/${computername}""_Processing_Details.txt"
    sudo chmod -R 0755 ${computername}/
	echo -e "\n***** Ending chmod cleanup *****" | tee -a "${computername}/${computername}""_Processing_Details.txt"
	echo ""
fi


#Finishing up
echo Congratulations\! The Mac Triage Collection is now complete.
ScriptEnd=$(date +%s)
ScriptRunTime=$(expr ${ScriptEnd} - ${ScriptStart})


if (("${ScriptRunTime}" < 60)); then
	echo -e "\nThe script took a total of ${ScriptRunTime} seconds to run\n" | tee -a "${computername}/${computername}""_Processing_Details.txt"
	echo -e "\n...Exiting script now.\nEnd Of Line.\n\n" | tee -a "${computername}/${computername}""_Processing_Details.txt"
else
	Minutes=$(expr ${ScriptRunTime} / 60)
	Seconds=$(expr ${ScriptRunTime} % 60)
	echo -e "\nThe script took a total of ${Minutes} minutes and ${Seconds} seconds to run\n" | tee -a "${computername}/${computername}""_Processing_Details.txt"
	echo -e "\n...Exiting script now.\nEnd Of Line.\n\n" | tee -a "${computername}/${computername}""_Processing_Details.txt"
fi

# Create a compressed archive with maximum compression
echo -e "\n***** Creating compressed archive *****" | tee -a "${computername}/${computername}_Processing_Details.txt"
zip -r -9 "${computername}.zip" "${computername}"

# Check if the zip operation was successful before deleting the directory
if [[ $? -eq 0 ]]; then
    echo -e "\n***** Archive created: ${computername}.zip *****" | tee -a "${computername}/${computername}_Processing_Details.txt"
    
    # Cleanup: Delete the original directory
    echo -e "\n***** Cleaning up: Removing ${computername} directory *****" | tee -a "${computername}/${computername}_Processing_Details.txt"
    rm -rf "${computername}"
else
    echo -e "\n***** ERROR: Compression failed. Directory not deleted. *****" | tee -a "${computername}/${computername}_Processing_Details.txt"
fi

exit
