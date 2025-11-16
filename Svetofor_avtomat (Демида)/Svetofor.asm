
_out_str:
;Svetofor.c,23 :: 		void out_str()
;Svetofor.c,25 :: 		int i = 0;
	MOV out_str_i_L0+0, #0
	MOV out_str_i_L0+1, #0
;Svetofor.c,26 :: 		outcw(0x80);
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
;Svetofor.c,27 :: 		for (i; i < 16; ++i)
L_out_str0:
	CLR C
	MOV A, out_str_i_L0+0
	SUBB A, #16
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, out_str_i_L0+1
	XRL A, #128
	SUBB A, R0
	JNC L_out_str1
;Svetofor.c,28 :: 		outd(str[(i+pos >= 16) ? i+pos-16 : i+pos]);
	MOV A, _pos+0
	ADD A, out_str_i_L0+0
	MOV R1, A
	CLR A
	ADDC A, out_str_i_L0+1
	MOV R2, A
	CLR C
	MOV A, R1
	SUBB A, #16
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, R2
	XRL A, #128
	SUBB A, R0
	JC L_out_str3
	MOV A, _pos+0
	ADD A, out_str_i_L0+0
	MOV R0, A
	CLR A
	ADDC A, out_str_i_L0+1
	MOV R1, A
	CLR C
	MOV A, R0
	SUBB A, #16
	MOV R0, A
	MOV A, R1
	SUBB A, #0
	MOV R1, A
	MOV R2, 0
	MOV R3, 1
	SJMP L_out_str4
L_out_str3:
	MOV A, _pos+0
	ADD A, out_str_i_L0+0
	MOV R0, A
	CLR A
	ADDC A, out_str_i_L0+1
	MOV R1, A
	MOV R2, 0
	MOV R3, 1
L_out_str4:
	MOV A, #_str+0
	ADD A, R2
	MOV R0, A
	MOV FARG_outd_c+0, @R0
	LCALL _outd+0
;Svetofor.c,27 :: 		for (i; i < 16; ++i)
	MOV A, #1
	ADD A, out_str_i_L0+0
	MOV out_str_i_L0+0, A
	MOV A, #0
	ADDC A, out_str_i_L0+1
	MOV out_str_i_L0+1, A
;Svetofor.c,28 :: 		outd(str[(i+pos >= 16) ? i+pos-16 : i+pos]);
	LJMP L_out_str0
L_out_str1:
;Svetofor.c,29 :: 		}
	RET
; end of _out_str

_main:
	MOV SP+0, #128
