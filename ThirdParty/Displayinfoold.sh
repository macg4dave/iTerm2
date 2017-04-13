#!/bin/bash
clear
macos_ver="$(sw_vers | grep ProductVersion | sed 's/ProductVersion/MacOS/g' | awk '{print $2}')"

#CPU Names and speeds

#cpu_core_info="$(sysctl -n machdep.cpu.core_count)"

#cpu_locig_info="$(sysctl -n machdep.cpu.cores_per_package)"

#cpu_name_info="$(sysctl -n machdep.cpu.brand_string | sed 's/(R)//g'| sed 's/(TM)//g'| awk '{print $1,$2,$3'})"

#cpu_speed_info="$(sysctl -n machdep.cpu.brand_string | sed 's/(R)//g'| sed 's/(TM)//g' | awk '{print $6'})"

#cpu_mhzspeed_info="$(sysctl -n machdep.tsc.frequency)"

#cpu_truespeed_info="$(gnumfmt --to=si --suffix=hz $cpu_mhzspeed_info)"

#Uptime
uptime_time="$(uptime | sed 's/.*up \([^,]*\), .*/\1/')"

uptime_load="$(uptime | rev | awk '{print $1, $2, $3}' | rev)"

uptime_user="$(uptime | awk '{print $4}')"

#RAM Math
#cpu_ramtotal_info="$(sysctl -n hw.memsize)"

#cpu_trueram_info="$(gnumfmt --to=iec --suffix=bs $cpu_ramtotal_info)"

#cpu_ramused_info="$(top -l 1 | grep PhysMem | awk '{print $2}')"

#cpu_truewired_info="$(top -l 1 | grep PhysMem | awk '{print $4}' | cut -c 2- | gnumfmt  --from=si --to=iec --suffix B)"

#cpu_truefree_info="$(top -l 1 | grep PhysMem | awk '{print $6}' | gnumfmt  --from=si --to=iec --suffix B)"

#CPU Usage

cpu_used_user="$(top -l 1 | grep "CPU usage" | awk '{print $3}')"

cpu_used_sys="$(top -l 1 | grep "CPU usage" | awk '{print $5}')"

cpu_used_idle="$(top -l 1 | grep "CPU usage" | awk '{print $7}')"

#Disk read/write

#disk_read="$(top -l 1 | grep "Disks: " | awk '{print $2}' | grep -o '/.*' | cut -c 2- | gnumfmt  --from=si --to=iec --suffix B)"
#disk_write="$(top -l 1 | grep "Disks: " | awk '{print $4}' | grep -o '/.*' | cut -c 2- | gnumfmt  --from=si --to=iec --suffix B)"

#Disk name
startup_name="$(osascript -e 'tell app "Finder" to get name of startup disk')"

startup_size="$(df -H / | awk '{print $2}' | awk 'NR==2')"

startup_used="$(df -H / | awk '{print $3}' | awk 'NR==2')"

startup_free="$(df -H / | awk '{print $4}' | awk 'NR==2')"

#startup_precent="$(df -H / | awk '{print $5}' | awk 'NR==2')"


#colours
colour_stop="\033[0m"

colour_red="\033[31m"

colour_green="\033[36m"

colour_yellow="\033[33m"

text_under="\033[4m"

text_hidden="\033[34m"


#Startup Display

del_temp="$(rm /tmp/terminfo)"
make_temp="$(touch /tmp/terminfo)"

if [ ! -f /tmp/terminfo ]; then
    ${make_temp}
else

${del_temp}
${make_temp}

fi

tmp_file="/tmp/terminfo"
 


#clear

echo -e "$colour_yellow" "MacOS" "*&*" "Boot Volume" "*&*" "Volumes Size" "*&*" "Total Used" "*&*" "Total Free" "*&*" "Uptime" "*&*" "Load Averages"  "*&*" "CPU User" "*&*" "CPU System" "*&*" "CPU Idle" "$colour_stop" >> $tmp_file
echo -e "$colour_green"  "${macos_ver}" "*&*" "${startup_name}" "*&*" "${startup_size}"bs "*&*" "${startup_used}"bs "*&*" "${startup_free}"bs "*&*" "${uptime_time}" "*&*" "${uptime_load}" "*&*" "${cpu_used_user}" "*&*" "${cpu_used_sys}" "*&*" "${cpu_used_idle}" "$colour_stop" >> $tmp_file
#Disk info

