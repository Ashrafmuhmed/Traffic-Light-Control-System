
_main:

;MyProject.c,21 :: 		void main(){
;MyProject.c,22 :: 		ADCON1=0x07; //or ADCON1=0x06; for using PortA & PortE as Digital Pins
	MOVLW      7
	MOVWF      ADCON1+0
;MyProject.c,24 :: 		trisd = trisc = trisb = 0x00;
	CLRF       TRISB+0
	MOVF       TRISB+0, 0
	MOVWF      TRISC+0
	MOVF       TRISC+0, 0
	MOVWF      TRISD+0
;MyProject.c,25 :: 		portd = portc = portb = 0  ;
	CLRF       PORTB+0
	MOVF       PORTB+0, 0
	MOVWF      PORTC+0
	MOVF       PORTC+0, 0
	MOVWF      PORTD+0
;MyProject.c,26 :: 		redWest = 1 ;
	BSF        PORTC+0, 0
;MyProject.c,27 :: 		greenSouth = 1 ;
	BSF        PORTC+0, 3
;MyProject.c,29 :: 		trisA.b0 = trisA.b1 = 1;
	BSF        TRISA+0, 1
	BTFSC      TRISA+0, 1
	GOTO       L__main34
	BCF        TRISA+0, 0
	GOTO       L__main35
L__main34:
	BSF        TRISA+0, 0
L__main35:
;MyProject.c,32 :: 		while(1){ // count from 0 to 9 and repeat
L_main0:
;MyProject.c,33 :: 		if(autoFlag == 0)
	BTFSC      PORTA+0, 0
	GOTO       L_main2
;MyProject.c,35 :: 		automaticMode();
	CALL       _automaticMode+0
;MyProject.c,36 :: 		}
	GOTO       L_main3
L_main2:
;MyProject.c,37 :: 		else if(manualFlag ==0)
	BTFSC      PORTA+0, 1
	GOTO       L_main4
;MyProject.c,39 :: 		manualMode();
	CALL       _manualMode+0
;MyProject.c,40 :: 		}
L_main4:
L_main3:
;MyProject.c,41 :: 		}
	GOTO       L_main0
;MyProject.c,42 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_manualAutoCheck:

;MyProject.c,44 :: 		void manualAutoCheck()
;MyProject.c,46 :: 		westSeg = southSeg = 0 ;
	BCF        PORTD+0, 1
	BTFSC      PORTD+0, 1
	GOTO       L__manualAutoCheck37
	BCF        PORTD+0, 0
	GOTO       L__manualAutoCheck38
L__manualAutoCheck37:
	BSF        PORTD+0, 0
L__manualAutoCheck38:
;MyProject.c,47 :: 		if(manualFlag == 0 && autoFlag != 0 )
	BTFSC      PORTA+0, 1
	GOTO       L_manualAutoCheck7
	BTFSS      PORTA+0, 0
	GOTO       L_manualAutoCheck7
L__manualAutoCheck32:
;MyProject.c,49 :: 		manualMode();
	CALL       _manualMode+0
;MyProject.c,50 :: 		}
	GOTO       L_manualAutoCheck8
L_manualAutoCheck7:
;MyProject.c,53 :: 		return ;
	GOTO       L_end_manualAutoCheck
;MyProject.c,54 :: 		}
L_manualAutoCheck8:
;MyProject.c,55 :: 		}
L_end_manualAutoCheck:
	RETURN
; end of _manualAutoCheck

_automaticMode:

;MyProject.c,57 :: 		void automaticMode()
;MyProject.c,59 :: 		westSeg = southSeg = 1 ;
	BSF        PORTD+0, 1
	BTFSC      PORTD+0, 1
	GOTO       L__automaticMode40
	BCF        PORTD+0, 0
	GOTO       L__automaticMode41
L__automaticMode40:
	BSF        PORTD+0, 0
L__automaticMode41:
;MyProject.c,60 :: 		if(greenSouth == 1)
	BTFSS      PORTC+0, 3
	GOTO       L_automaticMode9
