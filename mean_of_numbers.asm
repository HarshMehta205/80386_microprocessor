;-----------------------------------------------------------------------------------------------------------------
;80x86 ALP TO CALCULATE MEAN OF 5 NUMBERS
;-----------------------------------------------------------------------------------------------------------------


section .data

	arr dd 22.4, 56.1, 31.2, 11.9, 40.8	;array elems declaratn
	point db "."
	plen equ $-point
	
	msg db 'Mean is:',10
	msglen equ $-msg
	
	divisor dd 5.0		;divisor since 5 elem
	tent dd 10000.0
	newl db 10

	%macro rw 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
	%endmacro

section .bss

	mean resb 4					
	mean1 resb 4
	count resb 1
	count1 resb 1
	temp resb 1

section .text
global _start
_start:

		mov esi,arr		;initailze ptr to base of array
		mov cx,5
		fldz			;load zero to s[top]			
    	up:	fadd dword[esi]		;add all elem to s[top]		
		add esi,4					
		dec cx
		jnz up
		fdiv dword[divisor]	;div addtn by 5 to get the mean
		fst dword[mean]		;store mean
		fmul dword[tent]
		fbstp tword[mean1]			

		mov ebp,mean1		;initialize ptr to mean			
		rw 1,1,msg,msglen

						
	display:add ebp,9		;moving ptr to end		
		mov byte[count],10	;count=10
	above:  cmp byte[ebp],00	;reading backwards & comparing with 00
		je skip						
		cmp byte[count],02	;if equal to 02 print decimal pt
		jne print
		rw 1,1,point,plen

	print:	mov bl,byte[ebp]
		mov byte[count1],2

	again:	rol bl,4
		mov byte[ebp],bl
		and bl,0fh
		cmp bl,09h
		jbe down
		add bl,07h

	down:	add bl,30h
		mov byte[temp],bl
		rw 1,1,temp,1
		mov bl,byte[ebp]
		dec byte[count1]
		jnz again

	skip:	dec ebp			;displaying
		dec byte[count]
		jnz above
		mov rax,60
		mov rdi,0
		syscall	    



%ifdef COMMENT

harsh@harsh-VirtualBox:~$ nasm -f elf64 mean.asm
harsh@harsh-VirtualBox:~$ ld -o mean mean.o
harsh@harsh-VirtualBox:~$ ./mean
Mean is:
0532.48
%endif






