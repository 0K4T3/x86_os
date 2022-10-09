	BOOT_LOAD equ 0x7c00
	ORG BOOT_LOAD
	
%include "./include/macro.s"

entry:
	jmp ipl


bpb:
	;; bios parameter block
	times 90 - ($ - $$) db 0x90

ipl:
	;; initial program loader
	cli			; clear interrupt flag
	
	;; initialize registers
	mov ax, 0x0000
	mov dx, ax
	mov es, ax
	mov ss, ax
	mov sp, BOOT_LOAD
	sti			; set interrupt flag
	mov [BOOT.DRIVE], dl
	
	cdecl puts, .s0
	
	mov ah, 0x02
	mov al, 1
	mov cx, 0x0002
	mov dh, 0x00
	mov dl, [BOOT.DRIVE]
	mov bx, 0x7c00 + 512
	int 0x13
	jmp stage_2
	
.s0 db "Booting...", 0x0a, 0x0d, 0
	
	ALIGN 2, db 0
BOOT:
	.DRIVE: dw 0
	
%include "./include/real/puts.s"	
	
	times 510 - ($ - $$) db 0x00
	db 0x55, 0xaa

stage_2:
	cdecl puts, .s0
	mov eax, cr0
	or  ax, 1
	mov cr0, eax

[BITS 32]	
	jmp $

.s0 db "Bootloader 2nd stage...", 0x0a, 0x0d, 0

	times (1024 * 8) - ($ - $$) db 0x00
