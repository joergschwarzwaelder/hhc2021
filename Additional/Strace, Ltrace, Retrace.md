# Strace, Ltrace, Retrace
**Location: Kitchen, Santa's Castle, Ground Floor**
**Elf: Tinsel Upatree**

This objective is about getting familiar with the tools to perform a runtime analysis of executables.
```
kotton_kandy_co@e9d0d43a904b:~$ strace -o out ./make_the_candy
openat(AT_FDCWD, "registration.json", O_RDONLY) = -1 ENOENT (No such file or directory)
```
We see, that the application tries to open the file `registration.json`. This provides us with the expected filename and the file format, so a dummy file is created:
```
kotton_kandy_co@e9d0d43a904b:~$ cat registration.json
{
        "registration" : "done"
}
kotton_kandy_co@e9d0d43a904b:~$ ltrace -o out ./make_the_candy
strstr("{\n", "Registration") = nil
```
We see, that it looks for an upper case `Registration` in this file, so the file is adjusted:
```
kotton_kandy_co@e9d0d43a904b:~$ cat registration.json
{
        "Registration" : "done"
}
kotton_kandy_co@e9d0d43a904b:~$ ltrace -o out ./make_the_candy
strstr(": "done"\n", "True") = nil
```
Now we see, that the expected value is `True` instead of the guessed `done`:
```
kotton_kandy_co@e9d0d43a904b:~$ cat registration.json
{
        "Registration" : "True"
}
```

**Achievement: Strace Ltrace Retrace**
The Elf provides hints for [objective 11](https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-11):
**Hint: Evil Bit RFC**
**Hint: Wireshark Display Filters**
