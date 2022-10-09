read_chs:
	push bp
	mov bp, sp
	push 3			; retry count
	push 0			; sectors to read

	push bx
	push cx
	push dx
	push es
	push si

	mov si, [bp + 4]

	mov ch, [si + drive.cyln + 0]
	mov cl, [si + drive.cyln + 1]
	shl cl, 6
	or  cl, [si + drive.sect]

	mov dh, [si + drive.head]
	mov dl, [si + 0]
	mov ax, 0x0000
	mov es, ax
	mov bx, [bp + 8]
