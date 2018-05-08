#!/bin/bash
# used some from advanced script to have multiple ports: use an equal number of guest and host ports

# Update the following variables to fit your setup
Guest_name=tasperin
Guest_ipaddr=192.168.122.7
Host_ipaddr=46.4.11.19
Host_port=( '25' '143' '465' '587' )
Guest_port=( '25' '143' '465' '587' )

length=$(( ${#Host_port[@]} - 1 ))
if [ "${1}" = "${Guest_name}" ]; then
   if [ "${2}" = "stopped" ] || [ "${2}" = "reconnect" ]; then
       for i in `seq 0 $length`; do
               iptables -t nat -D PREROUTING -d ${Host_ipaddr} -p tcp --dport ${Host_port[$i]} -j DNAT --to ${Guest_ipaddr}:${Guest_port[$i]}
               iptables -D FORWARD -d ${Guest_ipaddr}/32 -p tcp -m state --state NEW -m tcp --dport ${Guest_port[$i]} -j ACCEPT
       done
   fi
   if [ "${2}" = "start" ] || [ "${2}" = "reconnect" ]; then
       for i in `seq 0 $length`; do
               iptables -t nat -A PREROUTING -d ${Host_ipaddr} -p tcp --dport ${Host_port[$i]} -j DNAT --to ${Guest_ipaddr}:${Guest_port[$i]}
               iptables -I FORWARD -d ${Guest_ipaddr}/32 -p tcp -m state --state NEW -m tcp --dport ${Guest_port[$i]} -j ACCEPT
       done
   fi
fi

Guest_name=sorridia
Guest_ipaddr=192.168.122.9
Host_ipaddr=46.4.11.19
Host_port=( '8080' '443' )
Guest_port=( '80' '443' )

length=$(( ${#Host_port[@]} - 1 ))
if [ "${1}" = "${Guest_name}" ]; then
   if [ "${2}" = "stopped" ] || [ "${2}" = "reconnect" ]; then
       for i in `seq 0 $length`; do
               iptables -t nat -D PREROUTING -d ${Host_ipaddr} -p tcp --dport ${Host_port[$i]} -j DNAT --to ${Guest_ipaddr}:${Guest_port[$i]}
               iptables -D FORWARD -d ${Guest_ipaddr}/32 -p tcp -m state --state NEW -m tcp --dport ${Guest_port[$i]} -j ACCEPT
       done
   fi
   if [ "${2}" = "start" ] || [ "${2}" = "reconnect" ]; then
       for i in `seq 0 $length`; do
               iptables -t nat -A PREROUTING -d ${Host_ipaddr} -p tcp --dport ${Host_port[$i]} -j DNAT --to ${Guest_ipaddr}:${Guest_port[$i]}
               iptables -I FORWARD -d ${Guest_ipaddr}/32 -p tcp -m state --state NEW -m tcp --dport ${Guest_port[$i]} -j ACCEPT
       done
   fi
fi