;MyProject.c,62 :: 		counter = 12 ;
	MOVLW      12
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
;MyProject.c,63 :: 		while(counter>=0)
L_automaticMode10:
	MOVLW      128
	XORWF      _counter+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automaticMode42
	MOVLW      0
	SUBWF      _counter+0, 0
L__automaticMode42:
	BTFSS      STATUS+0, 0
	GOTO       L_automaticMode11
;MyProject.c,65 :: 		portb = display[counter-1];
	MOVLW      1
	SUBWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _counter+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,66 :: 		delay_ms(350);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      142
	MOVWF      R12+0
	MOVLW      18
	MOVWF      R13+0
L_automaticMode12:
	DECFSZ     R13+0, 1
	GOTO       L_automaticMode12
	DECFSZ     R12+0, 1
	GOTO       L_automaticMode12
	DECFSZ     R11+0, 1
	GOTO       L_automaticMode12
	NOP
;MyProject.c,67 :: 		counter--;
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;MyProject.c,68 :: 		}
	GOTO       L_automaticMode10
L_automaticMode11:
;MyProject.c,69 :: 		greenSouth = 0 ;
	BCF        PORTC+0, 3
;MyProject.c,70 :: 		yellowSouth = 1 ;
	BSF        PORTC+0, 4
;MyProject.c,71 :: 		counter = 3 ;
	MOVLW      3
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
;MyProject.c,72 :: 		while(counter>=0)
L_automaticMode13:
	MOVLW      128
	XORWF      _counter+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automaticMode43
	MOVLW      0
	SUBWF      _counter+0, 0
L__automaticMode43:
	BTFSS      STATUS+0, 0
	GOTO       L_automaticMode14
;MyProject.c,74 :: 		portb = display[counter-1];
	MOVLW      1
	SUBWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _counter+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,75 :: 		delay_ms(350);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      142
	MOVWF      R12+0
	MOVLW      18
	MOVWF      R13+0
L_automaticMode15:
	DECFSZ     R13+0, 1
	GOTO       L_automaticMode15
	DECFSZ     R12+0, 1
	GOTO       L_automaticMode15
	DECFSZ     R11+0, 1
	GOTO       L_automaticMode15
	NOP
;MyProject.c,76 :: 		counter--;
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;MyProject.c,77 :: 		}
	GOTO       L_automaticMode13
L_automaticMode14:
;MyProject.c,78 :: 		greenWest = redSouth = 1 ;
	BSF        PORTC+0, 5
	BTFSC      PORTC+0, 5
	GOTO       L__automaticMode44
	BCF        PORTC+0, 2
	GOTO       L__automaticMode45
L__automaticMode44:
	BSF        PORTC+0, 2
L__automaticMode45:
;MyProject.c,79 :: 		yellowSouth = redWest = 0 ;
	BCF        PORTC+0, 0
	BTFSC      PORTC+0, 0
	GOTO       L__automaticMode46
	BCF        PORTC+0, 4
	GOTO       L__automaticMode47
L__automaticMode46:
	BSF        PORTC+0, 4
L__automaticMode47:
;MyProject.c,80 :: 		}
	GOTO       L_automaticMode16
L_automaticMode9:
;MyProject.c,83 :: 		counter = 20 ;
	MOVLW      20
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
;MyProject.c,84 :: 		while(counter >= 0)
L_automaticMode17:
	MOVLW      128
	XORWF      _counter+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automaticMode48
	MOVLW      0
	SUBWF      _counter+0, 0
L__automaticMode48:
	BTFSS      STATUS+0, 0
	GOTO       L_automaticMode18
;MyProject.c,86 :: 		portb = display[counter-1];
	MOVLW      1
	SUBWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _counter+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,87 :: 		delay_ms(350);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      142
	MOVWF      R12+0
	MOVLW      18
	MOVWF      R13+0
L_automaticMode19:
	DECFSZ     R13+0, 1
	GOTO       L_automaticMode19
	DECFSZ     R12+0, 1
	GOTO       L_automaticMode19
	DECFSZ     R11+0, 1
	GOTO       L_automaticMode19
	NOP
