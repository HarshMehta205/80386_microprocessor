;-----------------------------------------------------------------------------------------
;TO WRITE A 80x86 ALP TO PERFORM PACLING OF TWO UNPACK HEX NUMBERS USING NASM
;-----------------------------------------------------------------------------------------


section .data
msg db "Enter two digit no", 10
msglen equ $-msg

msg1 db "Number are thus converted to packed format properly", 10
msglen1 equ $-msg1

section .bss
num resb 4

 ;definig a macro for those line of codes which are gonna repeat more then once
%macro on 4                         
   mov rax,%1
   mov rdi,%2
   mov rsi,%3
   mov rdx,%4
   syscall
%endmacro

section .text
    global _start

  _start:
        
        on 1,1,msg,msglen              ;display message
        on 0,0,num,3                   ;accept two digit number(they will be unpacked format)
        
        ;converting the numbers  into packed format
                        
        	mov rsi,num 
        	mov rcx,2
        	mov rax,0
  up:   	rol al,4                      ;command to rotate al 4 times
       	mov bl,[rsi]
        	cmp bl,39h
        	jbe down
        	sub bl,07h
  down: 	sub bl,30h       
        	add al,bl
        	inc rsi                       ;increment rsi
        	dec rcx                       ;decrement rcx
        	jnz up

                                    ;thus we have converted the number into packed format after series of operation

        on 1,1,msg1,msglen1       
        
        mov rax,60                  ;commands to end the code
        mov rdi,0
        syscall

