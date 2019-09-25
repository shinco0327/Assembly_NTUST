;filename: Lab2.asm

.model small

.data
value1 dw 0ffffh
value2 dw 0003h
value3 dw 7fffh
value4 dw 8123h

.stack

.code
main proc
	mov bx, @data
	mov ds, bx
	mov bx, 0
	add bx, value1
	add bx, value1
	add bx, value2
	add bx, value3
	add bx, value4
	mov cl, 4
	mov dl, bh
	shr dl, cl
	add dl, 30h
	mov ah, 2 
	int 21h

	mov dl, bh
	shl dl, cl
	shr dl, cl
	add dl, 30h
	mov ah, 2 
	int 21h
	

	mov dl, bl
	shr dl, cl
	add dl, 30h
	mov ah, 2 
	int 21h

	mov dl, bl
	shl dl, cl
	shr dl, cl
	add dl, 30h
	mov ah, 2 
	int 21h
	mov ax,4c00h
	int 21h
main endp
end main
