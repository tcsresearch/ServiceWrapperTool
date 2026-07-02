# Colors for Cecho-like output
CONFIG_DIR="$(pwd)"
COLORS_FILE="SanityChecker_Colors.conf"
FUNCTIONS_FILE="ServiceWrapperTool.bfunc"

#----------------------------------------------------#

# TODO: Add else statements and echo ERROR statements, etc.

# Source our Color Config
if [ -f "$CONFIG_DIR"/"$COLORS_FILE" ]; then
		# shellcheck source=/dev/null
        source "$CONFIG_DIR"/"$COLORS_FILE"
fi

# Source our Functions File
if [ -f "$CONFIG_DIR"/"$FUNCTIONS_FILE" ]; then
		# shellcheck source=/dev/null
        source "$CONFIG_DIR"/"$FUNCTIONS_FILE"
fi

#----------------------------------------------------#

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