;Svetofor.c,31 :: 		void main (void) {
;Svetofor.c,34 :: 		init();
	LCALL _init+0
;Svetofor.c,36 :: 		lcd_led = 0;  // Подсветка индикатора
	CLR P0_4_bit+0
;Svetofor.c,37 :: 		YEL = 1;
	SETB P0_1_bit+0
;Svetofor.c,38 :: 		RED = 0;
	CLR P0_0_bit+0
;Svetofor.c,39 :: 		GRN = 1;      // Зеленый цвет
	SETB P0_2_bit+0
;Svetofor.c,41 :: 		strcpy(str, red);
	MOV FARG_strcpy_to+0, #_str+0
	MOV FARG_strcpy_from+0, #_red+0
	LCALL _strcpy+0
;Svetofor.c,42 :: 		out_str();
	LCALL _out_str+0
;Svetofor.c,45 :: 		while (1) {
L_main5:
;Svetofor.c,46 :: 		key=ScanKbd();
	LCALL _ScanKbd+0
	MOV _key+0, 0
;Svetofor.c,47 :: 		switch (key) {
	SJMP L_main7
;Svetofor.c,48 :: 		case 1:
L_main9:
;Svetofor.c,49 :: 		TT = 100;
	MOV _TT+0, #100
;Svetofor.c,50 :: 		key = 0;
	MOV _key+0, #0
;Svetofor.c,51 :: 		break;
	SJMP L_main8
;Svetofor.c,52 :: 		case 2:
L_main10:
;Svetofor.c,53 :: 		TT = 150;
	MOV _TT+0, #150
;Svetofor.c,54 :: 		key = 0;
	MOV _key+0, #0
;Svetofor.c,55 :: 		break;
	SJMP L_main8
;Svetofor.c,56 :: 		case 3:
L_main11:
;Svetofor.c,57 :: 		TT = 200;
	MOV _TT+0, #200
;Svetofor.c,58 :: 		key = 0;
	MOV _key+0, #0
;Svetofor.c,59 :: 		break;
	SJMP L_main8
;Svetofor.c,60 :: 		}
L_main7:
	MOV A, _key+0
	XRL A, #1
	JZ L_main9
	MOV A, _key+0
	XRL A, #2
	JZ L_main10
	MOV A, _key+0
	XRL A, #3
	JZ L_main11
L_main8:
;Svetofor.c,62 :: 		switch (state) {
	LJMP L_main12
;Svetofor.c,63 :: 		case 0:
L_main14:
;Svetofor.c,64 :: 		if (kn == 1 & t == 0) {
	MOV A, _kn+0
	XRL A, #1
	JZ L__main30
	MOV R1, #0
	SJMP L__main31
L__main30:
	MOV R1, #1
L__main31:
	MOV A, _t+0
	XRL A, #0
	JZ L__main32
	MOV R0, #0
	SJMP L__main33
L__main32:
	MOV R0, #1
L__main33:
	MOV A, R1
	ANL 0, A
	MOV A, R0
	JZ L_main15
;Svetofor.c,65 :: 		state = 1;
	MOV _state+0, #1
;Svetofor.c,66 :: 		kn = 0;
	MOV _kn+0, #0
;Svetofor.c,67 :: 		t = 20;
	MOV _t+0, #20
;Svetofor.c,68 :: 		strcpy(str, yellow);
	MOV FARG_strcpy_to+0, #_str+0
	MOV FARG_strcpy_from+0, #_yellow+0
	LCALL _strcpy+0
;Svetofor.c,69 :: 		out_str();
	LCALL _out_str+0
;Svetofor.c,70 :: 		YEL = 0;
	CLR P0_1_bit+0
;Svetofor.c,71 :: 		}
L_main15:
;Svetofor.c,72 :: 		break;
	LJMP L_main13
;Svetofor.c,73 :: 		case 1:
L_main16:
;Svetofor.c,74 :: 		if (t == 0) {
	MOV A, _t+0
	JNZ L_main17
;Svetofor.c,75 :: 		state = 2;
	MOV _state+0, #2
;Svetofor.c,76 :: 		t = TT-30;
	CLR C
	MOV A, _TT+0
	SUBB A, #30
	MOV _t+0, A
;Svetofor.c,77 :: 		strcpy(str, "GREEN            ");
	MOV FARG_strcpy_to+0, #_str+0
	MOV FARG_strcpy_from+0, #?lstr1_Svetofor+0
	LCALL _strcpy+0
;Svetofor.c,78 :: 		out_str();
	LCALL _out_str+0
;Svetofor.c,79 :: 		RED = 1;
	SETB P0_0_bit+0
;Svetofor.c,80 :: 		YEL = 1;
	SETB P0_1_bit+0
;Svetofor.c,81 :: 		GRN = 0;
	CLR P0_2_bit+0
;Svetofor.c,82 :: 		}
L_main17:
;Svetofor.c,83 :: 		break;
	LJMP L_main13
;Svetofor.c,84 :: 		case 2:
L_main18:
;Svetofor.c,85 :: 		if (t == 0) {state = 3;t = 30;}
	MOV A, _t+0
	JNZ L_main19
	MOV _state+0, #3
	MOV _t+0, #30
L_main19:
;Svetofor.c,86 :: 		break;
	LJMP L_main13
;Svetofor.c,87 :: 		case 3:
L_main20:
;Svetofor.c,88 :: 		if (t % 5 == 0) {GRN = ~GRN; lcd_led = ~lcd_led;}
	MOV B+0, #5
	MOV A, _t+0
	DIV AB
	MOV A, B+0
	MOV R1, A
	JNZ L_main21
	MOV C, P0_2_bit+0
	CPL C
	MOV P0_2_bit+0, C
	MOV C, P0_4_bit+0
	CPL C
	MOV P0_4_bit+0, C
L_main21:
;Svetofor.c,89 :: 		if (t == 0) {
	MOV A, _t+0
	JNZ L_main22
;Svetofor.c,90 :: 		state = 4;
	MOV _state+0, #4
;Svetofor.c,91 :: 		t = 20;
	MOV _t+0, #20
;Svetofor.c,92 :: 		strcpy(str, yellow);
	MOV FARG_strcpy_to+0, #_str+0
	MOV FARG_strcpy_from+0, #_yellow+0
	LCALL _strcpy+0
;Svetofor.c,93 :: 		out_str();
	LCALL _out_str+0
;Svetofor.c,94 :: 		GRN = 1;
	SETB P0_2_bit+0
;Svetofor.c,95 :: 		YEL = 0;
	CLR P0_1_bit+0
;Svetofor.c,96 :: 		}
L_main22:
;Svetofor.c,97 :: 		break;
	SJMP L_main13
;Svetofor.c,98 :: 		case 4:
L_main23:
;Svetofor.c,99 :: 		if (t == 0) {
	MOV A, _t+0
	JNZ L_main24
;Svetofor.c,100 :: 		state = 0;
	MOV _state+0, #0
;Svetofor.c,101 :: 		t = TT;
	MOV _t+0, _TT+0
;Svetofor.c,102 :: 		YEL = 1;
	SETB P0_1_bit+0
;Svetofor.c,103 :: 		RED = 0;
	CLR P0_0_bit+0
;Svetofor.c,104 :: 		strcpy(str, red);
	MOV FARG_strcpy_to+0, #_str+0
	MOV FARG_strcpy_from+0, #_red+0
	LCALL _strcpy+0
;Svetofor.c,105 :: 		out_str();
	LCALL _out_str+0
;Svetofor.c,106 :: 		}
L_main24:
;Svetofor.c,107 :: 		break;
	SJMP L_main13
;Svetofor.c,108 :: 		}
L_main12:
	MOV A, _state+0
	JNZ #3
	LJMP L_main14
	MOV A, _state+0
	XRL A, #1
	JNZ #3
	LJMP L_main16
	MOV A, _state+0
	XRL A, #2
	JNZ #3
	LJMP L_main18
	MOV A, _state+0
	XRL A, #3
	JZ L_main20
	MOV A, _state+0
	XRL A, #4
	JZ L_main23
L_main13:
;Svetofor.c,109 :: 		if (t != 0) t--;
	MOV A, _t+0
	JZ L_main25
	DEC _t+0
L_main25:
;Svetofor.c,110 :: 		DelayMs(100);            // такт работы автомата
	MOV FARG_DelayMs_m+0, #100
	MOV FARG_DelayMs_m+1, #0
	LCALL _DelayMs+0
;Svetofor.c,111 :: 		}
	LJMP L_main5
;Svetofor.c,112 :: 		}
	SJMP #254
