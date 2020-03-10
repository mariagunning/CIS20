; Module:		2b.asm	
; Project:		Lab 2b
; Author:		Maria Gunning	
; Date:			January 23, 2020
; Purpose:		Code output to prompt the user for input.
;				Learn how to collect user input and store it in a variable.
;				Perform a simple mathematical operation on an integer.
;				Understand how numeric values are stored.
;
;
; <DATA SEGMENT>
dseg	segment public 'DATA'
;
; <CONSTANTS>
;
	CR 	equ 0Dh		; carriage return 
	LF	equ 0Ah		; line feed 
;
; <VARIABLES>
;
	str_in	db 7Fh dup('$')	; string for input
	str_prompt db "Please input a number (integer) --> $"
	str_output db "Your input plus 1 is --> $"
	
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
	lea 	dx, str_prompt		; load prompt
	mov 	ah, 09h			; display string command	
	int 	21h			; send to DOS

	; capture user input character
	mov 	ah, 08h			; command to capture input
	int	21h			; send to DOS
	
	; preserve input
	mov 	str_in, al		; al (input) into string

	; echo input character
	mov 	dl, str_in		; mov 1st char of input string to output
	mov 	ah, 02h			; display a char command
	int	21h			; send to DOS

	; new line
	mov 	dl, CR			; carriage return
	mov	ah, 02h			; display a char command
	int	21h			; send to DOS

	mov 	dl, LF			; line feed
	mov	ah, 02h			; display a char command
	int	21h			; send to DOS
	
	; display output prompt
	lea 	dx, str_output		; load output prompt 
	mov 	ah, 09h			; display string command
	int 	21h			; send to DOS

	; add 1 to user input character
	inc	str_in			; increment 1st char of str_in

	; display result
	mov 	dl, str_in		; move 1st char of input string to output
	mov 	ah, 02h			; command to display a char
	int 	21h			; send to DOS
	
	nop				; no op
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