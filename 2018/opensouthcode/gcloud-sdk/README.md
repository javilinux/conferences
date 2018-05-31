#### Introduccion a Google Cloud SDK

*Javier Ramirez Molina*

*OpenShift Support at Red Hat*

*OpenSouthcode 2018*

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
- Or use cloud shell

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
export GCE_EMAIL=jotb-304@jotb18-openshift.iam.gserviceaccount.com
export GCE_CREDENTIALS_FILE_PATH=/home/jaramire/Downloads/jotb18-openshift-a7b630842800.json
gcloud auth activate-service-account jotb-304@jotb18-openshift.iam.gserviceaccount.com --key-file=/home/jaramire/Downloads/jotb18-openshift-a7b630842800.json
```
---
### Project init
- Link to Billing Account
- Crate project / set default project

---

### Create an instance

```sh
gcloud compute instances create instance1 --image-family centos-7 --image-project centos-cloud --machine-type g1-small --tags default-allow-http,default-allow-https,openshift-console
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
### Gcloud scripting
- Disable prompts (--quiet)
- Handling ouput (--filter , --format)
```sh
gcloud compute instances list --format='table(name:sort=1, EXTERNAL_IP, status)'
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

```sh
for i in `seq -w 0 23` ; do gcloud compute instances add-metadata lab-0$i --metadata-from-file startup-script=foo.sh ; done
```
---
### Crear una imagen

---
### Metadata

---
### DNS

---
### Firewall rules

---
### IPs

---
### Preguntas?

---
### Tipos de maquina

--- 
### Quotas

---
### Scripting

---
### Uso con ansible

---
### SSH key

