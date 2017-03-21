#!/bin/bash

#  Welcome.sh
#  iTerm2_QuakeTerminal
#
#  Created by Dave on 21/03/2017.
#

SCRIPT_PATH="${BASH_SOURCE[0]}"
SCRIPT_dir="$(echo $SCRIPT_PATH | rev | cut -c 11- | rev)"

Display_script="$(echo $SCRIPT_dir"Displayinfo.sh")"

clear
echo ""
$Display_script
