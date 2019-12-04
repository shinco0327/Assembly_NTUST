.model small
.data
color db 00000110b
half_length dW 40
x_Init dw 100
y_Init dw 100
str1 db "x=", ?, ?, ?, 10, 13, "$"
str2 db "y=", ?, ?, ?, "$"


.stack 100h
.code
setBG macro	;set Background color
	mov ah, 0Bh
	mov bh, 00h
	mov bl, 01h
	int 10h
endm

delay macro
	Local L1, L2
	mov cx, 0800
	L1:
		push cx
		mov cx, 0FFFFh
		L2:
			loop L2
		pop cx
		loop L1
endm

draw macro para1, para2, para3, para4		;draw a triangle from its starting point
	Local L1, L2, L3, L4
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
	cmp bx, para4
	jle L1
	
	mov bx, 0
	mov dx, para2	;y
	dec dx		;dec y
	L3:
	inc dx		;inc y
	mov cx, para1	;cx x
	push bx		;push counter
	L4:
	push bx		;push again
	mov al, para3
	mov ah, 0ch
	mov bh, 0
	int 10h
	dec cx		;dec cx
	pop bx		;pop counter
	dec bx		;dec counter
	cmp bx, 1
	jge L4
	pop bx
	inc bx
	cmp bx, para4
	jle L3
	
	
endm

get_mouse macro	
	Local smaller, greater, exit_main, type, store_x, store_y, c_y, cy_2, store_x
	mov ax, 0003h
	int 33h

	push bx 
	mov bx, 480
	sub bx, half_length
	cmp dx, bx	;reach min
	jle store_y
	mov y_Init, bx
	jmp c_y

	c_y:
	mov bx, 640
	sub bx, half_length
	cmp cx, bx	;reach min
	jle store_x
	mov x_Init, bx
	jmp type
	cy_2:
	mov bx, 0
	add bx, half_length
	cmp cx, bx	;reach min
	jge store_x2
	
	mov x_Init, bx
	jmp type


	store_y:
	mov y_Init, dx
	jmp c_y
	


	store_x:
	mov x_Init, cx
	jmp cy_2

	store_x2:
	mov x_Init, cx
	jmp type

	type:
	pop bx
	cmp bx, 1
	je smaller
	cmp bx, 2
	je greater
	jmp exit_main
	smaller:
	cmp half_length, 20
	jle exit_main
	sub half_length, 10
	jmp exit_main
	greater:
	cmp half_length, 80
	jge exit_main
	add half_length, 10
	jmp exit_main
	exit_main:
endm

print macro
	Local Hex2Dec, dec2Ascll, clear
	mov dh, 0
	mov dl, 0
	mov bx, 0
	mov ah, 02h
	int 10h

	mov cx,3
	
	mov di, offset str1
	clear:
		mov al, ' '
		mov [di+2], al
		inc di
		loop clear
	mov cx, 0
	mov di, offset str1
	mov ax, x_Init
		
Hex2Dec:
	inc cx
	mov bx,10
	mov dx,0
	div bx
	push dx
	cmp ax,0
	jne Hex2Dec	
dec2Ascll:
	pop ax
	add al,30h
	mov [di+2],al
	inc di
	loop dec2Ascll
	mov dx, offset str1
	mov ah, 09h
	int 21h
endm

print2 macro
	Local Hex2Dec, dec2Ascll, clear
	
	mov cx,3
	
	mov di, offset str2
	clear:
		mov al, ' '
		mov [di+2], al
		inc di
		loop clear
	mov cx, 0
	mov di, offset str2
	mov ax, y_Init
		
Hex2Dec:
	inc cx
	mov bx,10
	mov dx,0
	div bx
	push dx
	cmp ax,0
	jne Hex2Dec	
dec2Ascll:
	pop ax
	add al,30h
	mov [di+2],al
	inc di
	loop dec2Ascll
	mov dx, offset str2
	mov ah, 09h
	int 21h
endm

main proc 
	mov ax, @data
	mov ds, ax
	mov ax, 0012h
	int 10h
	setBG
	mov ax, 0000h
	int 33h 
	mov ax, 0004h
	mov cx, 100
	mov dx, 100
	int 33h
	START:
	get_mouse
	
	print
	print2
	draw x_Init, y_Init, color, half_length 
	delay
	draw x_Init, y_Init, 00h, half_length 
	mov ah, 11h
	int 16h
	je START
	get_key:
	mov ah, 10h
	int 16h
	cmp al, 1bh
	je exit
	cmp al, 63h
	je change_color
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
	exit:				;exit
	mov ax, 0003h
	int 10h
	mov ax, 4c00h			;exit to DOS
	int 21h
main endp
end main