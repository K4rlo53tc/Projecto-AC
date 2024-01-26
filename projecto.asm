
; **********************************************************************
BUFFER	EQU	200H	
LINHA	EQU	8		
PIN     EQU 0E000H
POUT    EQU 0C000H
; **********************************************************************

;-------------------------------------------------------
stackSize EQU 100H
pixelsMatriz  EQU 8000H
PLACE 2000H
pilha: TABLE stackSize
stackBase:
PLACE 2200H
ptable:STRING 01H,02H,04H,08H,10H,20H,40H,80H
;-------------------------------------------------------
PLACE 3200H
linhaJogador equ 3200H
colunaJogador equ 3202H
linhaC1 equ 3204H
colunaC1 equ 3206H
linhaC2 equ 3208H
colunaC2 equ 3210H
linhaC3 equ 3212H
colunaC3 equ 3214H
linhaC4 equ 3216H
colunaC4 equ 3218H
linhaC5 equ 3220H
colunaC5 equ 3222H
linhaCc1 equ 3224H
colunaCc1 equ 3226H
linhaCc2 equ 3228H
colunaCc2 equ 3230H
linhaCc3 equ 3232H
colunaCc3 equ 3234H
linhaCc4 equ 3236H
colunaCc4 equ 3238H
linhaCc5 equ 3240H
colunaCc5 equ 3242H
;-------------------------------------------------------


PLACE 0
main: MOV SP,stackBase


CALL inicializacaoP



inicioPrincipal:
    CALL inicioCbJg
    CALL desenhaOutrosObjectos
    CALL teclado
    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,4H
    CMP R4,R5
    JZ andaEsquerda

    MOV R5,BUFFER
    MOVB R4,[R5]
    MOV R5,6H
    CMP R4,R5
    JZ andaDireita
    JMP inicioPrincipal



acabou:
jmp acabou













andaEsquerda:
    call limpatela
    MOV R3,linhaJogador
    MOV R4,colunaJogador
    MOV R1,[R3]
    MOV R2,[R4]
    SUB R2,1H
    MOV [R4],R2
    JMP inicioPrincipal



andaDireita:
    call limpatela
    MOV R3,linhaJogador
    MOV R4,colunaJogador
    MOV R1,[R3]
    MOV R2,[R4]
    ADD R2,1H
    MOV [R4],R2
    JMP inicioPrincipal












limpatela:
        MOV R1, 8000H
        MOV R2, 807FH
        MOV R0,0H
    limpatudo:
        MOVB [R1],R0
        ADD R1,1H
        CMP R2,R1
        JN RETOR1
        JMP limpatudo



RETOR1:
    RET








pixel_xy: 
          PUSH R4
          PUSH R6
          PUSH R7
          PUSH R2
          PUSH R5
          PUSH R3

          MOV R4,4
		  MOV R6,8
		  MOV R7,R2
          MUL R4,R1
          DIV R7,R6
          ADD R4,R7
	      MOV R7, pixelsMatriz
		  ADD R4,R7
		  MOV R6,7H
		  CMP R2,R6
		  JLE bitpixel
		  MOV R6,0FH
		  CMP R2,R6
		  JLE bitpixel
		  MOV R6,17H
		  CMP R2,R6
		  JLE bitpixel
		  MOV R6 , 1FH
bitpixel:
		SUB R6,R2
		MOV R5,ptable
		ADD R5,R6
		MOVB R3,[R5]
		MOVB R6,[R4]
		OR R6,R3
		MOVB [R4],R6

         POP R3
          POP R5
          POP R2
          POP R7
          POP R6
          POP R4
		RET


inicioObjD:
    PUSH R3
    PUSH R4
    PUSH R1
    PUSH R2
    PUSH R10
    PUSH R9
    MOV R10,3H
    MOV R9,1H
desenhaObjD1:
    call pixel_xy
    CMP R10,R9
    JZ inicioObjD2
    ADD R9,1H
    SUB R1,1H
    ADD R2,1H
    JMP desenhaObjD1

inicioObjD2:
    MOV R10,3H
    MOV R9,1H
    SUB R2,2H
desenhaObjD2:
    call pixel_xy
    CMP R10,R9
    JZ RETORNO
    ADD R9,1H
    ADD R1,1H
    ADD R2,1H
    JMP desenhaObjD2

inicioCruz:
    PUSH R3
    PUSH R4
    PUSH R1
    PUSH R2
    PUSH R10
    PUSH R9
    MOV R10,3
    MOV R9,1H
desenhaCruz1:
    call pixel_xy
    CMP R10,R9
    JZ inicioCruz2
    SUB R1,1H
    ADD R9,1H
    JMP desenhaCruz1

inicioCruz2:
    MOV R10,3
    MOV R9,1H
    ADD R1,1H
    SUB R2,1H
    desenhaCruz2:
        call pixel_xy
        CMP R10,R9
        JZ RETORNO
        ADD R2,1H
        ADD R9,1H
        JMP desenhaCruz2


