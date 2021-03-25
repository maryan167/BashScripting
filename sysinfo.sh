#!/bin/bash

kernel_name=$(uname -s)
nodename=$(uname -n)
kernel_release=$(uname -r)
kernel_version=$(uname -v)
machine=$(uname -m)
operating_system=$(uname -o)


distrib_id=$(cat /etc/lsb-release | grep -i id | cut -f2 -d=)
distrib_release=$(cat /etc/lsb-release | grep -i release | cut -f2 -d=)
distrib_codename=$(cat /etc/lsb-release | grep -i codename | cut -f2 -d=)
distrib_description=$(cat /etc/lsb-release | grep -i description | cut -f2 -d= | cut -f2 -d\")


net_i_count=$(( $(ip link show | wc -l) / 2 ))
net_i_list=()
net_i_list+=[
for (( i=1; i<=$net_i_count; i++ )); do
	net_int_f=$(ip link show | grep "$i: " 2>/dev/null)
	net_int=${net_int_f#*: }
	net_int=${net_int%:*}
	net_i_list+=$net_int
	if [ $i -ne $net_i_count ] ; then
        net_i_list+=", "
    fi
done
net_i_list+=]


nameserver=$(cat /etc/resolv.conf | grep nameserver | cut -f2 -d' ')
nameserver=$(echo "$nameserver" | tr '\n' ' ')


ufw_status=$(sudo ufw status | cut -f2 -d' ' 2>/dev/null)


printf "kernel_name $kernel_name\nnodename $nodename\nkernel_release $kernel_release\nkernel_version $kernel_version\nmachine $machine\noperating_system $operating_system\n"\
"distrib_id $distrib_id\ndistrib_release $distrib_release\ndistrib_codename $distrib_codename\ndistrib_description $distrib_description\n"\
"network_interfaces $net_i_list\n"\
"nameserver $nameserver\n"\
"ufw_status $ufw_status\n" | /bin/bash json.sh > sysinfo.json

