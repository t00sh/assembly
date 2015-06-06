BITS 64
	GLOBAL _start
_start:
	xor rax, rax
	push rax
	push  byte '.'

	;; sys_open(".", 0, 0)
	mov al, 2      
	mov rdi, rsp   
	xor rsi, rsi 
	xor rdx, rdx 
	syscall	

	;;  getdents(fd,esp,0x3210)
	mov rdi,rax 		
	xor rdx,rdx
	xor rax,rax
	mov dx, 0x3210 	
	sub rsp, rdx 	
	mov rsi, rsp 	
	mov al, 78 	
	syscall

	xchg rax,rdx

	;; write(1, rsp, rdx)
	xor rax, rax
	xor rdi,rdi
	
	inc eax
	inc edi
	mov rsi, rsp
	syscall


	xor rax, rax
	mov al, 60
	syscall


