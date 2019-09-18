;File name: Lab1.asm

.MODEL SMALL
.DATA
msg db '==================', 10, 13, '$'
msg1 db 'My ID is B10707049', 10, 13, '$'
msg2 db '==================', 10, 13, '$'

.STACK 100H

.code
MAIN PROC
	mov ax,@DATA
	mov ds,ax
	mov dx,offset msg
	mov ah,9
	int 21h
	mov dx,offset msg1
	mov ah,9
	int 21h
	mov dx,offset msg2
	mov ah,9
	int 21h
	mov ax,4c00h
	int 21h
	
MAIN ENDP
END MAIN