#echo -e "$colour_yellow" "MacOS" "*&*" "Root" "*&*" "Volumes Size" "*&*" "Total Used" "*&*" "Total Free" "$colour_stop" >> $tmp_file
#echo -e "$colour_green"  "${macos_ver}" "*&*" "${startup_name}" "*&*" "${startup_size}"bs "*&*" "${startup_used}"bs "*&*" "${startup_free}"bs "$colour_stop" >> $tmp_file

echo -e "$text_hidden" "-" "*&*" "$colour_stop" >> $tmp_file
#MacOs info

#echo -e "$colour_yellow" "MacOS" "*&*"  "Uptime" "*&*" "Disk Read"  "*&*" "Disk Write" "$colour_stop" >> $tmp_file
#echo -e "$colour_green"  "${macos_ver}"  "*&*" "${uptime_time}" "*&*" "${disk_read}" "*&*" "${disk_write}" "$colour_stop" >> $tmp_file

echo -e "$text_hidden" "-" "*&*" "$colour_stop" >> $tmp_file

#CPU info
#echo -e "$colour_yellow"  "CPU" "*&*" "Cores" "*&*" "Threads" "*&*" "Clock" "$colour_stop" >> $tmp_file
#echo -e "$colour_green"  "${cpu_name_info}" "*&*" "${cpu_core_info}" "*&*" "${cpu_locig_info}" "*&*" "${cpu_truespeed_info}" "$colour_stop" >> $tmp_file



#CPU usage info

#echo -e "$colour_yellow"  "Uptime" "*&*" "Load Averages"  "*&*" "User" "*&*" "System" "*&*" "Idle" "$colour_stop" >> $tmp_file
#echo -e "$colour_green"  "${uptime_time}" "*&*" "${uptime_load}" "*&*" "${cpu_used_user}" "*&*" "${cpu_used_sys}" "*&*" "${cpu_used_idle}" "$colour_stop" >> $tmp_file

#echo -e "$text_hidden" "-" "*&*" "$colour_stop" >> $tmp_file

#RAM info
#echo -e "$colour_yellow"  "RAM" "*&*" "Used"  "*&*" "Wired" "*&*" "Free" "$colour_stop" >> $tmp_file
#echo -e "$colour_green"  "${cpu_trueram_info}" "*&*" "${cpu_ramused_info}"bs "*&*" "${cpu_truewired_info}" "*&*" "${cpu_truefree_info}" "$colour_stop" >> $tmp_file

#echo -e "$text_hidden" "-" "*&*" "$colour_stop" >> $tmp_file


#echo -e "$text_hidden" "-" "*&*" "$colour_stop" >> $tmp_file

#echo -e "$text_hidden" "-" "*&*" "$colour_stop" >> $tmp_file
#echo -e "$text_hidden" "-" "*&*" "$colour_stop" >> $tmp_file
#echo -e "$text_hidden" "-" "*&*" "$colour_stop" >> $tmp_file



#prints screen
cat /tmp/terminfo | awk '$1=$1' > /tmp/termdone



display_center(){
    columns="$(tput cols)"
    while IFS= read -r line; do
        printf "%*s\n" $(( (${#line} + columns) / 2)) "$line"
    done < "$1"
}

cat /tmp/termdone | column -s "*&*" -t 

logo_display="$(cat /tmp/logodisplay)"

echo -e "$colour_red" "$logo_display"

#old code

#cpu_ramwired_info="$(top -l 1 | grep PhysMem | awk '{print $4}' | cut -c 2- | rev | cut -c 2- | rev)"
#time_ramwire_size="$(echo $cpu_ramwired_info "*" "1000000" | bc)"

#cpu_ramfree_info="$(top -l 1 | grep PhysMem | awk '{print $6}' | rev | cut -c 2- | rev)"
#time_ramfree_size="$(echo $cpu_ramfree_info "*" "1000000" | bc)"