LJMP START
ORG 0100H

START:
    MOV R2, #0FH  ; Main loop counter
    MAINLOOP:
        MOV A, #55H    ; Turn on LEDs in 01010101 config
        MOV P1, A

        MOV R1, #0FAH  ; Nested loops for longer delays
  ZYLA: MOV R0, #0FFH
   KOT: DJNZ R0, KOT
        DJNZ R1, ZYLA

        MOV A, #0AAH   ; Turn on LEDs in reverse config
        MOV P1, A

        MOV R1, #0FAH  ; Another delay
 STOCH: MOV R0, #0FFH
MALYSZ: DJNZ R0, MALYSZ
        DJNZ R1, STOCH

    DJNZ R2, MAINLOOP  ; Main loop end

    MOV A, #0FFH   ; Turn off all the LEDs
    MOV P1, A

    NOP
    NOP  ; Continuous work breakpoint should be marked here
    NOP
    JMP $

END START