inicioCbJg:
    PUSH R3
    PUSH R4
    PUSH R1
    PUSH R2
    PUSH R10
    PUSH R9
    MOV R3,linhaJogador
    MOV R4,colunaJogador
    MOV R1,[R3]
    MOV R2,[R4]
    MOV R10,3H
    MOV R9,1H 
    desenhaCabeJg:
        call pixel_xy
        CMP R10,R9
        JZ inicioPesq
        ADD R1,1H
        ADD R9,1H
        JMP desenhaCabeJg

inicioPesq:
    MOV R10,2H
    MOV R9,1H 
    ADD R1,1H
    SUB R2,1H
    desenhaPesq:
        call pixel_xy
        CMP R10,R9
        JZ inicioMao
        ADD R1,1H
        SUB R2,1H
        ADD R9,1H
        JMP desenhaPesq


inicioMao:
    MOV R10,5H
    MOV R9,1H
    SUB R1,3H
    desenhoMao:
        call pixel_xy
        CMP R10,R9
        JZ inicioPeD
        ADD R2,1H
        ADD R9,1H
        JMP desenhoMao

inicioPeD:
    MOV R10,2H
    MOV R9,1H
    SUB R2,1H
    ADD R1,2H
    desenhaPeD:
        call pixel_xy
        CMP R10,R9
        JZ RETORNO
        ADD R1,1H
        ADD R9,1H
        JMP desenhaPeD

RETORNO:
    POP R9
    POP R10
    POP R2
    POP R1
    POP R4
    POP R3
    RET

inicializacaoP:
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4



    MOV R1, linhaJogador
    MOV R2,colunaJogador
    MOV R3,0EH
    MOV R4,0FH
    MOV [R1],R3
    MOV [R2],R4
    MOV R1,linhaC1
    MOV R2, colunaC1
    MOV R3,6H
    MOV R4,9H
    MOV [R1],R3
    MOV [R2],R4
    MOV R1,linhaC2
    MOV R2, colunaC2
    MOV R3,4H
    MOV R4,0DH
    MOV [R1],R3
    MOV [R2],R4
    MOV R1,linhaC3
    MOV R2, colunaC3
    MOV R3,2H
    MOV R4,11H
    MOV [R1],R3
    MOV [R2],R4
    MOV R1,linhaC4
    MOV R2, colunaC4
    MOV R3,4H
    MOV R4,15H
    MOV [R1],R3
    MOV [R2],R4
    MOV R1,linhaC5
    MOV R2, colunaC5
    MOV R3,7H
    MOV R4,18H
    MOV [R1],R3
    MOV [R2],R4

    MOV R1,linhaCc1
    MOV R2, colunaCc1
    MOV R3,18H
    MOV R4,5H
    MOV [R1],R3
    MOV [R2],R4

    MOV R1,linhaCc2
    MOV R2, colunaCc2
    MOV R3,01CH
    MOV R4,8H
    MOV [R1],R3
    MOV [R2],R4

    MOV R1,linhaCc3
    MOV R2, colunaCc3
    MOV R3,01FH
    MOV R4,0CH
    MOV [R1],R3
    MOV [R2],R4



    MOV R1,linhaCc4
    MOV R2, colunaCc4
    MOV R3,01DH
    MOV R4,10H
    MOV [R1],R3
    MOV [R2],R4

    MOV R1,linhaCc5
    MOV R2, colunaCc5
    MOV R3,01BH
    MOV R4,13H
    MOV [R1],R3
    MOV [R2],R4

    POP R4
    POP R3
    POP R2
    POP R1
    RET




desenhaOutrosObjectos:
    PUSH R3
    PUSH R4
    PUSH R1
    PUSH R2


    MOV R3,linhaC1
    MOV R4,colunaC1
    MOV R1 , [R3]
    MOV R2, [R4]
    CALL inicioObjD
    MOV R3,linhaC2
    MOV R4,colunaC2
    MOV R1 , [R3]
    MOV R2, [R4]
    CALL inicioObjD
    MOV R3,linhaC3
    MOV R4,colunaC3
    MOV R1 , [R3]
    MOV R2, [R4]
    CALL inicioObjD
    MOV R3,linhaC4
    MOV R4,colunaC4
    MOV R1 , [R3]
    MOV R2, [R4]
    CALL inicioObjD
    MOV R3,linhaC5
    MOV R4,colunaC5
    MOV R1 , [R3]
    MOV R2, [R4]
    CALL inicioObjD

    MOV R3,linhaCc1
    MOV R4,colunaCc1
    MOV R1,[R3]
    MOV R2,[R4]
    CALL inicioCruz


    MOV R3,linhaCc2
    MOV R4,colunaCc2
    MOV R1,[R3]
    MOV R2,[R4]
    CALL inicioCruz

    MOV R3,linhaCc3
    MOV R4,colunaCc3
    MOV R1,[R3]
    MOV R2,[R4]
    CALL inicioCruz
    MOV R3,linhaCc4
    MOV R4,colunaCc4
    MOV R1,[R3]
    MOV R2,[R4]
    CALL inicioCruz
    MOV R3,linhaCc5
    MOV R4,colunaCc5
    MOV R1,[R3]
    MOV R2,[R4]
    CALL inicioCruz
    POP R2
    POP R1
    POP R4
    POP R3
    RET




