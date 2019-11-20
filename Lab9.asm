;Lab9.asm
include .\INCLUDE\Irvine16.inc

.model small

.data
pageVar db 00h
wordVar db 07h

.stack 100h

.code
main proc
	mov ax, @data
	mov ds, ax
	L1:
	mov ah, 10h
	int 16h
	cmp al, 1bh
	je exitProcess
	cmp al, 00h
	jne not_special

	;F1-F4 Press
	cmp ah, 3Bh
	je F1_press
	cmp ah, 3ch
	je F2_press
	cmp ah, 3dh
	je F3_press
	cmp ah, 3eh
	je F4_press
	F1_press:	;Change cursor
	call Change_cursor
	jmp L1
	F2_press:	;Change bg color
	call change_bg
	jmp L1
	F3_press:
	call change_color
	jmp L1
	F4_press:	;Random Num
	mov ax, 25
	call RandomRange
	add ax, 41h
	not_special:	;Display word
	push ax
	mov bl, wordVar
	pop ax 
	mov bh, pageVar	;move page
	mov cx, 2
	mov ah, 09h	;Write word
	int 10h
	mov ah, 03h	;get cursor dh, dl
	int 10h
	add dl, 2
	inc dh
	mov ah, 02h	;Set cursor
	int 10h
	jmp L1
	mov ax, 10h
	exitProcess:
	mov ah, 4ch
	int 21h
main endp

Change_cursor proc
	mov ah, 03h
	mov bh, pageVar
	int 10h
	cmp ch, 20h
	je set_minCursor
	cmp ch, 00h
	jne dec_cursor
	mov ch, 20h
	jmp write_cursor
	set_minCursor:
	mov ch, 06h
	jmp write_cursor
	dec_cursor:
	dec ch
	write_cursor:
	mov ah, 01h
	int 10h
	ret
Change_cursor endp
change_bg proc
	mov ah, wordVar
	cmp ah, 11110000b
	jae set_Zero
	add ah, 00010000b
	jmp set_BG
	set_Zero:
	mov cl, 4
	shl ah, cl
	shr ah, cl
	set_BG:
	mov wordVar, ah
	ret
change_bg endp
change_color proc
	mov ah, wordvar
	push ax
	mov cl, 4
	shl ah, cl
	shr ah, cl
	cmp ah, 00001111b
	je set_zero
	inc ah
	jmp set_color
	set_zero:
	mov ah, 00h
	set_color:
	pop bx
	shr bh, cl
	shl bh, cl
	add ah, bh
	mov wordvar, ah
	ret
change_color endp
end main