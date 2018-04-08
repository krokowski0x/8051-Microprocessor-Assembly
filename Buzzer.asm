LJMP START
ORG 0100H

START:
    MAINLOOP:
        CPL P3.2  ; Buzzer state change (0 -> 1, 1 -> 0)

        MOV R0, #0FFH  ; Delay loop
   KOT: DJNZ R0, KOT

        CPL P3.2

        MOV R0, #0FFH
MALYSZ: DJNZ R0, MALYSZ

        CPL P3.2

        MOV R0, #0FAH  ;  Sound frequency / PWM change
 STOCH: DJNZ R0, STOCH

        CPL P3.2

        MOV R0, #0FAH
AHONEN: DJNZ R0, AHONEN

    LJMP MAINLOOP

    NOP
    NOP  ; Continuous work breakpoint should be marked here
    NOP
    JMP $

END START
