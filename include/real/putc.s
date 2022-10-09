putc:
	push bp
	mov bp, sp

	push ax
	push bx

	mov al, [bp + 4]	; load argument
	mov ah, 0x0e
	mov bx, 0x0000		; page number / color
	int 0x10		; BIOS call (video service)

	pop bx
	pop ax

	mov sp, bp
	pop bp

	ret
