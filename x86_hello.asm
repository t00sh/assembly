global _start
section .text

_start:
	pusha

	push 0xa
	push 'o!!!'
	push 'Hell'

	xor eax, eax
	xor ebx, ebx
	xor edx, edx
	
	mov al, 4
	inc ebx
	mov ecx, esp
	mov dl, 9
	int 0x80

	add esp, 12
	
	popa
