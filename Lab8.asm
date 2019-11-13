;Lab8.asm
.model small
.stack 100h

.code
main proc
	mov ax, @data
	mov ds, ax
L1:
	mov dl,2Eh		;print .	
	mov ah,02h   
	int 21h
	mov   cx,32 
L2:	
	push  cx            
	mov   cx,0ffffh 
L3:	
	call  CheckKeyboard
	loop   L3
	pop    cx
	loop   L2
	jmp    L1
	
	mov  ah,4ch
	int  21h
main endp

CheckKeyboard proc
	push ax
	mov ah, 11h
	int 16h
	LAHF			;Load Low byte of flags to ah
	and ah, 40h
	cmp ah, 40h
	je Not_receive
	mov ah, 10h
	int 16h
	cmp al, 1bh
	je exit
	cmp al, 0E0h
	jne not_special
	cmp ah, 48h
	je up
	cmp ah, 50h
	je down
	cmp ah, 4Bh
	je left
	cmp ah, 4Dh
	je right
up:
	mov dl, 'u'
	jmp print
down:
	mov dl, 'd'
	jmp print
left:
	mov dl, 'l'
	jmp print
right:
	mov dl, 'r'
	jmp print
not_special:
	mov dl, al
print:
	mov ah, 02h
	int 21h
Not_Receive:
	pop ax
	ret
exit:
	mov ah, 4ch
	int 21h
CheckKeyboard endp

end main	