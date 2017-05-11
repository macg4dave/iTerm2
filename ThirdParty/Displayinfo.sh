#!/bin/bash 
make_pref="$(defaults read com.quaketerminal.iterm2.plist show_welcome)"
my_user="$(whoami)"
text_user=$my_user



if [ "$make_pref" == "true" ]; then
top -l 1 > /tmp/"$text_user"quaketerminal/topstats

macos_ver="$(sw_vers | grep ProductVersion | sed 's/ProductVersion/MacOS/g' | awk '{print $2}')"

#Uptime
uptime_time="$(uptime | sed 's/.*up \([^,]*\), .*/\1/')"

uptime_load="$(uptime | rev | awk '{print $1, $2, $3}' | rev)"

#Network
network_down="$(cat /tmp/"$text_user"quaketerminal/topstats | grep "Networks" | awk '{print $3}' | sed -e 's/[\/&]/\\ /g' | awk '{print $2}')"

network_up="$(cat /tmp/"$text_user"quaketerminal/topstats | grep "Networks" | awk '{print $5}' | sed -e 's/[\/&]/\\ /g' | awk '{print $2}')"

#CPU Usage
cpu_used_user="$(cat /tmp/"$text_user"quaketerminal/topstats | grep "CPU usage" | awk '{print $3}')"

cpu_used_sys="$(cat /tmp/"$text_user"quaketerminal/topstats | grep "CPU usage" | awk '{print $5}')"

cpu_used_idle="$(cat /tmp/"$text_user"quaketerminal/topstats | grep "CPU usage" | awk '{print $7}')"


#Disk name
startup_name="$(osascript -e 'tell app "Finder" to get name of startup disk')"

startup_size="$(df -H / | awk '{print $2}' | awk 'NR==2')"

startup_used="$(df -H / | awk '{print $3}' | awk 'NR==2')"

startup_free="$(df -H / | awk '{print $4}' | awk 'NR==2')"


#colours
colour_stop="\033[0m"

colour_red="\033[31m"

colour_blue="\033[36m"

colour_yellow="\033[33m"

text_under="\033[4m"

text_hidden="\033[34m"


#Startup Display

del_temp="$(rm /tmp/"$text_user"quaketerminal/terminfo)"
make_temp="$(touch /tmp/"$text_user"quaketerminal/terminfo)"

if [ ! -f /tmp/"$text_user"quaketerminal/terminfo ]; then
    ${make_temp}
else

${del_temp}
${make_temp}

fi

tmp_file="/tmp/"$text_user"quaketerminal/terminfo"

echo -e "$colour_yellow" "MacOS" "*&*" "Boot Volume" "*&*" "Volumes Size" "*&*" "Total Used" "*&*" "Total Free" "*&*" "Uptime" "*&*" "Load Averages"  "*&*" "CPU User" "*&*" "CPU System" "*&*" "CPU Idle" "*&*" "Network Down" "*&*" "Network Up" "$colour_stop" >> $tmp_file
echo -e "$colour_blue"  "${macos_ver}" "*&*" "${startup_name}" "*&*" "${startup_size}"bs "*&*" "${startup_used}"bs "*&*" "${startup_free}"bs "*&*" "${uptime_time}" "*&*" "${uptime_load}" "*&*" "${cpu_used_user}" "*&*" "${cpu_used_sys}" "*&*" "${cpu_used_idle}" "*&*" "${network_down}" "*&*" "${network_up}" "$colour_stop" >> $tmp_file


#prints screen
cat /tmp/"$text_user"quaketerminal/terminfo | awk '$1=$1' > /tmp/"$text_user"quaketerminal/termdone

display_center(){
    columns="$(tput cols)"
    while IFS= read -r line; do
        printf "%*s\n" $(( (${#line} + columns) / 2)) "$line"
    done < "$1"
}

cat /tmp/"$text_user"quaketerminal/termdone | column -s "*&*" -t 

logo_display="$(cat /tmp/"$text_user"quaketerminal/logodisplay)"
echo " "
echo " "
echo " "

echo -e "$colour_yellow" "$logo_display" "$colour_stop"


echo " "
echo " "
echo " "
echo " "
fi
