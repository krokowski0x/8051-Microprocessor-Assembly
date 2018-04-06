LJMP START
ORG 0100H

START:
    MOV R2, #0FH  ; Licznik głównej pętli
    MAINLOOP:
        MOV A, #55H    ; Włączenie ledów w konfiguracji 01010101
        MOV P1, A

        MOV R1, #0FAH  ; Zagnieżdżone pętle powodujące widoczne
  ZYLA: MOV R0, #0FFH  ; dla oka opóźnienie w działaniu programu
   KOT: DJNZ R0, KOT
        DJNZ R1, ZYLA

        MOV A, #0AAH   ; Włączenie ledów w konfiguracji odwrotnej
        MOV P1, A

        MOV R1, #0FAH  ; Analogiczne opóźnienie
 STOCH: MOV R0, #0FFH
MALYSZ: DJNZ R0, MALYSZ
        DJNZ R1, STOCH

    DJNZ R2, MAINLOOP  ; Zakończenie głównej pętli

    MOV A, #0FFH   ; Wyłączenie wszystkich ledów
    MOV P1, A

    NOP
    NOP  ; W tym miejscu umieszczony był breakpoint pracy ciągłej
    NOP
    JMP $

END START
