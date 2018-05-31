#### Introduccion a Google Cloud SDK

*Javier Ramirez Molina*

*OpenShift Support at Red Hat*

*OpenSouthcode 2018*

![opensouthcode logo](opensouthcodelogo.jpg)

---
#### Google Cloud Products

- Compute
- Apps
- Kubernetes
- Storage
- Databases
- Cloud AI
- API and Ecosystems (Maps, monetization)
- Big Data

---
#### Google Cloud Management Tools

- Console
- Stackdriver
- Monitoring
- Logging
- Trace
- Error reporting
- Debugger
- Profiler
- Cloud Shell

---
#### Google Cloud Network

- Virtual Private Cloud
- Cloud Load Balancing
- Cloud Armor
- Cloud CDN
- DNS

---
#### Google Developer Tools

- Container Registry
- Container Builder
- Cloud Source Repositories
- Cloud Tools for Powershell, Eclipse, IntelliJ, Visual Stuido...
- Cloud SDK

---
### Free tier

- 300$ to use in 12 Months
    - Some limitations
    - Requires Credit Card
    - Upgrade at the end of the trial
- [Always Free Products](https://cloud.google.com/free/)

---
### Install sdk

- Repositories for Debian, Ubuntu, Fedora, Red Hat, CentOS
- Installer for Windows
- Tar.gz for OSX and other Linux
- Requires python 2

---
## Cloud shell

- Temporary g1-small
- Web browser
- Built-in code editor BETA
- 5 GB of persistent disk storage
- Pre-installed Google Cloud SDK and other tools
- Language support for Java, Go, Python, Node.js, PHP, Ruby and .NET
- Built-in authorization

---
### Initialization
```sh
gcloud init
```
```sh
gclod config configurations
```

---
### Service Account
- Need to create on the console
- Roles and permissions

```sh
export GCE_PROJECT=jotb18-openshift
export GCE_EMAIL=jotb-304@jotb18-openshift.....
export GCE_CREDENTIALS_FILE_PATH=$path_file.json
gcloud auth activate-service-account jotb-304@.... /
--key-file=$path_file.json
```

---
### Project init
- Link to Billing Account
- Create project / set default project

---
### Create an instance

```sh
gcloud compute instances create instance1 \
--image-family centos-7 --image-project centos-cloud \
--machine-type g1-small \ 
--tags default-allow-http,default-allow-https,openshift-console
```
```sh
gcloud compute images list
```
```sh
gcloud compute machine-types list
```

---
### Operate an instance

```sh
gcloud compute instances start/stop/delete $instance_name
```

---
### SSH key
- Specific formatting:
```sh
[USERNAME_2]:ssh-rsa [EXISTING_KEY_VALUE_2] [USERNAME_2]
[USERNAME_3]:ssh-rsa [NEW_KEY_VALUE] [USERNAME_3]
```
- They can be set at project level
```sh
gcloud compute project-info add-metadata --metadata-from-file ssh-keys=[LIST_PATH]
```
- They can be set per instance
```sh
gcloud compute instances add-metadata [INSTANCE_NAME] \
--metadata-from-file ssh-keys=[LIST_PATH]
```
- We can block ssh in specific instances
```sh
gcloud compute instances add-metadata [INSTANCE_NAME] \
--metadata block-project-ssh-keys=TRUE
```
---
### Serial port
```sh
gcloud compute instances add-metadata [INSTANCE_NAME]  \
    --metadata=serial-port-enable=1
gcloud compute connect-to-serial-port [INSTANCE_NAME]
```

---
### Firewall rules
```sh
gcloud compute firewall-rules create openshift-console \
--allow tcp:8443 --description "Allow incoming traffic on TCP port 8443" \ 
--direction INGRESS --target-tags openshift-console

gcloud compute firewall-rules create default-allow-http \
--allow tcp:80 --description "Allow incoming traffic on TCP port 80" \
--direction INGRESS --target-tags default-allow-http

gcloud compute firewall-rules create default-allow-https \
--allow tcp:443 --description "Allow incoming traffic on TCP port 443" \
--direction INGRESS --target-tags default-allow-https
```

---
### Create image
```sh
gcloud compute images create centos7oc \
--source-disk=instance1

gcloud compute instances create chiquito --image centos7oc \
--image-project jotb18-openshift --machine-type g1-small \
--tags default-allow-http,default-allow-https,openshift-console
```

---
### Metadata
```sh
gcloud compute instances add-metadata lab-0$i \
--metadata-from-file startup-script=foo.sh

gcloud compute instances add-metadata lab-0$i \
--metadata startup-script=/root/start_cluster.sh

gcloud compute instances remove-metadata \
--keys=startup-script lab-0$i 
```

---
### Gcloud scripting
- Disable prompts (--quiet)
- Handling ouput (--filter , --format)
```sh
gcloud compute instances list \
--format='table(name:sort=1, EXTERNAL_IP, status)'
```

---
### Bash scripting
```sh
for ip in `gcloud compute instances list --format='table(EXTERNAL_IP)'`
do
  echo
  echo MACHINE: $ip
  echo -e "Manager App:\thttp://manager-app-break-fix.$ip.nip.io"
  echo -e "demo app:\thttp://demoapp-demo.$ip.nip.io"
  echo -e "tty:\t\thttp://online-oc-tty.$ip.nip.io"
done
```

---
### External IPs
- By default they are ephemeral IPs
- You can reserve static IP addresses:

<small>
```sh
gcloud compute addresses create $name

gcloud compute instances create [INSTANCE_NAME] --address [IP_ADDRESS]

gcloud compute instances add-access-config [INSTANCE_NAME] --access-config-name [ACCESS_CONFIG_NAME] --address [IP_ADDRESS]
```
</small>


---
### Quotas
```sh
gcloud compute project-info describe --project jotb18-openshift
```

- You can't edit them, you request them to be edited.
- Free tier has some restrictions

---
### Ansible Module
- https://docs.ansible.com/ansible/2.4/guide_gce.html
    - Creating instances
    - Controlling network access
    - Working with persistent disks
    - Managing load balancers
    - Inventory plugin - Ansible dynamic inventory.

---
### API oc cluster up

<small>
```sh
oc cluster up --public-hostname=$(curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip)
```
</small>

---
### DNS
<small>
```sh
gcloud dns record-sets transaction start -z=espetos-net
gcloud dns record-sets transaction add -z=espetos-net --name="instance2.espetos.net." --type=A --ttl="300" "35.189.124.139"
gcloud dns record-sets transaction add -z=espetos-net --name="instance3.espetos.net." --type=A --ttl="300" "35.230.135.245"
gcloud dns record-sets transaction add -z=espetos-net --name="instance4.espetos.net." --type=A --ttl="300" "35.197.226.185"
gcloud dns record-sets transaction add -z=espetos-net --name="instance5.espetos.net." --type=A --ttl="300" "35.197.226.185"
gcloud dns record-sets transaction execute -z=espetos-net
```
</small>
---
### THANK YOU!

- Questions?
- @javilinux
- javilinux@gmail.com
