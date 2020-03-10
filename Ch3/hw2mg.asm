; Module:		hw2mg.asm
; Project:		Homework 2
; Author:		Maria Gunning
; Date:			January 23, 2020
; Purpose:		Expand knowledge of the x86 instruction set.
;			Learn code sequencing.
;			Capture input from the console.
;
;
; <DATA SEGMENT>
dseg	segment public 'DATA'
;
; <CONSTANTS>
;
	CR 	equ 0Dh			; carriage return 
	LF	equ 0Ah			; line feed
;
; <VARIABLES>
;
	str_prompt 	db 'Input text --> $'	; prompt for input
	str_input	db 7Fh dup ("$")		; string to hold user input
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
	; display prompt
	lea 	dx, str_prompt			; load address of propmt string
	mov	ah, 09h				; command to display string
	int 	21h				; send to DOS
	
	; capture user input
	lea 	dx, str_input			; buffer for user input
	mov 	ah, 0Ah				; command for buffered input
	int 	21h				; send to DOS

	; new line	
	mov 	dl, CR				; carriage return 
	mov	ah, 02h				; display a char
	int 	21h				; send to DOS
	mov 	dl, LF				; line feed 
	mov	ah, 02h				; display a char
	int 	21h				; send to DOS
			
	; echo the user input
	lea 	dx, str_input + 2	        ; load address of the user input string
	mov	ah, 09h				; command to display string
	int 	21h				; send to DOS

	nop					; no op
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