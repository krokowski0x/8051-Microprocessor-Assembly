LJMP START
ORG 0100H

START:
  MOV A, #06
  ADD A, #03
  SUBB A, #02
  MOV B, #03
  MUL AB
  MOV B, #02
  DIV AB

  MOV A, #0101101B
  MOV B, #1000010B
  ANL A, B
  MOV A, #0101101B
  MOV B, #1000010B
  ORL A, B
  MOV A, #0101101B
  MOV B, #1000010B
  XRL A, B

  MOV DPTR, #8002H
  MOVX A, @DPTR
  MOV A, #08H
  MOVX @DPTR, A

  NOP
  NOP
  NOP
  JMP $

END START