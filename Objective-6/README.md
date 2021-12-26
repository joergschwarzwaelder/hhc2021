# Objective 6: Shellcode Primer
**Location: Jack's Office, Frost Tower, 16<sup>th</sup> Floor, https://tracer.kringlecastle.com/**  
**Elf: Ruby Cyster**  
**Hints provided by Chimney Scissorsticks after completion of [Holiday Hero](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/Holiday%20Hero.md)**

This objective is a small training in x86 assembly language (basics and performing system calls). The background is to be able to create shellcode payloads to be used in system attacks.

1. Introduction
2. Loops
3. Getting Started
```asm
ret
```
4. Returning a Value
```asm
mov rax,1337  ; return value
ret
```
5. System Calls
```asm
mov rax,60    ; sys_exit
mov rdi,99    ; return code
syscall
```
6. Calling Into the Void
7. Getting RIP
```asm
call place_below_the_nop
nop
place_below_the_nop:
pop rax       ; pop pointer to NOP from stack
ret
```
8. Hello, World!
```asm
call go
db 'Hello World',0
go:
pop rax       ; pop pointer to string from stack
ret
```
9. Hello World!!
```asm
call go
db 'Hello World!',0
go:
mov rax,1     ; sys_write
mov rdi,1     ; file descriptor 1 (stdout)
pop rsi       ; pop pointer to buffer from stack
mov rdx,12    ; 12 bytes
syscall
ret
```
10. Opening a File
```asm
call go
db '/etc/passwd',0
go:
mov rax,2     ; sys_open
pop rdi       ; pop pointer to filename from stack
mov rsi,0     ; flags
mov rdx,0     ; mode
syscall
ret
```
11. Reading a File
```asm
call go
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
```
The content of the file from step 11 is "Secret to KringleCon success: all of our speakers and organizers, providing the gift of **cyber security knowledge**, free to the community."

**Achievement: Shellcode Primer**  
**Hint: Printer Firmware**  
**Hint: Hash Extension Attacks**  
**Hint: Dropping Files**
