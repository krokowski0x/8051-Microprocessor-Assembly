LJMP START

LCDstatus  equ 0FF2EH
LCDcontrol equ 0FF2CH
LCDdataWR  equ 0FF2DH
LCDdataRD  equ 0FF2FH

 // LCD control bytes ----------------------------------
#define HOME 0x80     // put curcor to second line
#define INITDISP 0x38 // LCD init (8-bit mode)
#define HOM2 0xc0     // put curcor to second line
#define LCDON 0x0e    // LCD nn, cursor off, blinking off
#define CLEAR 0x01    // LCD display clear

ORG 0100H

LCDcntrlWR MACRO x
  LOCAL loop
  loop:
    MOV DPTR,#LCDstatus
    MOVX A,@DPTR
  JB ACC.7, loop  ; check if LCD busy

  MOV DPTR,#LCDcontrol  ; write to LCD control
  MOV A, x
  MOVX @DPTR,A
ENDM

LCDcharWR MACRO
  LOCAL loop1,loop2
  PUSH ACC

  loop1:
    MOV DPTR,#LCDstatus
    MOVX A,@DPTR
  JB ACC.7,loop1  ; check if LCD busy

  loop2:
    MOV DPTR,#LCDdataWR  ; write data to LCD
    POP ACC
    MOVX @DPTR,A
ENDM

init_LCD MACRO
  LCDcntrlWR #INITDISP
  LCDcntrlWR #CLEAR
  LCDcntrlWR #LCDON
ENDM


START:
	init_LCD ; Initialize LCD

	MOV A, #41H  ; Load letter A to the LCD
	LCDcharWR

	MOV A, #42H  ; Letter B
	LCDcharWR

	MOV A, #43H  ; Letter C
	LCDcharWR

	LCDcntrlWR #HOM2  ; Move to the new line

	MOV A, #44H  ; Letter D
	LCDcharWR

	MOV A, #45H  ; Letter E
	LCDcharWR

	MOV A, #46H  ; Letter F
	LCDcharWR

  NOP
	NOP
  NOP
  JMP $
END START
