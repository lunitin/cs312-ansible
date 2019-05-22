# CS 312 Ansible

## Group Members
**Casey Dinsmore**

## Files

prov.sh     - Bash script to execute Ansible deployment
web.yaml    - Ansible Playbook
hosts.ini   - Ansible Hosts file
index.html  - Simple web page w/ variable {{ template_run_date }}
results.txt - Dump of the expected output from prov.sh

## Setup Instructions

* Ensure that pfSense router Interface 1 is NAT
* Ensure that pfSense router Interface 2 is Internal / CS312LAN
* Centos & Alpine VMS Interface 1 should be Internal / CS312LAN

**This script expects a clean DHCP leases file such that the 4 Alpine VMS each receive 192.168.1.20 -> 192.168.1.23. If Alpine VMs are receiving other IP addresses, revert to the initial snapshot or re-import the pfSense VM.**


* Start up pfSense Router VM
* Start up CentOS CLI VM
* Start up 4 Alpine Reference VMs
* Copy & uncompress zip file into Centos CLI VM


## Execution Instructions

**Usage:**

`./prov.sh`

prov.sh will perform the following steps
* Generate SSH Keys
* Keyscan & deploy SSH keys to Alpine VMS
* Execute Ansible playbook 
* Fetch index.html from each Alpine web server

A copy of the expected output can be found in `results.txt`.
