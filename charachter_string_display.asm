;--------------------------------------------------------------------------------------
;TO WRITE A 80x86 ALP FOR CHARACTER STRING DISPLAY ABOUT YOURSELF USING NASM
;--------------------------------------------------------------------------------------

section .data

msg db "enter your name :" , 10
msglen equ $-msg
msg1 db "enter your roll no :" , 10
msglen1 equ $-msg1
msg2 db "enter your class :" , 10
msglen2 equ $-msg2
msg3 db "enter your age :" , 10
msglen3 equ $-msg3
msg4 db "name :"
msglen4 equ $-msg4
msg5 db "roll no :"
msglen5 equ $-msg5
msg6 db "class :"
msglen6 equ $-msg6
msg7 db "age :"
msglen7 equ $-msg7
newline db 10


section .bss

name resb 20
rollno resb 20
class resb 10
age resb 10


section .text
global _start
_start:

mov rax,1
mov rdi,1
mov rsi, msg
mov rdx, msglen
syscall

mov rax,0
mov rdi,0
mov rsi, name
mov rdx, 15
syscall

mov rax,1
mov rdi,1
mov rsi, newline
mov rdx, 1
syscall


mov rax,1
mov rdi,1
mov rsi, msg1
mov rdx, msglen1
syscall

mov rax,0
mov rdi,0
mov rsi, rollno
mov rdx, 15
syscall

mov rax,1
mov rdi,1
mov rsi, newline
mov rdx, 1
syscall

mov rax,1
mov rdi,1
mov rsi, msg2
mov rdx, msglen2
syscall

mov rax,0
mov rdi,0
mov rsi, class
mov rdx, 15
syscall

mov rax,1
mov rdi,1
mov rsi, newline
mov rdx, 1
syscall

mov rax,1
mov rdi,1
mov rsi, msg3
mov rdx, msglen3
syscall

mov rax,0
mov rdi,0
mov rsi, age
mov rdx, 7
syscall

mov rax,1
mov rdi,1
mov rsi, newline
mov rdx, 1
syscall


mov rax,1
mov rdi,1
mov rsi, msg4
mov rdx, msglen4
syscall

mov rax,1
mov rdi,1
mov rsi, name
mov rdx, 15
syscall

mov rax,1
mov rdi,1
mov rsi, msg5
mov rdx, msglen5
syscall

mov rax,1
mov rdi,1
mov rsi, rollno
mov rdx, 15
syscall

mov rax,1
mov rdi,1
mov rsi, msg6
mov rdx, msglen6
syscall

mov rax,1
mov rdi,1
mov rsi, class
mov rdx, 7
syscall

mov rax,1
mov rdi,1
mov rsi, msg7
mov rdx, msglen7
syscall

mov rax,1
mov rdi,1
mov rsi, age
mov rdx, 7
syscall

mov rax, 60
mov rdi, 0
syscall
