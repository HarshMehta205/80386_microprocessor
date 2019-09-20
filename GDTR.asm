;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;WRITE A 80x86 ALP TO DISPLAY THE CONTENTS OF GDTR,IDTR,LDTR,TR AND MSW. 
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

;NOTE :
; gdtr is 48bytes register divide into 32 bytes base address and 16bytes offset value
;each descriptor in gdt is of 8bytes i.e. 64 bits and it is described using segment descriptor which of 64 bites
;segment descriptor is divide into 32 bites base address ,20bites limit ,8bites access  right byte(arb) and 4 bites miscallenous bites

;NOTE :
; LDT ,IDT ,TS ,MSW all are present in GDT 
																							;IN THIS PROGRAM -
																							;GDTR -64BIT(BASE ADDRESS)+16BIT(OFFSET)
																							;IDTR  -64BIT(BASE ADDRESS)+16BIT(OFFSET)
																							;LDTR -16BIT(OFFSET)
																							;TR      -16BIT(OFFSET)
																							;MSW  -16BIT(OFFSET)
																							;but generally gdtr and idhtr is of 32bit(base address)+16bit(offset)
																							
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
																							
section .data

msgmenu db "------MENU:--------" ,10
db "1.GDTR" ,10
db "2.IDTR",10
db "3.LDTR" ,10
db "4.TS",10
db "5.MSW",10
db "6.EXIT",10
db "Enter your choice", 10

msgmenulen equ $-msgmenu
msg1 db "Base Address :  ",10
msgl1 equ $-msg1
msg2 db "Offset Address :  ",10
msgl2 equ $-msg2
msg3 db "Global Descriptor Table Register :  ",10
msgl3 equ $-msg3 
msg4 db "Interrupt Descriptor Table Register :  ",10
msgl4 equ $-msg4
msg5 db "Local Descriptor Table Register :  ",10
msgl5 equ $-msg5
msg6 db "Task Register :  ",10
msgl6 equ $-msg6
msg7 db "Machine Status Word :  ",10
msgl7 equ $-msg7
newl db 10


%macro operate 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro 

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

section .bss
gdtr resq 1																			 	;since we want 64bytes descriptor we reserve 64 bytes using resq
gdtlimit resw 1																		;to store the offset value
idtr resq 1
idtlimit resw 1
ldtr resw 1
tr resw 1
msw resw 1
res64 resb 16																			 ;used as a temprory variable in display for displaying segement descriptor
res16 resb 4																			 ;used as a temprory variable in display for displaying of offset value
temp resb 1
choice resb 3

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

section .text
global _start
_start:

operate 1,1,msgmenu,msgmenulen

operate 0,0,choice,2
cmp byte[choice],'1'
je GDTR
cmp byte[choice],'2'
je IDTR
cmp byte[choice],'3'
je LDTR
cmp byte[choice],'4'
je TR
cmp byte[choice],'5'
je MSW
cmp byte[choice],'6'
je exit

GDTR:
operate 1,1,msg3,msgl3
		;code for base address of gdtr
operate 1,1,msg1,msgl1
mov esi,gdtr						
sgdt [esi]																					;store gdt's value in esi
mov rax,[esi]					
call display64																			;calling function display64
		;code for offset value of gdtr
operate 1,1,newl,1																	;newline
operate 1,1,msg2,msgl2                 
mov esi,gdtlimit                           
mov ax,[esi]
call display16                                 											;calling function display16
operate 1,1,newl,1																	;newline
operate 1,1,newl,1																	;newline
jmp _start

IDTR:
operate 1,1,msg4,msgl4
		;code for base address of idtr
operate 1,1,msg1,msgl1
mov esi,idtr						
sgdt [esi]																					;store gdt's value in esi
mov rax,[esi]					
call display64																			;calling function display64
operate 1,1,newl,1																	;newline
		;code for offset value of gdtr
operate 1,1,msg2,msgl2                 
mov esi,idtlimit                           
mov ax,[esi]
call display16                                  										;calling function display16
operate 1,1,newl,1																	;newline
operate 1,1,newl,1																	;newline
jmp _start

LDTR:
operate 1,1,msg5,msgl5
mov esi,ldtr																				;store ldt's value in esi
sldt [esi]
mov ax,[esi]
call display16
operate 1,1,newl,1																	;newline
operate 1,1,newl,1																	;newline
jmp _start

TR:
operate 1,1,msg6,msgl6
mov esi,tr					
str [esi]																					;store tr's value in esi
mov ax,[esi]
call display16
operate 1,1,newl,1																	;newline
operate 1,1,newl,1																	;newline
jmp _start

MSW:
operate 1,1,msg7,msgl7
mov esi,msw
smsw [esi]																				;store tr's value in esi
mov ax,[esi]
call display16
operate 1,1,newl,1																	;newline
operate 1,1,newl,1																	;newline
jmp _start

exit:
operate 60,0,0,0

display64:
	mov bp,12
	rol rax,16
	again:
	  rol rax,4
	  mov[res64],rax
	  and rax,0fh
	  cmp rax,09h
	  jbe down
	  add rax,07h
	down:
	  add rax,30h
	  mov byte[temp],al
	  operate 1,1,temp,1
	  mov rax,[res64]
	  dec bp
	  jnz again
ret
  
display16:
	mov bp,4
	againx:
	  rol ax,4
	  mov[res16],ax
	  and ax,0fh
	  cmp ax,09h
	  jbe downx
	  add ax,07h
	downx:
	  add ax,30h
	  mov byte[temp],al
	  operate 1,1,temp,1
	  mov ax,[res16]
	  dec bp
	  jnz againx
ret  

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


%ifdef COMMENT
mtech@MTECHCSE:~$ nasm -f elf64 ass4.asm
mtech@MTECHCSE:~$ ld -o ass4 ass4.o
mtech@MTECHCSE:~$ ./ass4
------MENU:--------
1.GDTR
2.IDTR
3.LDTR
4.TS
5.MSW
6.EXIT
Enter your choice
1
Global Descriptor Table Register :  
Base Address :  
0002D000007F
Offset Address :  
FFFF

------MENU:--------
1.GDTR
2.IDTR
3.LDTR
4.TS
5.MSW
6.EXIT
Enter your choice
2
Interrupt Descriptor Table Register :  
Base Address :  
00001000007F
Offset Address :  
FFFF

------MENU:--------
1.GDTR
2.IDTR
3.LDTR
4.TS
5.MSW
6.EXIT
Enter your choice
3
Local Descriptor Table Register :  
0000

------MENU:--------
1.GDTR
2.IDTR
3.LDTR
4.TS
5.MSW
6.EXIT
Enter your choice
4
Task Register :  
0040

------MENU:--------
1.GDTR
2.IDTR
3.LDTR
4.TS
5.MSW
6.EXIT
Enter your choice
5
Machine Status Word :  
0033

------MENU:--------
1.GDTR
2.IDTR
3.LDTR
4.TS
5.MSW
6.EXIT
Enter your choice
6
mtech@MTECHCSE:~$ 
%endif

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