;MyProject.c,88 :: 		counter--;
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;MyProject.c,89 :: 		}
	GOTO       L_automaticMode17
L_automaticMode18:
;MyProject.c,90 :: 		yellowWest = 1 ;
	BSF        PORTC+0, 1
;MyProject.c,91 :: 		greenWest = 0 ;
	BCF        PORTC+0, 2
;MyProject.c,92 :: 		counter = 3 ;
	MOVLW      3
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
;MyProject.c,93 :: 		while(counter >= 0)
L_automaticMode20:
	MOVLW      128
	XORWF      _counter+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__automaticMode49
	MOVLW      0
	SUBWF      _counter+0, 0
L__automaticMode49:
	BTFSS      STATUS+0, 0
	GOTO       L_automaticMode21
;MyProject.c,95 :: 		portb = display[counter-1];
	MOVLW      1
	SUBWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _counter+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,96 :: 		delay_ms(350);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      142
	MOVWF      R12+0
	MOVLW      18
	MOVWF      R13+0
L_automaticMode22:
	DECFSZ     R13+0, 1
	GOTO       L_automaticMode22
	DECFSZ     R12+0, 1
	GOTO       L_automaticMode22
	DECFSZ     R11+0, 1
	GOTO       L_automaticMode22
	NOP
;MyProject.c,97 :: 		counter--;
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;MyProject.c,98 :: 		}
	GOTO       L_automaticMode20
L_automaticMode21:
;MyProject.c,99 :: 		yellowWest = redSouth = 0 ;
	BCF        PORTC+0, 5
	BTFSC      PORTC+0, 5
	GOTO       L__automaticMode50
	BCF        PORTC+0, 1
	GOTO       L__automaticMode51
L__automaticMode50:
	BSF        PORTC+0, 1
L__automaticMode51:
;MyProject.c,100 :: 		redWest = greenSouth = 1 ;
	BSF        PORTC+0, 3
	BTFSC      PORTC+0, 3
	GOTO       L__automaticMode52
	BCF        PORTC+0, 0
	GOTO       L__automaticMode53
L__automaticMode52:
	BSF        PORTC+0, 0
L__automaticMode53:
;MyProject.c,101 :: 		}
L_automaticMode16:
;MyProject.c,102 :: 		manualAutoCheck();
	CALL       _manualAutoCheck+0
;MyProject.c,103 :: 		}
L_end_automaticMode:
	RETURN
; end of _automaticMode

_manualMode:

;MyProject.c,105 :: 		void manualMode()
;MyProject.c,107 :: 		westSeg = southSeg = 1 ;
	BSF        PORTD+0, 1
	BTFSC      PORTD+0, 1
	GOTO       L__manualMode55
	BCF        PORTD+0, 0
	GOTO       L__manualMode56
L__manualMode55:
	BSF        PORTD+0, 0
L__manualMode56:
;MyProject.c,108 :: 		if(greenSouth == 1)
	BTFSS      PORTC+0, 3
	GOTO       L_manualMode23
;MyProject.c,110 :: 		greenSouth = 0 ;
	BCF        PORTC+0, 3
;MyProject.c,111 :: 		yellowSouth = 1 ;
	BSF        PORTC+0, 4
;MyProject.c,112 :: 		counter = 3 ;
	MOVLW      3
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
;MyProject.c,113 :: 		while(counter>=0)
L_manualMode24:
	MOVLW      128
	XORWF      _counter+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manualMode57
	MOVLW      0
	SUBWF      _counter+0, 0
L__manualMode57:
	BTFSS      STATUS+0, 0
	GOTO       L_manualMode25
;MyProject.c,115 :: 		portb = display[counter-1];
	MOVLW      1
	SUBWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _counter+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,116 :: 		delay_ms(350);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      142
	MOVWF      R12+0
	MOVLW      18
	MOVWF      R13+0
