<h1 id="strace-ltrace-retrace">Strace, Ltrace, Retrace</h1>
<p><strong>Location: Kitchen, Santa’s Castle, Ground Floor</strong><br>
<strong>Elf: Tinsel Upatree</strong></p>
<p>This objective is about getting familiar with the tools to perform a runtime analysis of executables.</p>
<pre><code>kotton_kandy_co@e9d0d43a904b:~$ strace -o out ./make_the_candy
openat(AT_FDCWD, "registration.json", O_RDONLY) = -1 ENOENT (No such file or directory)
</code></pre>
<p>We see, that the application tries to open the file <code>registration.json</code>. This provides us with the expected filename and the file format, so a dummy file is created:</p>
<pre><code>kotton_kandy_co@e9d0d43a904b:~$ cat registration.json
{
        "registration" : "done"
}
kotton_kandy_co@e9d0d43a904b:~$ ltrace -o out ./make_the_candy
strstr("{\n", "Registration") = nil
</code></pre>
<p>We see, that it looks for an upper case <code>Registration</code> in this file, so the file is adjusted:</p>
<pre><code>kotton_kandy_co@e9d0d43a904b:~$ cat registration.json
{
        "Registration" : "done"
}
kotton_kandy_co@e9d0d43a904b:~$ ltrace -o out ./make_the_candy
strstr(": "done"\n", "True") = nil
</code></pre>
<p>Now we see, that the expected value is <code>True</code> instead of the guessed <code>done</code>:</p>
<pre><code>kotton_kandy_co@e9d0d43a904b:~$ cat registration.json
{
        "Registration" : "True"
}
</code></pre>
<p><strong>Achievement: Strace Ltrace Retrace</strong><br>
The Elf provides hints for <a href="https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-11">objective 11</a>:<br>
<strong>Hint: Evil Bit RFC</strong><br>
<strong>Hint: Wireshark Display Filters</strong></p>

