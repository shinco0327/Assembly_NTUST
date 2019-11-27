;Lab10.asm
.model small
.data
color db 00000110b
x_Init dw 300
y_Init dw 220

.stack 100h

.code
setBG macro	;set Background color
	mov ah, 0Bh
	mov bh, 00h
	mov bl, 0ah
	int 10h
endm

draw macro para1, para2, para3		;draw a triangle from its starting point
	Local L1, L2
	mov bx, 0
	mov dx, para2
	dec dx
	L1:
	inc dx
	mov cx, para1
	push bx
	L2:
	push bx
	mov al, para3
	mov ah, 0ch
	mov bh, 0
	int 10h
	inc cx
	pop bx
	dec bx
	cmp bx, 1
	jge L2
	pop bx
	inc bx
	cmp bx, 40
	jle L1
	
	
endm

main proc
	mov ax, @data
	mov ds, ax
	mov ax, 0012h
	int 10h

	setBG	;set Background color
	START:
	draw x_Init, y_Init, color	;draw triangle
	mov ah, 10h
	int 16h
	push ax				;save keyboard input
	draw x_Init, y_Init, 0000h	;erase triangle
	pop ax				;pop out keyboard input
	cmp al, 1bh			;equals to esc exit program
	je exit
	
	cmp al, 38h			;num 8 up
	je up
	cmp al, 32h			;num 2 down
	je down
	cmp al, 34h			;num 4 left 
	je left
	cmp al, 36h			;num 6 right 
	je right
	cmp al, 35h			;num 5 change color
	je change_color
	jmp START
	up:
	sub y_Init, 4			
	jmp START
	down:
	add y_Init, 4
	jmp START
	left:
	sub x_Init, 4
	jmp START
	right:
	add x_Init, 4
	jmp START
	change_color:			;change color
	mov al, color
	cmp al, 0Fh		
	jl inc_color
	mov al, 00h
	jmp save_color
	inc_color:
	inc al
	save_color:
	mov color, al
	jmp START
	exit:
	mov ax, 0003h
	int 10h
	mov ax, 4c00h			;exit to DOS
	int 21h
main endp

end main