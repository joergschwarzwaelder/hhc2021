# Yara Analysis
**Location: Entry, Santa's Castle, Ground Floor**  
**Elf: Fitzy Shortstack**

This challenge is based on a Cranberry Pi terminal and is about modifying a binary to escape an existing YARA ruleset.

```
snowball2@1f8d0eab2566:~$ ./the_critical_elf_app
yara_rule_135 ./the_critical_elf_app
```
Rule 135 defines `candycane` to be a malicious string.
So the executable was hex dumped and the string changed to `candycone`.

Running the modified binary results in Yara rule 1056 matching:
```
snowball2@1f8d0eab2566:~$ ./the
yara_rule_1056 ./the
```
This rule defines `rogram!!` as malicious.
We replace the first `!` in the binary with a blank.

In the next run Yara rule 1732 matches:
```
snowball2@1f8d0eab2566:~$ ./the
yara_rule_1732 ./the
```
This rule defines executables having at position #1 `0x02464c45` resp. `45 4c 46 02` (which is the case for all ELF binaries) **and** a file size less than 50KB **and** matching several defined strings to be malicious.
To circumvent the match on the file size, 60000 null bytes were appended to the executable:
```
snowball2@08cc17df3e9c:~$ dd if=/dev/zero of=zeroes bs=1 count=60000
60000+0 records in
60000+0 records out
60000 bytes (60 kB, 59 KiB) copied, 0.225491 s, 266 kB/s
snowball2@08cc17df3e9c:~$ cat zeroes >> the
snowball2@08cc17df3e9c:~$ ./the
Machine Running..
Toy Levels: Very Merry, Terry
Naughty/Nice Blockchain Assessment: Untampered
Candy Sweetness Gauge: Exceedingly Sugarlicious
Elf Jolliness Quotient: 4a6f6c6c7920456e6f7567682c204f76657274696d6520417070726f766564
```

**Achievement: Yara Analysis**  
The Elf provides hints for [objective 9](https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-9):  
**Hint: GitHub monitoring in Splunk**  
**Hint: Sysmon Monitoring in Splunk**  
**Hint: Malicious NetCat??**
