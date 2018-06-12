LJMP START

P5 EQU 0F8H
P7 EQU 0DBH

LCDstatus equ 0FF2EH
LCDcontrol equ 0FF2CH
LCDdataWR equ 0FF2DH
LCDdataRD equ 0FF2FH

 // LCD control bytes ----------------------------------
#define HOME 0x80 // put curcor to second line
#define INITDISP 0x38 // LCD init (8-bit mode)
#define HOM2 0xc0 // put curcor to second line
#define LCDON 0x0e // LCD nn, cursor off, blinking off
#define CLEAR 0x01 // LCD display clear

	ORG 000BH
	MOV TH0, #0H
	MOV TL0, #0H
	DEC R0
	RETI
ORG 0100H

LCDcntrlWR MACRO x
LOCAL loop
loop:
MOV DPTR,#LCDstatus
MOVX A,@DPTR
JB ACC.7,loop ; check if LCD busy

MOV DPTR,#LCDcontrol ; write to LCD control
MOV A, x
MOVX @DPTR,A
ENDM

LCDcharWR MACRO
LOCAL loop1,loop2, end1, end2

PUSH ACC
loop1: MOV DPTR,#LCDstatus
MOVX A,@DPTR
JB ACC.7,loop1 ; check if LCD busy

loop2: MOV DPTR,#LCDdataWR ; write data to LCD
POP ACC
MOVX @DPTR,A
ENDM

init_LCD MACRO
MOV R3, #10H
MOV R4, #20H
LCDcntrlWR #INITDISP
LCDcntrlWR #CLEAR
LCDcntrlWR #LCDON
ENDM

delay MACRO
LOCAL loop1, loop2
MOV R6, #0FAH
loop1: MOV R5, #03BH
loop2: DJNZ R5, loop2
	   DJNZ R6, loop1 
ENDM

START: 
init_LCD
	   MOV TMOD, #01H
	   MOV TH0, #0H
	   MOV TL0, #0H
	   MOV R1, #0H 
	   MOV A, R1
	   LCDcharWR

LOOP1:
		  delay
		MOV R2, #07FH
		MOV A, R2
		MOV P5, A
		MOV A, P7
		ANL A, R2
		CLR C
		SUBB A, R2
		JZ LOOP1
	   SETB TR0
	   MOV IE, #82H
	   MOV A, #00H
DALEJ: MOV R0, #0FH
CZEKAM:
	   MOV A, R0
	   JNZ CZEKAM
	   MOV B, #0AH
	   INC R1
	   MOV A, R1
	   SUBB A, #99
	   JNZ DALEJ2
	   MOV R1, #0H
	   DALEJ2:
	   LCDcntrlWR #CLEAR
	   MOV A, R1
	   DIV AB
	   ADD A, #30H
	   LCDcharWR
	   MOV A, B
	   ADD A, #30H
	   LCDcharWR
	   JMP DALEJ
	   NOP
	   NOP
	   NOP
	   JMP $
END START
