;---------------------------------------------------------------------------------------
; TO WRITE 80X86 ALP TO PERFROM STRING OPERATIONS LIKE ACCEPTING A STRING,LENGHT,PALINDROME IN NASM
;---------------------------------------------------------------------------------------


section .data
msgmenu db "------STRING OPERATIONS MENU:--------" ,10
     db "1.ACCEPTING THE STRING",10
     db "2.LENGHT OF STRING",10
     db "3.PALINDROME",10
     db "4.EXIT",10
     db "Enter your choice",10
msgmenulen equ $-msgmenu

msg1 db "Enter the string",10
msg1len equ $-msg1

msg2 db "String is:",10
msg2len equ $-msg2

msg3 db "length of string is:",10
msg3len equ $-msg3

msg4 db "String is Palindrome",10
msg4len equ $-msg4

msg5 db "String is not Palindrome",10
msg5len equ $-msg5

msg6 db "Thanks for using this system for string operations",10
msg6len equ $-msg6

newline db 10

section .bss
str1 resb 20
strlen1 resb 2
cnt resb 3
choice resb 3

%macro rw 4
mov rax,%1
mov rdi,%2
mov rsi,%3
mov rdx,%4
syscall
%endmacro

section .text
        global _start
_start:
     rw 1,1,msgmenu,msgmenulen
     rw 0,0,choice,2
     cmp byte[choice],'1'
     je accept
     cmp byte[choice],'2'
     je length
     cmp byte[choice],'3'
     je palindrome
     cmp byte[choice],'4'
     je exit

accept:  rw 1,1,msg1,msg1len
    rw 0,0,str1,10
    dec rax
    mov byte[strlen1],al
    mov byte[cnt],al
    rw 1,1,msg2,msg2len
    rw 1,1,str1,[cnt]
    rw 1,1,newline,1
    jmp _start

length:  rw 1,1,msg3,msg3len
         add byte[strlen1],30h
         rw 1,1,strlen1,1
         rw 1,1,newline,1
         jmp _start

palindrome: mov rsi,str1
            mov rdi,str1
       mov cx,[cnt]

    l3:inc rdi
        dec cx
       jnz l3
       dec rdi

    l2: mov al,[rsi]
            cmp al,[rdi]
             je l1
             rw 1,1,msg5,msg5len
        jmp _start

    l1: inc rsi
             dec rdi
             dec byte[cnt]
             jnz l2
             rw 1,1,msg4,msg4len
             jmp _start
   
exit: rw 1,1,msg6,msg6len
      rw 60,0,0,0
