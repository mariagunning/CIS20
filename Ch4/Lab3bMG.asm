; Module:			Lab3bMG.asm	
; Project:			Lab 3b
; Author:			Maria Guning
; Date:				January 30, 2020
; Purpose:			Create code that uses performs looping flow control.
;					Use the cx register for loop control.
;
;
; <DATA SEGMENT>
dseg	segment public 'DATA'
;
; <CONSTANTS>
;
	CR		equ 0Dh							; carriage return
	LF		equ 0Ah							; line feed

;
; <VARIABLES>
;
	str_out db 'The quick brown fox jumped over the lazy dog*'	;
	
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
	xor		bx, bx				; set bx to 0
	
DO_TOP:
	

	;display the current alphabet character 
	mov 	dl, [str_out + bx]			; add register to string
	mov		ah, 02h						; display char comand
	int		21h							; send to DOS

	
	;increment the alpha character 
	inc 	bx 							; if it was 'a', not it's a 'b'
	
	cmp 	[str_out + bx] , '*'		; loop for last character
	jne     DO_TOP						; jump if not equal to *

DO_BOTTOM:
		nop						; no op
		

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