;Lab6.asm

.model small
.data
array1 dw 5 dup(1111h), 1234h

.stack 100h

.code
main proc
	mov ax, @data
	mov ds, ax
	mov ax, offset array1
	push ax
	mov ax, LENGTHOF array1
	push ax
	call add_Process
	mov ax, 4c00h
	int 21h
main endp

add_Process proc
	LOCAL address:word, long:word 
	mov cx, [bp+4]
	mov ax, 0
	mov si, 0
	mov bx, [bp+6]
	Loop1:
		add ax, DS:[bx][si]
		add si, 2 
		loop Loop1
	ret 4
add_Process endp
end main
