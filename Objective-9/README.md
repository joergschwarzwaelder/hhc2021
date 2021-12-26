# Objective 9: Splunk!
**Location: Great Room, Santa's Castle, Ground Floor**

**Elf: Angel Candysalt**

This objective is about getting familiar with the Splunk platform.
### Task 1:
Capture the commands Eddie ran most often, starting with git. Looking only at his process launches as reported by Sysmon, record the most common git-related CommandLine that Eddie seemed to use.
```
index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1 User=eddie | stats count by CommandLine | sort – count
```
**git status**

### Task 2:
Looking through the git commands Eddie ran, determine the remote repository that he configured as the origin for the 'partnerapi' repo. The correct one!
```
index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1 User=eddie CommandLine=*git* CommandLine=*partnerapi* | table CommandLine
```
**git@github.com:elfnp3/partnerapi.git**

### Task 3:
Eddie was running Docker on his workstation. Gather the full command line that Eddie used to bring up a the partnerapi project on his workstation.
```
index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1 User=eddie CommandLine=*docker* | table CommandLine
```
**docker compose up**

### Task 4:
Eddie had been testing automated static application security testing (SAST) in GitHub. Vulnerability reports have been coming into Splunk in JSON format via GitHub webhooks. Search all the events in the main index in Splunk and use the sourcetype field to locate these reports. Determine the URL of the vulnerable GitHub repository that the elves cloned for testing and document it here. You will need to search outside of Splunk (try GitHub) for the original name of the repository.
```
index=main | stats count by sourcetype | table sourcetype

index=main sourcetype=github_json
```
**https://github.com/snoopysecurity/dvws-node**

  

### Task 5:
Santa asked Eddie to add a JavaScript library from NPM to the 'partnerapi' project. Determine the name of the library and record it here for our workshop documentation.
```
index=main sourcetype=journald CommandLine="git commit*"
```
  **holiday-utils-js**

  

### Task 6:
Another elf started gathering a baseline of the network activity that Eddie generated. Start with [their search](https://hhc21.bossworkshops.io/en-US/app/SA-hhc/search?q=search%20index%3Dmain%20sourcetype%3Djournald%20source%3DJournald%3AMicrosoft-Windows-Sysmon%2FOperational%20EventCode%3D3%20user%3Deddie%20NOT%20dest_ip%20IN%20(127.0.0.*)%20NOT%20dest_port%20IN%20(22%2C53%2C80%2C443)%20%0A%7C%20stats%20count%20by%20dest_ip%20dest_port&display.page.search.mode=smart&dispatch.sample_ratio=1&workload_pool=&earliest=0&latest=now) and capture the full process_name field of anything that looks suspicious.
```
index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=3 user=eddie NOT dest_ip IN (127.0.0.*) NOT dest_port IN (22,53,80,443)
```
  **/usr/bin/nc.openbsd**

  

### Task 7:
Uh oh. This documentation exercise just turned into an investigation. Starting with the process identified in the previous task, look for additional suspicious commands launched by the same parent process. One thing to know about these Sysmon events is that Network connection events don't indicate the parent process ID, but Process creation events do! Determine the number of files that were accessed by a related process and record it here.
```
index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1 process_name="/usr/bin/nc.openbsd" | Table ParentProcessId
```
→ ParentProcessID 6788

```
index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1  ParentProcessId=6788 | Table CommandLine
```
These **6** files were accessed:
```/home/eddie/.aws/credentials /home/eddie/.ssh/authorized_keys /home/eddie/.ssh/config /home/eddie/.ssh/eddie /home/eddie/.ssh/eddie.pub /home/eddie/.ssh/known_hosts```

### Task 8:
Use Splunk and Sysmon Process creation data to identify the name of the Bash script that accessed sensitive files and (likely) transmitted them to a remote IP address.
```
index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1 process_name="/usr/bin/nc.openbsd" | Table ParentProcessId
```
→ ParentProcessID 6788

```
index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1  ParentProcessId=6788 | Table ParentCommandLine
```
→ /bin/bash **preinstall.sh**

![Achievement](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-9/achievement.png)

Solution of the objective: **whiz**

**Achievement: Splunk!**
