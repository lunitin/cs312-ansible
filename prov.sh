#!/bin/bash


PASS="password"

# Generate ssh key
echo -e "Generating SSH key..."
KEYGEN=$(ssh-keygen -t rsa -f id_rsa -b 2096 -N '')
echo "Done"

echo "Creating Ansible support files..."
# Set up core hosts.ini file
cat << EOF > hosts.ini
[mynodes]
192.168.1.20

[mynodes:vars]
ansible_connection=ssh
ansible_port=22
ansible_user=root
ansible_python_interpreter=/usr/bin/python3
EOF

# Set up index.html file
cat << EOF > index.html
<html>
<head><title>My Test Page</title></head>
<body>
<p>TEST PAGE</p>
<p>This page was last provisioned on {{ template_run_date }}</p>
</body>
</html>
EOF

# Set up Ansible Playbook
cat << EOF > web.yaml
---
- hosts: mynodes
  gather_facts: no
  become: true
  tasks:
  - name: Install Python 3
    raw: apk -U add python3
  - name: Install/Update Apache 
    apk:
      name: apache2
      state: latest
  - name: Copy in index.html
    template:
      src: index.html
      dest: /var/www/localhost/htdocs/index.html
    notify:
    - restart apache
  - name: Fire up Apache
    service:
      name: apache2
      state: started
  handlers:
    - name: restart apache
      service:
        name: apache2
        state: restarted
EOF
 

# Provision Web servers
echo -e "Deploying SSH keys..."
for i in {0..0}; do
	ssh-keyscan 192.168.1.2${i} >> ~/.ssh/known_hosts
	echo "${PASS}" | sshpass ssh-copy-id root@192.168.1.2${i}
done
echo "Done"


ansible-playbook web.yaml -i ./hosts.ini


echo "Fetching HTTP results"
for i in {0..0}; do
	curl http://192.168.1.2${i}
done
