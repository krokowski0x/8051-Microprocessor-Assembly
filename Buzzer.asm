LJMP START
ORG 0100H

START:
    MAINLOOP:
        CPL P3.2  ; Zmiana stanu buzzera (0 -> 1, 1 -> 0)

        MOV R0, #0FFH  ; Pętla wprowadzająca opóźnienie
   KOT: DJNZ R0, KOT

        CPL P3.2

        MOV R0, #0FFH
MALYSZ: DJNZ R0, MALYSZ

        CPL P3.2

        MOV R0, #0FAH  ;  Zmiana wypełnienia sygnału (częstotliwości dźwięku)
 STOCH: DJNZ R0, STOCH

        CPL P3.2

        MOV R0, #0FAH
AHONEN: DJNZ R0, AHONEN

    LJMP MAINLOOP

    NOP
    NOP  ; W tym miejscu umieszczony był breakpoint pracy ciągłej
    NOP
    JMP $

END START
