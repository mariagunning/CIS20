; Module:	1b.asm
; Project:	Lab 1b	
; Author:	Maria Gunning
; Date:		January 16, 2020
; Purpose:	Test install of MASM
;
;
; <DATA SEGMENT>
dseg	segment public 'DATA'
;
; <CONSTANTS>
;
	CR	equ 0dh		; carriage return 
	LF 	equ 0ah		; line feed
;
; <VARIABLES>
;
	str_a	db "puppy"	; a dog of a string
	str_b 	db "monkey"	; more of the same
	str_c	db "baby$"	; the $ ends the string 

	str_dir db 7fh dup("$")	; string to hold directory name
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
	lea	dx, str_a		; load string into dx register
	mov	ah, 09h			; load write string command
	int	21h			; DOS interupt 21h
	
	; new line
	mov 	dl, CR			; load carraige return 
	mov	ah, 02h			; write character 
	int	21h			; DOS interupt 21h

	mov 	dl, LF			; load line feed
	mov	ah, 02h			; write character 
	int	21h			; DOS interupt 21h

	lea 	dx, str_c		; load string dx register 
	mov	ah, 09h			; load write string command 
	int	21h			; DOS interupt 21h

	; new line
	mov 	dl, CR			; load carraige return 
	mov	ah, 02h			; write character 
	int	21h			; DOS interupt 21h

	mov 	dl, LF			; load line feed
	mov	ah, 02h			; write character 
	int	21h			; DOS interupt 21h

	; get system date
	mov	ah, 2ah			; system date command
	int	21h			; DOS interupt 21h

	mov	ah, 02h			; write character 
	int	21h			; DOS interupt 21h

	; new line
	mov 	dl, CR			; load carraige return 
	mov	ah, 02h			; write character 
	int	21h			; DOS interupt 21h

	mov 	dl, LF			; load line feed
	mov	ah, 02h			; write character 
	int	21h			; DOS interupt 21h

	; display the working directory
;	mov 	dl, 00h			; default drive number
;	lea 	ds, str_dir		; location for directory name
;	mov 	ah, 47h			; get surrent working directory
;	int 	21h			; DOS interupt 21h
;
;	mov 	dx, ds			; string from get dir
;	mov 	ah, 09h			; load write string command
;	int 	21h			; DOS interupt 21h 
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