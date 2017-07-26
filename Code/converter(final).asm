;;;;;;;;;; ;;;;;;;;;; ;;;;;;;;;;

; number converter

; 1. decimal to binary
; 2. decimal to hexadecimal
; 3. binary to decimal
; 4. binary to hexadecimal
; 5. hexadecimal to decimal
; 6. hexadecimal to binary

;;;;;;;;;; ;;;;;;;;;; ;;;;;;;;;;


.MODEL SMALL

.STACK 100H

.DATA
    
    OUTD DW ?
    IND DB ?
    
    SELECT DB ?
    
    INP1 DW ?   ; save decimal input
    INP2 DW ?   ; save binary input
    INP3 DW ?   ; save hexadecimal input
    
    COUNT DB ?
    
    O1 DB ?     ; save 1st 4bit of a binary number
    T2 DB ?     ; save 2nd 4bit of a binary number
    T3 DB ?     ; save 3rd 4bit of a binary number
    F4 DB ?     ; save 4th 4bit of a binary number
    
    D1 DB ?     ; save 1st decimal digit
    D2 DB ?     ; save 2nd decimal digit
    D3 DB ?     ; save 3rd decimal digit
    D4 DB ?     ; save 4th decimal digit
    D5 DB ?     ; save 5th decimal digit
    
    REM DW ?
    
    NEWL DB 10,13,'$'   ;newline
    
    MENU DB 9,'MENU $'
    
    OP1 DB '1. DECIMAL TO BINARY $'
    OP2 DB '2. DECIMAL TO HEXADECIMAL $'
    OP3 DB '3. BINARY TO DECIMAL $'
    OP4 DB '4. BINARY TO HEXADECIMAL $'
    OP5 DB '5. HEXADECIMAL TO DECIMAL $'
    OP6 DB '6. HEXADECIMAL TO BINARY $'
    OP0 DB '0. EXIT $'
    
    DECIMALINP DB '-> INPUT CHARACTER(0 TO 9) WITH '-' OR + AND MAXIMUM INPUT 65,535 $'
    BINARYINP DB '-> INPUT CHARACTER(0 & 1) AND MAXIMUM INPUT 1111 1111 1111 1111 $'
    HEXADECIMALINP DB '-> INPUT CHARACTER(0 TO 9 && A TO F) AND MAXIMUM INPUT FFFF $'
    
    INDECIMAL DB 'DECIMAL VALUE: $'
    INBINARY DB 'BINARY VALUE: $'
    INHEXADECIMAL DB 'HEXADECIMAL VALUE: $'
    
    ERRORMSG DB 'NB: INPUT ERROR.PLEASE PRESS RIGHT KEYWORD !! $'
    ERRORINP DB 'NB: INPUT ERROR.PLEASE INPUT VALID NUMBER !! $'
    
    SELECTMSG DB 'SELECT: $'
    
    
    ENDMSG DB 9,'THANKS $'
    
