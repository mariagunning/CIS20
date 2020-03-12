; Module:		2a.asm	
; Project:		Lab 2a
; Author:		Maria Gunning
; Date:			January 21, 2020
; Purpose:		Explore the data segment and its features
;				Code variables.
;				Set and display variable values.

; <DATA SEGMENT>
dseg	segment public 'DATA'
;
; <CONSTANTS>
;
	CR 	equ 0Dh ; carriage return
	LF	equ 0Ah	; line feed 
;
; <VARIABLES>
;
	int_1	db 0	; first integer
	int_2	db 0 	; second integer
	str_a 	db 7Fh	; string
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
START	proc	far					; set up return
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
	; load A	
	mov 	int_1, 41h				; move 'A' to the first integer
	mov 	int_2, 20h				; move 20h into the second integer
	
	; lower case A
	mov	bl, int_2				; move 20h into bl
	mov 	bh, int_1				; move 'A' into bh
	add	bl, bh					; bl = bh + bh

	; display result (a)
	mov 	dl, bl 					; move bl to dl for display
	mov 	ah, 02h					; write char command
	int 	21h					; send to dos

	; new line
	mov 	dl, LF					; line feed
	mov 	ah, 02h					; write char command	
	int 	21h					; send to dos

	mov 	dl, CR					; carriage return
	mov 	ah, 02h					; write char command	
	int 	21h					; send to dos

	; load text into a string variable 
	mov 	str_a,	'M'				; move M into the 1st char of string str_a
	mov 	str_a + 1, 'a'				; move a to 2nd char
	mov 	str_a + 2, 'r'				; move a to 3nd char
	mov 	str_a + 3, 'k'				; move a to 4nd char
	mov 	str_a + 4, '$'				; terminate the srting

	; output the string, 1 char at a time
	mov 	dl, str_a				; 1st char
	mov 	ah, 02h					; write char command	
	int 	21h					; send to dos

	mov 	dl, str_a + 1				; 2nd char
	mov 	ah, 02h					; write char command	
	int 	21h					; send to dos

	mov 	dl, str_a + 2				; 3rd char
	mov 	ah, 02h					; write char command	
	int 	21h					; send to dos


	mov 	dl, str_a + 3				; 4th char
	mov 	ah, 02h					; write char command	
	int 	21h					; send to dos

	
	mov 	dl, str_a + 4				; 5th char
	mov 	ah, 02h					; write char command	
	int 	21h					; send to dos

	; display the string as a string
;	lea	dx, str_a				; load effective address of string into dx register
;	mov 	ah, 09h					; write string command
;	int 	21h					; send to DOS




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