; end of _main

_DelayMs:
;Svetofor.c,114 :: 		void DelayMs(unsigned int m){  // задержка по таймеру
;Svetofor.c,115 :: 		ms=0;
	MOV _ms+0, #0
	MOV _ms+1, #0
;Svetofor.c,116 :: 		WMCON.WDTRST=1; // сброс сторожевого таймера
	SETB C
	MOV A, WMCON+0
	MOV #224, C
	MOV WMCON+0, A
;Svetofor.c,117 :: 		while(ms!=m) continue;
L_DelayMs26:
	MOV A, _ms+0
	XRL A, FARG_DelayMs_m+0
	JNZ L__DelayMs34
	MOV A, _ms+1
	XRL A, FARG_DelayMs_m+1
L__DelayMs34:
	JZ L_DelayMs27
	SJMP L_DelayMs26
L_DelayMs27:
;Svetofor.c,118 :: 		}
	RET
; end of _DelayMs

_Timer1InterruptHandler:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;Svetofor.c,120 :: 		void Timer1InterruptHandler() org IVT_ADDR_ET1{
;Svetofor.c,122 :: 		EA_bit = 0;        // Clear global interrupt enable flag
	CLR EA_bit+0
;Svetofor.c,123 :: 		TF1_bit = 0;       // Ensure that Timer1 interrupt flag is cleared
	CLR TF1_bit+0
;Svetofor.c,125 :: 		TR1_bit = 0;       // Stop Timer1
	CLR TR1_bit+0
;Svetofor.c,126 :: 		TH1 = 0xFC;        // Reset Timer1 high byte  65536-1000
	MOV TH1+0, #252
;Svetofor.c,127 :: 		TL1 = 0x18;        // Reset Timer1 low byte
	MOV TL1+0, #24
;Svetofor.c,129 :: 		ms++;
	MOV A, #1
	ADD A, _ms+0
	MOV _ms+0, A
	MOV A, #0
	ADDC A, _ms+1
	MOV _ms+1, A
;Svetofor.c,131 :: 		EA_bit = 1;        // Set global interrupt enable flag
	SETB EA_bit+0
;Svetofor.c,132 :: 		TR1_bit = 1;       // Run Timer1
	SETB TR1_bit+0
;Svetofor.c,133 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _Timer1InterruptHandler

_INT0_Interrupt:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;Svetofor.c,135 :: 		void INT0_Interrupt() org IVT_ADDR_EX0 {
;Svetofor.c,136 :: 		if (state == 0) kn = 1;
	MOV A, _state+0
	JNZ L_INT0_Interrupt28
	MOV _kn+0, #1
L_INT0_Interrupt28:
;Svetofor.c,137 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _INT0_Interrupt

_INT1_Interrupt:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;Svetofor.c,140 :: 		void INT1_Interrupt() org IVT_ADDR_EX1 {
;Svetofor.c,141 :: 		if (state == 0) kn = 1;
	MOV A, _state+0
	JNZ L_INT1_Interrupt29
	MOV _kn+0, #1
L_INT1_Interrupt29:
;Svetofor.c,142 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _INT1_Interrupt