L_manualMode26:
	DECFSZ     R13+0, 1
	GOTO       L_manualMode26
	DECFSZ     R12+0, 1
	GOTO       L_manualMode26
	DECFSZ     R11+0, 1
	GOTO       L_manualMode26
	NOP
;MyProject.c,117 :: 		counter--;
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;MyProject.c,118 :: 		}
	GOTO       L_manualMode24
L_manualMode25:
;MyProject.c,119 :: 		greenWest = redSouth = 1 ;
	BSF        PORTC+0, 5
	BTFSC      PORTC+0, 5
	GOTO       L__manualMode58
	BCF        PORTC+0, 2
	GOTO       L__manualMode59
L__manualMode58:
	BSF        PORTC+0, 2
L__manualMode59:
;MyProject.c,120 :: 		yellowSouth = redWest = 0 ;
	BCF        PORTC+0, 0
	BTFSC      PORTC+0, 0
	GOTO       L__manualMode60
	BCF        PORTC+0, 4
	GOTO       L__manualMode61
L__manualMode60:
	BSF        PORTC+0, 4
L__manualMode61:
;MyProject.c,121 :: 		}
	GOTO       L_manualMode27
L_manualMode23:
;MyProject.c,122 :: 		else if(manualFlag == 0)
	BTFSC      PORTA+0, 1
	GOTO       L_manualMode28
;MyProject.c,124 :: 		yellowWest = 1 ;
	BSF        PORTC+0, 1
;MyProject.c,125 :: 		greenWest = 0 ;
	BCF        PORTC+0, 2
;MyProject.c,126 :: 		counter = 3 ;
	MOVLW      3
	MOVWF      _counter+0
	MOVLW      0
	MOVWF      _counter+1
;MyProject.c,127 :: 		while(counter >= 0)
L_manualMode29:
	MOVLW      128
	XORWF      _counter+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__manualMode62
	MOVLW      0
	SUBWF      _counter+0, 0
L__manualMode62:
	BTFSS      STATUS+0, 0
	GOTO       L_manualMode30
;MyProject.c,129 :: 		portb = display[counter-1];
	MOVLW      1
	SUBWF      _counter+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _counter+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDLW      _display+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;MyProject.c,130 :: 		delay_ms(350);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      142
	MOVWF      R12+0
	MOVLW      18
	MOVWF      R13+0
L_manualMode31:
	DECFSZ     R13+0, 1
	GOTO       L_manualMode31
	DECFSZ     R12+0, 1
	GOTO       L_manualMode31
	DECFSZ     R11+0, 1
	GOTO       L_manualMode31
	NOP
;MyProject.c,131 :: 		counter--;
	MOVLW      1
	SUBWF      _counter+0, 1
	BTFSS      STATUS+0, 0
	DECF       _counter+1, 1
;MyProject.c,132 :: 		}
	GOTO       L_manualMode29
L_manualMode30:
;MyProject.c,133 :: 		yellowWest = redSouth = 0 ;
	BCF        PORTC+0, 5
	BTFSC      PORTC+0, 5
	GOTO       L__manualMode63
	BCF        PORTC+0, 1
	GOTO       L__manualMode64
L__manualMode63:
	BSF        PORTC+0, 1
L__manualMode64:
;MyProject.c,134 :: 		redWest = greenSouth = 1 ;
	BSF        PORTC+0, 3
	BTFSC      PORTC+0, 3
	GOTO       L__manualMode65
	BCF        PORTC+0, 0
	GOTO       L__manualMode66
L__manualMode65:
	BSF        PORTC+0, 0
L__manualMode66:
;MyProject.c,135 :: 		}
L_manualMode28:
L_manualMode27:
;MyProject.c,136 :: 		westSeg = southSeg = 0 ;
	BCF        PORTD+0, 1
	BTFSC      PORTD+0, 1
	GOTO       L__manualMode67
	BCF        PORTD+0, 0
	GOTO       L__manualMode68
L__manualMode67:
	BSF        PORTD+0, 0
L__manualMode68:
;MyProject.c,137 :: 		}
L_end_manualMode:
	RETURN
; end of _manualMode