.CODE
    
  START:
    
    MOV AX,@DATA    ; import data segment
    MOV DS,AX
    
    MOV AH,9
    LEA DX,MENU     ; print menu
    INT 21H
    
    LEA DX,NEWL
    INT 21H
    LEA DX,NEWL
    INT 21H
    
    LEA DX,OP1      ; print option1
    INT 21H
    LEA DX,NEWL
    INT 21H
    
    LEA DX,OP2      ; print option2
    INT 21H
    LEA DX,NEWL
    INT 21H
    
    LEA DX,OP3      ; print option3
    INT 21H
    LEA DX,NEWL
    INT 21H
    
    LEA DX,OP4      ; print option4
    INT 21H
    LEA DX,NEWL
    INT 21H
    
    LEA DX,OP5      ; print option5
    INT 21H
    LEA DX,NEWL
    INT 21H
    
    LEA DX,OP6      ; print option6
    INT 21H
    LEA DX,NEWL
    INT 21H
    
    LEA DX,OP0      ; print exit option
    INT 21H
    
    LEA DX,NEWL
    INT 21H
    LEA DX,NEWL
    INT 21H
    
    LEA DX,SELECTMSG    ; print select message
    INT 21H
    
    MOV AH,1
    INT 21H             ; taking input to select a option
    MOV SELECT,AL
    
    
    CMP SELECT,'1'
    JE DECIMAL          ; part1: decimal to others
    CMP SELECT,'2'
    JE DECIMAL
    
    CMP SELECT,'3'
    JE BINARY           ; part2: binary to others
    CMP SELECT,'4'
    JE BINARY
    
    CMP SELECT,'5'
    JE HEXADECIMAL      ; part3: hexadecimal to others
    CMP SELECT,'6'
    JE HEXADECIMAL
    
    CMP SELECT,'0'      ; part4: exit
    JE EXIT
    
    ;;ERROR TEST
    CMP SELECT,'0'
    JL ERROR
    
    CMP SELECT,'6'
    JG ERROR
    ;;;;;;;;;;;;
    
    
    DECIMAL:    ; part1
        
        MOV AH,9
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H        
        LEA DX,NEWL
        INT 21H
        
        LEA DX,DECIMALINP
        INT 21H
        
        LEA DX,NEWL
        INT 21H
        
        LEA DX,INDECIMAL
        INT 21H
        
        CALL INPUT_DECIMALFUN   ; calling decimal_input function
        MOV INP1,BX         ; input saved in INP1
        
        CMP SELECT,'1'          ; for binary output
        JE OUT_BINARY
        
        CMP SELECT,'2'          ; for hexadecimal output
        JE OUT_HEXA
        
        
        OUT_BINARY:
            
            MOV AH,9
            LEA DX,NEWL
            INT 21H
            LEA DX,NEWL
            INT 21H
            
            LEA DX,INBINARY
            INT 21H
            
            
            MOV BX,INP1     ; fix input in a register for output
            CALL OUT_BINARYFUN      ; calling binary_output function
            
            JMP AGAIN       ; jump to redo label
            
        
        OUT_HEXA:
            
            MOV AH,9
            LEA DX,NEWL
            INT 21H
            LEA DX,NEWL
            INT 21H
            
            LEA DX,INHEXADECIMAL
            INT 21H
            
            MOV BX,INP1     ; fix input in a register for output
            CALL OUT_HEXAFUN        ; calling hexadecimal_output function
                
            JMP AGAIN       ; jump to redo label
        
        
        
     BINARY:
        
        MOV AH,9
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
        
        LEA DX,BINARYINP
        INT 21H
        
        LEA DX,NEWL
        INT 21H
        
        LEA DX,INBINARY
        INT 21H
        
        CALL INPUT_BINARYFUN
        MOV INP2,BX
        
        CMP SELECT,'3'
        JE OUT_DECIMAL
        
        CMP SELECT,'4'
        JE OUT_HEXA2
        
        
        OUT_DECIMAL:
            
            MOV AH,9
            LEA DX,NEWL
            INT 21H
            LEA DX,NEWL
            INT 21H
            
            LEA DX,INDECIMAL
            INT 21H
            
            MOV BX,INP2
            CALL OUT_DECIMALFUN    
        
            JMP AGAIN
        
        OUT_HEXA2:
            
            MOV AH,9
            LEA DX,NEWL
            INT 21H
            LEA DX,NEWL
            INT 21H
            
            LEA DX,INHEXADECIMAL
            INT 21H
            
            MOV BX,INP2
            CALL OUT_HEXAFUN    
        
            JMP AGAIN     
            
     
     
     hexadecimal:
        
        MOV AH,9
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
        
        LEA DX,HEXADECIMALINP
        INT 21H
        
        LEA DX,NEWL
        INT 21H
        
        LEA DX,INHEXADECIMAL
        INT 21H
        
        CALL INPUT_HEXAFUN
        MOV INP3,BX
        
        CMP SELECT,'5'
        JE OUT_DECIMAL2
        
        CMP SELECT,'6'
        JE OUT_BINARY2
        
        
        OUT_DECIMAL2:
            
            MOV AH,9
            LEA DX,NEWL
            INT 21H
            LEA DX,NEWL
            INT 21H
            
            LEA DX,INDECIMAL
            INT 21H
            
            
            MOV BX,INP3
            CALL OUT_DECIMALFUN    
        
            JMP AGAIN
        
        
        OUT_BINARY2:
            
            MOV AH,9
            LEA DX,NEWL
            INT 21H
            LEA DX,NEWL
            INT 21H
            
            LEA DX,INBINARY
            INT 21H
            
            MOV BX,INP3
            CALL OUT_BINARYFUN    
        
            jmp AGAIN
            
        
        
        


;;;Functions Area        
        
