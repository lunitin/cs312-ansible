#!/bin/bash

PASS="password"

# Check for server availability
echo -e "\n\e[35m=== Network Tests...\e[0m"
for i in {20..23}; do
	UP=$(ping -c 1 192.168.1.${i})
	if [ $? -ne 0 ]; then
		echo "  \e[31m= 192.168.1.${i} appears to be down, check networking\e[0m"
		exit 1
	else 
		echo -e "  \e[32m= 192.168.1.${i} is up\e[0m"
	fi
done

echo -e "\n\e[35m=== Generating SSH key...\e[0m"
ssh-keygen -f ~/.ssh/id_rsa -t rsa -b 2048 -N ''

echo -e "\n\e[35m=== Deploying SSH keys...\e[0m"
for i in {20..23}; do
	ssh-keyscan 192.168.1.${i} >> ~/.ssh/known_hosts 
	echo "${PASS}" | sshpass ssh-copy-id root@192.168.1.${i} > /dev/null 2>&1
done

echo -e "\n\e[35m=== Executing Ansible Playbook...\e[0m"
ansible-playbook web.yaml -i ./hosts.ini


for i in {20..23}; do
	echo -e "\n\e[35m=== Fetching HTTP results from 192.168.1.${i}\n\e[0m"
	curl -s  http://192.168.1.${i}
done

exit 0
