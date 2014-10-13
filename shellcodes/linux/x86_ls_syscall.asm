BITS 32
	GLOBAL _start
_start:
	xor eax, eax
	push eax
	push byte '.'

	;; sys_open(".", 0, 0)
	mov al, 5      
	mov ebx, esp   
	xor ecx, ecx 
	xor edx, edx 
	int 0x80	

	test eax,eax 
	jz error
	
	;;  getdents(fd,esp,0x3210)
	mov ebx,eax 		
	xor edx,edx
	xor eax,eax
	mov dx, 0x3210 	
	sub esp, edx 	
	mov ecx, esp 	
	mov al, 0x8d 	
	int 0x80

	xchg eax,edx
	
	;; LOOP on struct linux_dirent
.L1:
	test edx,edx
	jz short .END1
	pusha
	lea eax, [ecx+10]

	;; strlen(eax)
	.strlen:	
	mov esi, eax
	.strlen_loop:
	
	movzx edi, byte[eax]
	test edi,edi
	jz .strlen_end
	inc eax
	jmp short .strlen_loop
	
	.strlen_end:
	xor byte[eax], 0xa

	;; write(1,buffer,strlen(buffer))
	xor ebx,ebx
	inc ebx
	mov ecx, esi
	mov edx, eax
	sub edx, esi
	inc edx
	xor eax,eax
	mov al,4
	int 0x80

	popa
	movzx eax, word[ecx+8]
	add ecx, eax
	sub edx,eax
	jmp short .L1
.END1:

error:
	;;  sys_exit
	    xor eax, eax
	    inc eax
	    int 0x80