;;; input_deci and convert into binary(input in bx)        

        INPUT_DECIMALFUN PROC
        
                MOV AH,1
                INT 21H
                MOV IND,AL
                
                CMP IND,'-'
                JNE NEXTPOS
                
                JMP BEGIN1
                
                NEXTPOS:
                    CMP IND,'+'
                    JNE ERRORIN
              
                
            BEGIN1:     
                XOR BX,BX      
                
                MOV AH,1      
                INT 21H
                
                MOV CX,0  
        
                REPEAT3:
                    
                    ;;ERROR TEST
                    CMP AL,'0'
                    JL ERRORIN
                    
                    CMP AL,'9'
                    JG ERRORIN
                    ;;;;;;;;;;;
                    
                    CMP CX,0
                    JE ADD1
                    CMP CX,1
                    JE ADD2
                    CMP CX,2
                    JE ADD3
                    CMP CX,3
                    JE ADD4
                    CMP CX,4
                    JE ADD5
                    
                    ADD1:
                        MOV D1,AL
                        JMP WORK
                    ADD2:
                        MOV D2,AL
                        JMP WORK
                    ADD3:
                        MOV D3,AL
                        JMP WORK
                    ADD4:
                        MOV D4,AL
                        JMP WORK
                    ADD5:
                        MOV D5,AL
                        JMP WORK
                        
                    
                    WORK:
                    AND AX,000FH      
                    PUSH AX
                    
                    MOV AX,10     
                    MUL BX        
                    POP BX         
                    ADD BX,AX      
                    
                    INC CX
                    CMP CX,5
                    JE EXIT2
                    
                    MOV AH,1    
                    INT 21H
                    
                    CMP AL,0DH   
                    JE EXIT1
                            
                    CMP AL,0DH   
                    JNE REPEATING
                    
                        
                    REPEATING:
                        
                        JMP REPEAT3
                    
                    
                    EXIT2:
                        
                        MOV AL,D1
                        CMP AL,'6'
                        JG ERROR
                        CMP AL,'6'
                        JLE NEXT2
                        
                            NEXT2:
                                MOV AL,D2
                                CMP AL,'5'
                                JG ERRORIN
                                CMP AL,'5'
                                JLE NEXT3
                        
                                NEXT3:
                                    MOV AL,D3
                                    CMP AL,'5'
                                    JG ERRORIN
                                    CMP AL,'5'
                                    JLE NEXT4
                        
                                    NEXT4:
                                        MOV AL,D4
                                        CMP AL,'3'
                                        JG ERRORIN
                                        CMP AL,'3'
                                        JLE NEXT5
                        
                                        NEXT5:
                                            MOV AL,D5
                                            CMP AL,'5'
                                            JG ERRORIN                                                                
                        
                    EXIT1:
                        
                        CMP IND,'-'
                        JE NGD
                        
                        JMP EXITIND
                        NGD:
                         NEG BX
                    
                    EXITIND:       
            
            RET                
        INPUT_DECIMALFUN ENDP    


;;; output_hexadecimal from binary(work with bx)        
        
        out_hexafun proc
            
            mov al,0
            mov count,al
            
            xor dx,dx
            xor ax,ax
            
            
            mov cx,16
            
            while:
                shl dx,1
                inc count
                
                shl bx,1
                jc one
                
                
                mov ax,0
                jmp cont
                
                one:
                    mov ax,1
                
                cont:
                    or dx,ax
                    
                    cmp count,4
                    je pus
                    jmp lp
                    
                    pus:
                        cmp dx,9
                        jge letter
                        
                        add dx,30h
                        jmp prnt
                        
                        letter:
                        add dx,37h
                        
                        prnt:
                        mov ah,2 
                        int 21h
                        
                        xor dx,dx
                        mov count,0
                         
                    lp:    
                        loop while    
            
            
                
            
            
            ret
         out_hexafun endp    




;;;output_binary from binary(work with bx)
        
        OUT_BINARYFUN PROC
            
            MOV AH,2
            MOV CX,16      
     
            TOPBIN:
                SHL BX,1       
                JNC ZEROBIN   
                
                MOV DL,49      
                JMP PRINTBIN   
                
                ZEROBIN:          
                    MOV DL,48     
                    
                PRINTBIN:          
                    INT 21H     
                    LOOP TOPBIN            
        
        
            RET
        OUT_BINARYFUN ENDP




