#!/bin/env bash

# This script serves as a wrapper around systemctl with Cecho-enabled responses to services starting/stopping, etc.
#
# TODO: Make interactive?  Example: checkinghh if a service is started; ask to start it if not running.
#


## Define Colors Library ##
SC_ColorsLib="./SanityChecker_Colors.conf"


## Configuration ##
SERVICE="httpd"
## SERVICE="$2" # Set as 2nd cmdline args

COLS=$(tput cols)
# Subtract a few characters for the brackets and spacing
## PADDING=$((COLS - ${#SERVICE} - 8)) # Default
PADDING=$((COLS - ${#SERVICE} - 5))


##### Begin Functions ###

function Source_ColorLib() {
## Source Colors Library ##
	if [ ! -f "$SC_ColorsLib" ]; then
		echo "ERROR!  Colors Library $SC_ColorsLib NOT Found.  Quitting."
		return 1
	else 
		source "$SC_ColorsLib"
	fi
}


function CheckInput() {
 # Check if input is provided
    if [ -z "$1" ]; then
        echo -e "${RED}[!] ERROR: No arguments provided. ${NC}"
        return
    fi
}


function CheckResult() {
    # TODO: Alter code to use systemctl and get status / show color
    # Check existence
    if [ -e "$1" ]; then
        echo -e "${GREEN}[ OK ]${NC} $1 exists."
    else
        echo -e "${RED}[ NOT OK ]${NC} $1 does not exist."
    fi
}


function ShowConfiguredService() {
	echo " "
	echo "Configured Service: $SERVICE"
	echo " "
}


function SC_StartService() {
	echo -n "Starting $SERVICE: "

	# Print padding dots (adjust as desired)
##	printf '%*s' "$PADDING" | tr ' ' '.'

	# Perform the systemd action
	systemctl start "$SERVICE" >/dev/null 2>&1

	# Check the active status
	if systemctl -q is-active "$SERVICE"; then
    	   echo -e "[\e[1;32m  OK  \e[0m]"
	else
    	   echo -e "[\e[1;31mFAILED\e[0m]"
	fi
}


function SC_StopService() {
	echo -n "Stopping $SERVICE: "

	# Print padding dots (adjust as desired)
##	printf '%*s' "$PADDING" | tr ' ' '.'

	# Perform the systemd action
	systemctl stop "$SERVICE" >/dev/null 2>&1

	# Check the active status
	if systemctl -q is-active "$SERVICE"; then
    	   # echo -e "[\e[1;32m  OK  \e[0m]"
	   echo -e "[\e[1;31mFAILED\e[0m]"
	else
	   echo -e "[\e[1;32m  OK  \e[0m]"
    	   # echo -e "[\e[1;31mFAILED\e[0m]"
	fi
}

function SC_StatusService() {
	echo -n "Checking Status of $SERVICE: "

	# Print padding dots (adjust as desired)
##	printf '%*s' "$PADDING" | tr ' ' '.'

	# Perform the systemd action
	systemctl status "$SERVICE" >/dev/null 2>&1

	# Check the active status
	if systemctl -q is-active "$SERVICE"; then
	   echo -e "[\e[1;32m  OK  \e[0m]"
	else
	   echo -e "[\e[1;31mFAILED\e[0m]"
	fi
}


###############################################################################
# how it works #							      #
###############################################################################

#	- tput cols: Dynamically fetches your terminal width so the padding lines up perfectly with the right edge.

#	- systemctl start >/dev/null: Runs the service in the background and hides systemd's default silent/non-verbose output.

#	- systemctl -q is-active: Returns an exit status of 0 if the service is running, which triggers the green [  OK  ]. If it fails, it prints a red [FAILED].



function CASE_Options() {

	# Ensure an argument is provided
	if [ $# -ne 1 ]; then
    	   echo "Usage: $0 {start|stop|status}"
    	return 1
	fi

	echo " "

	SERVICE_ACTION="$1"

	case "$SERVICE_ACTION" in
    	   start)
        	# echo "Starting the service $SERVICE..."
        	SC_StartService
        	;;
    	   stop)
        	# echo "Stopping the service $SERVICE..."
        	SC_StopService
        	;;
    	  status)
        	# echo "Checking service status $SERVICE..."
        	SC_StatusService
             	;;
    	  *)
        	echo "Invalid argument: $1"
        	echo "Usage: $0 {start|stop|status} [Service Name]"
        	return 1
        	;;
	esac
}



## Main Program ##
Source_ColorLib
#  CheckInput
## CheckResult

CASE_Options "$@"

# StartService
# StopService
# StatusService
#
# ShowConfiguredService

