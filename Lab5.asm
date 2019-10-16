;Lab5.asm

.model small

.data 
value byte 12h, 11h, 99h, 28h, 70h, 16h

.stack 100h

.code 
main proc
	mov ax, @DATA
	mov ds, ax
	mov cx, LENGTHOF value -1
LOOP1:
	mov SI, 0h
NUM_CMP:
	mov bx, 0000h
	mov dx, 0000h
	mov bl, value[SI]
	mov dl, value[SI][1]
	cmp bx, dx
	ja Swap_p
	jbe Cont
Swap_P:
	PUSH bx
	PUSH dx
	POP bx
	POP dx
Cont:
	mov value[SI], bl
	mov value[SI][1], dl
	add si, 1
	cmp si, cx
	jge Next
	jl NUM_CMP
Next:
	loop LOOP1
	mov ax, 4c00h
	int 21h
main endp
end main