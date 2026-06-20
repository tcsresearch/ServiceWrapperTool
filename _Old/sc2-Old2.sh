#!/bin/env bash

# This script serves as a wrapper around systemctl with Cecho-enabled responses to services starting/stopping, etc.
#
# TODO: Make interactive?  Example: checkinghh if a service is started; ask to start it if not running.
#
## Define Colors Library ##
SC_ColorsLib="./SanityChecker_Colors.conf"

function Source_ColorLib() {
## Source Colors Library ##
	if [ ! -f "$SC_ColorsLib" ]; then
		echo "ERROR!  Colors Library $SC_ColorsLib NOT Found.  Quitting."
		return 1
	else 
		source "$SC_ColorsLib"
	fi
}

## TODO: Implement main program feature to return colored repsonse

function CheckInput() {
 # Check if input is provided
    if [ -z "$1" ]; then
        echo -e "${RED}[!] ERROR: No arguments provided. ${NC}"
        return
    fi

    # TODO: Alter code to use systemctl and get status / show color
    # Check existence
    if [ -e "$1" ]; then
        echo -e "${GREEN}[ OK ]${NC} $1 exists."
    else
        echo -e "${RED}[ NOT OK ]${NC} $1 does not exist."
    fi
}


## Main Program ##
Source_ColorLib
CheckInput