;;;input_binary and convert into binary
        
        INPUT_BINARYFUN PROC
            
            XOR AX,AX
            XOR BX,BX
            XOR CX,CX
            XOR DX,DX
            
            MOV CX,16
            
            INPUT_BIN:
                 
                 MOV AH,1
                 INT 21H
                 
                 CMP AL,0DH
                 JE BREAK
                 
                 ;;ERROR TEST
                 CMP AL,'1'
                 JG ERRORIN
                 
                 CMP AL,'0'
                 JL ERRORIN
                 ;;;;;;;;;;;;
                 
                 SHL BX,1
                     
                    
                 SUB AL,30H
                 OR BL,AL
                 
                 LOOP INPUT_BIN
            
             BREAK:
                
        
            RET
        INPUT_BINARYFUN ENDP



;;;output_decimal from binary

        OUT_DECIMALFUN PROC
            
            XOR AX,AX
            
            MOV AX,BX
            MOV OUTD,BX
            
           DO:
            
            MOV AX,OUTD
            
            CMP AX,9999
            JG ATENT
            
            CMP AX,999
            JG AONET
            
            CMP AX,99
            JG AONEH
            
            CMP AX,9
            JG ATEN
            
            CMP AX,0
            JGE AZERO
            
            CMP AX,0
            JL UZERO
            
            
            ATENT:
                
                XOR DX,DX
                
                MOV BX,10000
                DIV BX
                
                MOV REM,DX
                
                ADD AL,30H
                
                MOV AH,2
                MOV DL,AL
                INT 21H
                
                MOV AX,REM
                
            
            AONET:
                
                XOR DX,DX
                
                MOV BX,1000
                DIV BX
                
                MOV REM,DX
                
                ADD AL,30H
                
                MOV AH,2
                MOV DL,AL
                INT 21H
                
                MOV AX,REM
            
            
            AONEH:
                
                XOR DX,DX
                
                MOV BX,100
                DIV BX
                
                MOV REM,DX
                
                ADD AL,30H
                
                MOV AH,2
                MOV DL,AL
                INT 21H
                
                MOV AX,REM
            
            
            ATEN:
                
                XOR DX,DX
                
                MOV BX,10
                DIV BX
                
                MOV REM,DX
                
                ADD AL,30H
                
                MOV AH,2
                MOV DL,AL
                INT 21H
                
                MOV AX,REM
            
            
            AZERO:
                
                ADD AL,30H
                
                MOV AH,2
                MOV DL,AL
                INT 21H
                
                JMP BREAK2
            
            
            UZERO:
                
                MOV AH,2
                MOV DL,'-'
                INT 21H
                
                NEG OUTD
                JMP DO
                
            
            BREAK2:
                
            RET
        OUT_DECIMALFUN ENDP




;;;input_hexadecimal and convert into binary
        
        INPUT_HEXAFUN PROC
            
            XOR BX,BX
            XOR CX,CX
            
            MOV CX,4
            
            WHILE2:
                
                MOV AH,1
                INT 21H
                
                CMP AL,0DH
                JE BREAK3
                
                ;;ERROR TEST
                CMP AL,'0'
                JL ERRORIN
                
                CMP AL,'9'
                JG STEP1
                
                JMP NEXT
                
                STEP1:
                    CMP AL,'A'
                    JL ERRORIN
                    
                    CMP AL,'F'
                    JG ERRORIN
         
                NEXT:
                ;;;;;;;;;;;;;;
                SHL BX,4
                
                CMP AL,39H
                JG LETTER1
                
                SUB AL,30H
                JMP SHIFT
                
                LETTER1:
                    SUB AL,37H
                    
                SHIFT:
                    OR BL,AL
                    
                    LOOP WHILE2
            
            BREAK3:
        
            RET
        INPUT_HEXAFUN ENDP




;;ERROR input
    
    ERRORIN:
        
        MOV AH,9
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
        
        LEA DX,ERRORINP
        INT 21H
        
        JMP AGAIN



;;ERROR message
    
    ERROR:
        
        MOV AH,9
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
        
        LEA DX,ERRORMSG
        INT 21H
        
        JMP AGAIN




;;REPEAT PROGRAMM
    
    AGAIN:
        
        MOV AH,9
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
                
        
        JMP START
    



;;end programm
    
    EXIT:
        
        MOV AH,9
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H 
        LEA DX,NEWL
        INT 21H
        
        LEA DX,ENDMSG
        INT 21H
        
        MOV AH,4CH      ; ignore emulator haulted 
        INT 21H