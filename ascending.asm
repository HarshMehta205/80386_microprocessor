;-----------------------------------------------------------------------------------------------------------------
;80x86 ALP FOR ASCENDING ORDER OF THE NUMBERS IN ARRAY USING NASM 
;-----------------------------------------------------------------------------------------------------------------

section .data
msg db "sorted array in ascending order:",10
msglen equ $-msg
arr db 88h,45h,01h,98h,34h		;Harcoded input of array in our program

;-----------------------------------------------------------------------------------------------------------------

%macro rw 4				;definition of macro
     mov rax, %1
     mov rdi, %2
     mov rsi, %3
     mov rdx, %4
     syscall
%endmacro

;-----------------------------------------------------------------------------------------------------------------

section .bss
result resb 10

;-----------------------------------------------------------------------------------------------------------------
;WE USE BUBBLE SORT

section .text
global _start
_start:


		mov bl,5		;number of iterations for 5 nos
					;since we have 5 numbers the number of iteration will be 5
loop_outer: 	mov cl,4		;number of passes is 5-1 i.e 4
					;number of passes in each loop will be 4
		mov rsi,arr

up: 		mov al,byte[rsi]	;copying the first number of array in al
		cmp al,byte[rsi+1]	;comparing the second number with the first number
		jbe only_inc		;no swwaping 
		xchg al,byte[rsi+1]	;swaping
		mov byte[rsi],al

only_inc:
		inc rsi
		dec cl			;decrementing for inner loop
		jnz up			
		dec bl			;decrementing for outer loop
		jnz loop_outer
		rw 1,1,msg,msglen
;-----------------------------------------------------------------------------------------------------------------
;unpacking of data


		mov rdi,arr
		mov rsi,result
		mov dl,5

disp_loop1:	mov cl,2		;since we want to do unpacking of 2 numbers
		mov al,[rdi]	
	
again:		rol al,4		;rotate by 4
		mov bl,al
		and al,0fh
		cmp al,09h
		jbe down
		add al,07			
	

down:		add al,30h
		mov byte[rsi],al
		mov bl,al
		inc rsi
		dec cl
		jnz again

		mov byte[rsi],0Ah
		inc rsi
		inc rdi
		dec dl
		jnz disp_loop1

		rw 1,1,result,15
		mov rax,60		;sys_exit function
		mov rdi,0
		syscall


;/////////////////////////////////INPUT/////////////////////////////////////////
	;numbers which are two digit 
	;it will not work for three digit 
	;because we have rotated only twice
	;88h,45h,01h,98h,34h
;////////////////////////////////OUTPUT/////////////////////////////////////////

;mtech@MTECHCSE:~$ nasm -f elf64 a.asm
;mtech@MTECHCSE:~$ ld a.o -o a
;mtech@MTECHCSE:~$ ./a
;ascending order sorted array 15
;0F
;34
;45
;88
;98
;mtech@MTECHCSE:~$ 
;/////////////////////////////////////////////////////////////////////////////
