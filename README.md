# CS 312 Ansible

## Group Members
**Casey Dinsmore**


## Setup Instructions

* Ensure that pfSense router Interface 1 is NAT
* Ensure that pfSense router Interface 2 is Internal / CS312LAN
* Centos & Alpine VMS Interface 1 should be Internal / CS312LAN

**This script expects a clean DHCP reservation list such that the 4 Alpine VMS eacn receive 192.168.1.20 -> 192.168.1.23. If Alpine VMs are receiving other IP addresses, revert to the initial snapshot or re-import the pfSense VM.**


* Start up pfSense Router
* Start up CentOS Reference_CLI VM
* Start up 4 Alpine Reference VMs

* Copy zip file into Reference VM


## Execution Instructions

prov.sh will perform the following steps
* Generate SSH Keys
* Keyscan & deploy SSH keys to Alpine VMS
* Execute Ansible playbook 
* Fetch index.html from each Alpine web server

**Usage:**

`./prov.sh`


A copy of the expected output can be found in results.txt.
