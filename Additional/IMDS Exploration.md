<h1 id="imds-exploration">IMDS Exploration</h1>
<p><strong>Location: Restroom, Frost Tower, 16<sup>th</sup> Floor</strong><br>
<strong>Troll: Noxious O. D’or</strong></p>
<p>This objective is a training about what data could be retrieved from the Instance Metadata Service (IMDS) in cloud environments.<br>
It is completely guided exercise.</p>
<pre><code>elfu@c27f40ac7165:~$ ping -c1 169.254.169.254
PING 169.254.169.254 (169.254.169.254) 56(84) bytes of data.
64 bytes from 169.254.169.254: icmp_seq=1 ttl=64 time=0.014 ms

--- 169.254.169.254 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.014/0.014/0.014/0.000 ms
elfu@c27f40ac7165:\~$ next
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest
dynamic
meta-data
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/dynamic
fws/instance-monitoring
instance-identity/document
instance-identity/pkcs7
instance-identity/signature
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/dynamic/instance-identity/document
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
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/dynamic/instance-identity/document | jq
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
next
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/meta-data
ami-id
ami-launch-index
[...]
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/meta-data/public-hostname
ec2-192-0-2-54.compute-1.amazonaws.comelfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/meta-data/public-hostname; echo
ec2-192-0-2-54.compute-1.amazonaws.com
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/meta-data/iam/security-credentials; echo
elfu-deploy-role
elfu@c27f40ac7165:\~$ curl http://169.254.169.254/latest/meta-data/iam/security-credentials/elfu-deploy-role;echo
{
        "Code": "Success",
        "LastUpdated": "2021-12-02T18:50:40Z",
        "Type": "AWS-HMAC",
        "AccessKeyId": "AKIA5HMBSK1SYXYTOXX6",
        "SecretAccessKey": "CGgQcSdERePvGgr058r3PObPq3+0CfraKcsLREpX",
        "Token": "NR9Sz/7fzxwIgv7URgHRAckJK0JKbXoNBcy032XeVPqP8        /tWiR/KVSdK8FTPfZWbxQ==",
        "Expiration": "2026-12-02T18:50:40Z"
}
elfu@c27f40ac7165:\~$ next
elfu@c27f40ac7165:\~$ cat gettoken.sh
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
elfu@c27f40ac7165:\~$ source gettoken.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    44  100    44    0     0  44000      0 --:--:-- --:--:-- --:--:-- 44000
elfu@c27f40ac7165:\~$ echo $TOKEN
Uv38ByGCZU8WP18PmmIdcpVmx00QA3xNe7sEB9Hixkk=
elfu@c27f40ac7165:\~$ curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/placement/region; echo
np-north-1e
</code></pre>
<p><strong>Achievement: IMDS Exploration</strong></p>
<p>The Troll provides hints for <a href="https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-10">objective 10</a>:<br>
<strong>Hint: AWS IMDS Documentation</strong></p>

