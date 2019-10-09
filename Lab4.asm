;filename: Lab4.asm

.model small

.data
str1 db "A*B", 10, 13, "$"
A dw 340dh
B dw 5h
D dw 0ff00h
counter db 0h
result db 4 dup(?),'$'
nextLine db 10, 13, "$"

.stack 100h

.code
main proc
	mov ax, @data
	mov ds, ax
	mov dx, offset str1
	mov ah, 09h
	int 21h
	mov sp, A
	mov ax, B
	mul sp
	mov bx, dx

Transfer:
	mov cl, 4
	mov dl, bh
	shr dl, cl
	add dl, 30h
	mov result[0], dl

	mov dl, bh
	shl dl, cl
	shr dl, cl
	add dl, 30h
	mov result[1], dl

	mov dl, bl
	shr dl, cl
	add dl, 30h
	mov result[2], dl

	mov dl, bl
	shl dl, cl
	shr dl, cl
	add dl, 30h
	mov result[3], dl 
	
	mov cx, ax
	mov dx, offset result
	mov ah, 09h
	int 21h ;print 
	add counter, 01h
	cmp counter, 01h
	je Second
	cmp counter, 02h
	je DProcess
	cmp counter, 03h
	je Exit_Proc

Second:
	mov bx, cx
	jmp Transfer

DProcess:
	mov sp, A
	mov ax, B
	imul sp
	mov bx, D
	idiv bx
	mov sp, dx
	mov dx, offset NextLine
	mov ah, 09h
	int 21h
	mov bx, sp
	jmp Transfer

Exit_Proc:
	mov ax, 4c00h
	int 21h


main endp
end main
