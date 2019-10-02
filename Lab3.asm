;filename: Lab3.asm

.model small

.data
value dw 0ffffh, 0003h, 7fffh, 8123h
result db 4 dup(?),'$'

.stack 100h

.code
main proc
	mov bx, @data
	mov ds, bx
	mov bx, 0 ;立即值定值法
	mov si, 0h
	add bx, value[0] ;索引地址法
	ADD_Process:	
		add bx, value[si]
		add si, 02h
		cmp si, 08h 
		je PRINT_PROCESS ;jle jge
	jmp ADD_Process
	PRINT_PROCESS:
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
	mov dx, offset result
	mov ah, 09h
	int 21h
	mov ax,4c00h
	int 21h
main endp
end main
