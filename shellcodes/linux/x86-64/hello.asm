global _start
section .text

_start:
	jmp MSG
RET:
	pop rsi

	xor rax, rax
	xor rdx, rdx
	xor rdi,rdi
	
	mov al, 1
	inc rdi
	
	mov dl, len
	syscall

	ret

MSG:
	call RET
msg:	db 'Hello world !',0xa
len:	equ $-msg
