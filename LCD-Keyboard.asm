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

ORG 100H

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
DJNZ R3, end1
LCDcntrlWR #HOM2
end1: 
DJNZ R4, end2
LCDcntrlWR #CLEAR
MOV R3, #10H
MOV R4, #20H
end2:
ENDM

init_LCD MACRO
LCDcntrlWR #INITDISP
LCDcntrlWR #CLEAR
LCDcntrlWR #LCDON
ENDM

delay MACRO
LOCAL loop1, loop2
MOV R1, #0FAH
loop1: MOV R0, #03BH
loop2: DJNZ R0, loop2
	   DJNZ R1, loop1 
ENDM

START:
init_LCD
MOV R3, #10H
MOV R4, #20H
MOV DPTR, #8077H ; 1
MOV A, #31H
MOVX @DPTR, A
MOV DPTR, #807BH ; 2
MOV A, #32H
MOVX @DPTR, A
MOV DPTR, #807DH ; 3
MOV A, #33H
MOVX @DPTR, A
MOV DPTR, #807EH ; A
MOV A, #41H
MOVX @DPTR, A

MOV DPTR, #80B7H ; 4
MOV A, #34H
MOVX @DPTR, A
MOV DPTR, #80BBH ; 5
MOV A, #35H
MOVX @DPTR, A
MOV DPTR, #80BDH ; 6
MOV A, #36H
MOVX @DPTR, A
MOV DPTR, #80BEH ; B
MOV A, #42H
MOVX @DPTR, A

MOV DPTR, #80D7H ; 7
MOV A, #37H
MOVX @DPTR, A
MOV DPTR, #80DBH ; 8
MOV A, #38H
MOVX @DPTR, A
MOV DPTR, #80DDH ; 9
MOV A, #39H
MOVX @DPTR, A
MOV DPTR, #80DEH ; C
MOV A, #43H
MOVX @DPTR, A

MOV DPTR, #80E7H ; *
MOV A, #2AH
MOVX @DPTR, A
MOV DPTR, #80EBH ; 0
MOV A, #30H
MOVX @DPTR, A
MOV DPTR, #80EDH ; #
MOV A, #23H
MOVX @DPTR, A
MOV DPTR, #80EEH ; D
MOV A, #44H
MOVX @DPTR, A


MAINLOOP:
	delay
	MOV R0, #07FH
		MOV A, R0
		MOV P5, A
		MOV A, P7
		ANL A, R0
		MOV R2, A
		CLR C
		SUBB A, R0
		JZ NEXT1
		MOV A, R2
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR
		LCDcharWR
	NEXT1: delay 
		MOV R0, #0BFH
		MOV A, R0
		MOV P5, A
		MOV A, P7
		ANL A, R0
		MOV R2, A
		CLR C
		SUBB A, R0
		JZ NEXT2
		MOV A, R2
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR
		LCDcharWR
	NEXT2: delay
		MOV R0, #0DFH
		MOV A, R0
		MOV P5, A
		MOV A, P7
		ANL A, R0
		MOV R2, A
		CLR C
		SUBB A, R0
		JZ NEXT3
		MOV A, R2
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR
		LCDcharWR
	NEXT3: delay
		MOV R0, #0EFH
		MOV A, R0
		MOV P5, A
		MOV A, P7
		ANL A, R0
		MOV R2, A
		CLR C
		SUBB A, R0
		JZ jump
		MOV A, R2
		MOV DPH, #80H
		MOV DPL, A
		MOVX A, @DPTR
		LCDcharWR
jump:
JMP MAINLOOP

NOP
NOP
NOP
END START