teclado:
    PUSH R1
    PUSH R6
    PUSH R2
    PUSH R3
    PUSH R8
    PUSH R10
    PUSH R4

    inicio:
    MOV R5, BUFFER	; R5 com endere�o de mem�ria BUFFER
        MOV	R1, 1	; testar a linha 1
        MOV R6,PIN
        MOV	R2, POUT	; R2 com o endere�o do perif�rico
    ; corpo principal do programa
    ciclo:MOVB 	[R2], R1	; escrever no porto de sa�da
        MOVB 	R3, [R6]	; ler do porto de entrada
        AND 	R3, R3		; afectar as flags (MOVs n�o afectam as flags)
        JZ 	inicializarLinha		; nenhuma tecla premida
        MOV R8,1
        CMP R8,R1
        JZ linha1
        MOV R8,2
        CMP R8,R1
        JZ linha2
        MOV R8,4
        CMP R8,R1
        JZ linha3
        MOV R8,8
        CMP R8,R1
        JZ linha4

    linha4:
        linha4C1:MOV R8,1
        CMP R8,R3
        JZ EC
        JNZ linha4C2
        linha4C2:MOV R8,2
        CMP R8,R3
        JZ ED
        JNZ linha4C3
        linha4C3:MOV R8,4
        CMP R8,R3
        JZ EE
        JNZ linha4C4
        linha4C4:MOV R8,8
        CMP R8,R3
        JZ EF

    linha3:
        linha3C1:MOV R8,1
        CMP R8,R3
        JZ Eoito
        JNZ linha3C2
        linha3C2:MOV R8,2
        CMP R8,R3
        JZ Enove
        JNZ linha3C3
        linha3C3:MOV R8,4
        CMP R8,R3
        JZ EA
        JNZ linha3C4
        linha3C4:MOV R8,8
        CMP R8,R3
        JZ EB

    linha2:
        linha2C1:MOV R8,1
        CMP R8,R3
        JZ Equatro
        JNZ linha2C2
        linha2C2:MOV R8,2
        CMP R8,R3
        JZ Ecinco
        JNZ linha2C3
        linha2C3:MOV R8,4
        CMP R8,R3
        JZ Eseis
        JNZ linha2C4
        linha2C4:MOV R8,8
        CMP R8,R3
        JZ Esete


    linha1:
        linha1C1:MOV R8,1
        CMP R8,R3
        JZ Ezero
        JNZ linha1C2
        linha1C2:MOV R8,2
        CMP R8,R3
        JZ Eum
        JNZ linha1C3
        linha1C3:MOV R8,4
        CMP R8,R3
        JZ Edois
        JNZ linha1C4
        linha1C4:MOV R8,8
        CMP R8,R3
        JZ Etres

        Ezero:MOV R10,0H
        JMP armazena
        Eum:MOV R10,1H
        JMP armazena
        Edois:MOV R10,2H
        JMP armazena
        Etres:MOV R10,3H
        JMP armazena
        Equatro:MOV R10,4H
        JMP armazena
        Ecinco:MOV R10,5H
        JMP armazena
        Eseis:MOV R10,6H
        JMP armazena
        Esete:MOV R10,7H
        JMP armazena
        Eoito:MOV R10,8H
        JMP armazena
        Enove:MOV R10,9H
        JMP armazena
        EA:MOV R10,9H
        ADD R10,1H
        JMP armazena
        EB:MOV R10,9H
        ADD R10,2H
        JMP armazena
        EC:MOV R10,9H
        ADD R10,3H
        JMP armazena
        ED:MOV R10,9H
        ADD R10,4H
        JMP armazena
        EE:MOV R10,9H
        ADD R10,5H
        JMP armazena
        EF:MOV R10,9H
        ADD R10,6H
    armazena:
        MOV	R4, R10		; guardar tecla premida em registo
        MOVB 	[R5], R4	; guarda tecla premida em mem�ria
        JMP RETOR



    inicializarLinha:
        MOV R8,2
        MUL R1,R8
        MOV R8,8
        CMP R8,R1
        JN inicio
        JNN ciclo




RETOR:
    POP R4
    POP R10
    POP R8
    POP R3
    POP R2
    POP R6
    POP R1
    RET


FIM:



