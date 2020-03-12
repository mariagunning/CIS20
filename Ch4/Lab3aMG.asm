; Module:			Lab3aMG.asm
; Project:			Lab3aMG
; Author:			Maria Gunning
; Date:				January 28, 2020
; Purpose:			Create code that uses conditional and unconditional jump commands.
;					Compare the results of an operation to control program flow.
;
;
; <DATA SEGMENT>
dseg	segment public 'DATA'
;
; <CONSTANTS>
;
	CR equ 0Dh				; carriage return
	LF equ 0Ah				; line feed
;
; <VARIABLES>
;
	int_1 db 03h			; integer 1
	int_2 db 04h			; integer 2
	
	str_1 db 'Integer 1 plus integer 2 is greater than 5$' ; 
	str_2 db 'Integer 1 plus integer 2 is NOT greater than 5$';
;
dseg	ends
;
; <STACK SEGMENT>
sseg	segment stack 'STACK'
	db	32h dup('STACK')
sseg	ends
;
; <CODE SEGMENT>
cseg	segment public 'CODE'
		assume cs:cseg,ds:dseg,ss:sseg
;
; <START procedure>
START	proc	far				; set up return
		push	ds				; store random value in stack
		xor		ax, ax			; set ax to 0
		push	ax				; store 0 in stack
		mov		ax, dseg		; initialize ds address
		mov		ds, ax			; copy segment address
;
;
;;;;;;;;;;;;;;;;;;
; main
;;;;;;;;;;;;;;;;;;
;
;
	; add values
	mov bl, int_1				; mov integer value into bl register;	mov bh, int_2
	mov bh, int_2				; mov integer value into bh register
	add bl, bh					; bl = bh + bl
	cmp bl, 05h					; compare vlaues
	
	jng MESSAGE2				; if not greater than
	
MESSAGE1:

	lea dx, str_1				; load address of label
	mov ah, 09h					; write string commands
	int 21h						; send to DOS
	
	jmp BLOCK_END				; end block
	
MESSAGE2:	
	lea dx, str_2				; load address of label
	mov ah, 09h					; write string commands
	int 21h						; send to DOS
	
	jmp BLOCK_END				; end block

BLOCK_END:
	nop							; no op
;
;
;
;;;;;;;;;;;;;;;;;;
; end main
;;;;;;;;;;;;;;;;;;
;
		ret						; return to DOS
;
START	endp					; end START procedure
;
cseg	ends					; end code segment
;
end	START						; end of file