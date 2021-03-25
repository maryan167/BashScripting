#!/bin/bash

uptime=$(uptime | xargs)

cur_users=$(who | cut -f1 -d' ' | tr '\n' ' ')

last_users=$(last -4 -R)

ps_mem=$(ps -eo user,pid,ppid,cmd,%mem,%cpu --sort=-%mem | head | sed -e "s/%/%%M/g")
ps_cpu=$(ps -eo user,pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head | sed "s/%/%%/g")

tcp_udp=$(sudo lsof -i -P -n)

free_m=$(free)

df_=$(df -h | sed "s/%/%%/g")


printf \
"# UPTIME\n$uptime\n\n\n"\
"# CURRENT USERS\n$cur_users\n\n\n"\
"# LAST USERS\n$last_users\n\n\n"\
"# TOP-10 processes by RAM usage\n$ps_mem\n\n\n"\
"# TOP-10 processes by CPU usage\n$ps_cpu\n\n\n"\
"# Open TCP/UDP ports\n$tcp_udp\n\n\n"\
"# Virtual Memory usage\n$free_m\n\n\n"\
"# Usage of disk space\n$df_\n\n\n" > audit.log # | tee audit.log

