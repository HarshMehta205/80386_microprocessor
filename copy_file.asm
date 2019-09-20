;WRITE 80X86 ALP TO CALCULATE MEAN OF 5 NUMBERS

%macro rw 4
mov rax, %1
mov rdi, %2
mov rsi, %3
mov rdx, %4
syscall
%endmacro

section .data
msg1 db "ERROR",10
msglen1 equ $- msg1
msg2 db "FILE IS COPIED SUCCESSFULLY!!",10
msglen2 equ $- msg2

section .bss
fname1 resb 15
fd1 resq 1
fname2 resb 15
fd2 resq 1
buff resb 512
bufflen resq 1

section .txt
global _start
_start:

pop r8
cmp r8,3
jne err
pop r8
pop r8
mov esi,fname1

above:  mov al,[r8]
        cmp al,00
        je next
        mov [esi],al
        inc r8
        inc esi
        jmp above
             
next:  pop r8
       mov esi,fname2

above2:   mov al,[r8]
          cmp al,00
          je next2
          mov [esi],al
          inc r8
          inc esi
          jmp above2

next2:   rw 2,fname1,0q,0777q
         mov [fd1],rax
         ;mov rbx,rax
         rw 0,[fd1],buff,512
         mov [bufflen],rax
         rw 85,fname2,0777q,0
         rw 2,fname2,2,0777q
         mov [fd2],rax
         ;mov rbx,rax
         rw 1,[fd2],buff,[bufflen]
         rw 3,[fd2],0,0
         rw 3,[fd1],0,0
         rw 1,1,msg2,msglen2
         jmp end

err:  rw 1,1,msg1,msglen1

end: rw 60,0,0,0

;btech@BTECHCSE:~$ nasm -f elf64 cp1.asm
;btech@BTECHCSE:~$ ld -o cp1 cp1.o
;btech@BTECHCSE:~$ ./cp1 src.txt d.txt
;FILE IS COPIED SUCCESSFULLY!!
;btech@BTECHCSE:~$


