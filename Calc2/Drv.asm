
_init:
;Drv.c,5 :: 		void init(void){
;Drv.c,9 :: 		WMCON = 0b11111001;  // Enable WatchDog Timer, set prescaller bits to 111
	MOV WMCON+0, #249
;Drv.c,12 :: 		WMCON|=0x08;  // internal EEPROM enable
	ORL WMCON+0, #8
;Drv.c,13 :: 		WMCON&=0xfb;  // DPTR = DP0
	ANL WMCON+0, #251
;Drv.c,16 :: 		PCON |= 0x80;        // SMOD=1
	ORL PCON+0, #128
;Drv.c,17 :: 		SCON = 0x72;        // mode 1, receiver enable
	MOV SCON+0, #114
;Drv.c,18 :: 		TMOD = 0x22;        //Timers 0&1 are 8-bit timers with auto-reload
	MOV TMOD+0, #34
;Drv.c,19 :: 		TH1   = 0xF5;        // 9600 baud at 20 MHz
	MOV TH1+0, #245
;Drv.c,20 :: 		ES_bit = 0;
	CLR ES_bit+0
;Drv.c,23 :: 		TF1_bit = 0;       // Ensure that Timer1 interrupt flag is cleared
	CLR TF1_bit+0
;Drv.c,24 :: 		ET1_bit = 1;       // Enable Timer1 interrupt
	SETB ET1_bit+0
;Drv.c,25 :: 		EA_bit  = 1;       // Set global interrupt enable
	SETB EA_bit+0
;Drv.c,27 :: 		GATE1_bit = 0;     // Clear this flag to enable Timer1 whenever TR1 bit is set.
	CLR C
	MOV A, GATE1_bit+0
	MOV #224, C
	MOV GATE1_bit+0, A
;Drv.c,28 :: 		C_T1_bit  = 0;     // Set Timer operation: Timer1 counts the divided-down systam clock.
	CLR C
	MOV A, C_T1_bit+0
	MOV #224, C
	MOV C_T1_bit+0, A
;Drv.c,29 :: 		M11_bit   = 0;     // M11_M01 = 01    =>   Mode 1(16-bit Timer/Counter)
	CLR C
	MOV A, M11_bit+0
	MOV #224, C
	MOV M11_bit+0, A
;Drv.c,30 :: 		M01_bit   = 1;
	SETB C
	MOV A, M01_bit+0
	MOV #224, C
	MOV M01_bit+0, A
;Drv.c,32 :: 		TR1_bit = 0;       // Turn off Timer1
	CLR TR1_bit+0
;Drv.c,33 :: 		TH1 = 0xFC;        // Reset Timer1 high byte  65536-1000
	MOV TH1+0, #252
;Drv.c,34 :: 		TL1 = 0x18;        // Reset Timer1 low byte
	MOV TL1+0, #24
;Drv.c,35 :: 		TR1_bit = 1;       // Run Timer1
	SETB TR1_bit+0
;Drv.c,39 :: 		P3=0xff;
	MOV P3+0, #255
;Drv.c,40 :: 		EX0_bit = 1;
	SETB EX0_bit+0
;Drv.c,41 :: 		EX1_bit = 1;
	SETB EX1_bit+0
;Drv.c,44 :: 		DelayMs(30);
	MOV FARG_DelayMs_m+0, #30
	MOV FARG_DelayMs_m+1, #0
	LCALL _DelayMs+0
;Drv.c,45 :: 		RW = 0;
	CLR C
	MOV A, P3_5_bit+0
	MOV #224, C
	MOV P3_5_bit+0, A
;Drv.c,46 :: 		outcw(0x3C);
	MOV FARG_outcw_c+0, #60
	LCALL _outcw+0
;Drv.c,47 :: 		outcw(0x0C);
	MOV FARG_outcw_c+0, #12
	LCALL _outcw+0
;Drv.c,48 :: 		outcw(0x01);
	MOV FARG_outcw_c+0, #1
	LCALL _outcw+0
;Drv.c,49 :: 		outcw(0x06);
	MOV FARG_outcw_c+0, #6
	LCALL _outcw+0
;Drv.c,50 :: 		outcw(0x40);
	MOV FARG_outcw_c+0, #64
	LCALL _outcw+0
;Drv.c,51 :: 		for(i=0;i<8;i++) outd(0);
	MOV init_i_L0+0, #0
L_init0:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init1
	MOV FARG_outd_c+0, #0
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init0
L_init1:
;Drv.c,52 :: 		for(i=0;i<8;i++) outd(0x10);
	MOV init_i_L0+0, #0
L_init3:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init4
	MOV FARG_outd_c+0, #16
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init3
L_init4:
;Drv.c,53 :: 		for(i=0;i<8;i++) outd(0x18);
	MOV init_i_L0+0, #0
L_init6:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init7
	MOV FARG_outd_c+0, #24
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init6
L_init7:
;Drv.c,54 :: 		for(i=0;i<8;i++) outd(0x1C);
	MOV init_i_L0+0, #0
L_init9:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init10
	MOV FARG_outd_c+0, #28
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init9
L_init10:
;Drv.c,55 :: 		for(i=0;i<8;i++) outd(0x1E);
	MOV init_i_L0+0, #0
L_init12:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init13
	MOV FARG_outd_c+0, #30
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init12
L_init13:
;Drv.c,56 :: 		for(i=0;i<8;i++) outd(0x1F);
	MOV init_i_L0+0, #0
L_init15:
	CLR C
	MOV A, init_i_L0+0
	SUBB A, #8
	JNC L_init16
	MOV FARG_outd_c+0, #31
	LCALL _outd+0
	INC init_i_L0+0
	SJMP L_init15
L_init16:
;Drv.c,57 :: 		}
	RET
; end of _init

_ScanKbd:
;Drv.c,59 :: 		unsigned char ScanKbd(void) {
;Drv.c,61 :: 		unsigned char kp = 0;
	MOV ScanKbd_kp_L0+0, #0
;Drv.c,63 :: 		P0 = P0&0x1F|0xC0;    //столбец 1
	MOV A, P0+0
	ANL A, #31
	MOV R0, A
	ORL A, #192
	MOV P0+0, A
;Drv.c,64 :: 		for(i=0;i<10;i++);
	MOV ScanKbd_i_L0+0, #0
L_ScanKbd18:
	CLR C
	MOV A, ScanKbd_i_L0+0
	SUBB A, #10
	JNC L_ScanKbd19
	INC ScanKbd_i_L0+0
	SJMP L_ScanKbd18
L_ScanKbd19:
;Drv.c,65 :: 		if (!P1_0_bit) kp = 1;
	JB P1_0_bit+0, L_ScanKbd21
	NOP
	MOV ScanKbd_kp_L0+0, #1
	SJMP L_ScanKbd22
L_ScanKbd21:
;Drv.c,66 :: 		else if (!P1_1_bit) kp = 2;
	JB P1_1_bit+0, L_ScanKbd23
	NOP
	MOV ScanKbd_kp_L0+0, #2
	SJMP L_ScanKbd24
L_ScanKbd23:
;Drv.c,67 :: 		else if (!P1_2_bit) kp = 3;
	JB P1_2_bit+0, L_ScanKbd25
	NOP
	MOV ScanKbd_kp_L0+0, #3
	SJMP L_ScanKbd26
L_ScanKbd25:
;Drv.c,68 :: 		else if (!P1_3_bit) kp = 4;
	JB P1_3_bit+0, L_ScanKbd27
	NOP
	MOV ScanKbd_kp_L0+0, #4
L_ScanKbd27:
L_ScanKbd26:
L_ScanKbd24:
L_ScanKbd22:
;Drv.c,70 :: 		P0 = P0&0x1F|0xA0;    //столбец 2
	MOV A, P0+0
	ANL A, #31
	MOV R0, A
	ORL A, #160
	MOV P0+0, A
;Drv.c,71 :: 		for(i=0;i<10;i++);
	MOV ScanKbd_i_L0+0, #0
L_ScanKbd28:
	CLR C
	MOV A, ScanKbd_i_L0+0
	SUBB A, #10
	JNC L_ScanKbd29
	INC ScanKbd_i_L0+0
	SJMP L_ScanKbd28
L_ScanKbd29:
;Drv.c,72 :: 		if (!P1_0_bit) kp = 2;
	JB P1_0_bit+0, L_ScanKbd31
	NOP
	MOV ScanKbd_kp_L0+0, #2
	SJMP L_ScanKbd32
L_ScanKbd31:
;Drv.c,73 :: 		else if (!P1_1_bit) kp = '5';
	JB P1_1_bit+0, L_ScanKbd33
	NOP
	MOV ScanKbd_kp_L0+0, #53
	SJMP L_ScanKbd34
L_ScanKbd33:
;Drv.c,74 :: 		else if (!P1_2_bit) kp = '2';
	JB P1_2_bit+0, L_ScanKbd35
	NOP
	MOV ScanKbd_kp_L0+0, #50
	SJMP L_ScanKbd36
L_ScanKbd35:
;Drv.c,75 :: 		else if (!P1_3_bit) kp = '0';
	JB P1_3_bit+0, L_ScanKbd37
	NOP
	MOV ScanKbd_kp_L0+0, #48
L_ScanKbd37:
L_ScanKbd36:
L_ScanKbd34:
L_ScanKbd32:
;Drv.c,77 :: 		P0 = P0&0x1F|0x60;    //столбец 3
	MOV A, P0+0
	ANL A, #31
	MOV R0, A
	ORL A, #96
	MOV P0+0, A
;Drv.c,78 :: 		for(i=0;i<10;i++);
	MOV ScanKbd_i_L0+0, #0
L_ScanKbd38:
	CLR C
	MOV A, ScanKbd_i_L0+0
	SUBB A, #10
	JNC L_ScanKbd39
	INC ScanKbd_i_L0+0
	SJMP L_ScanKbd38
L_ScanKbd39:
;Drv.c,79 :: 		if (!P1_0_bit) kp = 3;
	JB P1_0_bit+0, L_ScanKbd41
	NOP
	MOV ScanKbd_kp_L0+0, #3
	SJMP L_ScanKbd42
L_ScanKbd41:
;Drv.c,80 :: 		else if (!P1_1_bit) kp = '6';
	JB P1_1_bit+0, L_ScanKbd43
	NOP
	MOV ScanKbd_kp_L0+0, #54
	SJMP L_ScanKbd44
L_ScanKbd43:
;Drv.c,81 :: 		else if (!P1_2_bit) kp = '3';
	JB P1_2_bit+0, L_ScanKbd45
	NOP
	MOV ScanKbd_kp_L0+0, #51
	SJMP L_ScanKbd46
L_ScanKbd45:
;Drv.c,82 :: 		else if (!P1_3_bit) kp = 13;
	JB P1_3_bit+0, L_ScanKbd47
	NOP
	MOV ScanKbd_kp_L0+0, #13
L_ScanKbd47:
L_ScanKbd46:
L_ScanKbd44:
L_ScanKbd42:
;Drv.c,83 :: 		return kp;
	MOV R0, ScanKbd_kp_L0+0
;Drv.c,84 :: 		}
	RET
; end of _ScanKbd

_clear_lcd:
;Drv.c,86 :: 		void clear_lcd(void){
;Drv.c,88 :: 		outcw(0x80);
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
;Drv.c,89 :: 		for(i=0;i<16;i++)
	MOV clear_lcd_i_L0+0, #0
L_clear_lcd48:
	CLR C
	MOV A, clear_lcd_i_L0+0
	SUBB A, #16
	JNC L_clear_lcd49
;Drv.c,90 :: 		outd(' ');
	MOV FARG_outd_c+0, #32
	LCALL _outd+0
;Drv.c,89 :: 		for(i=0;i<16;i++)
	INC clear_lcd_i_L0+0
;Drv.c,90 :: 		outd(' ');
	SJMP L_clear_lcd48
L_clear_lcd49:
;Drv.c,91 :: 		}
	RET
; end of _clear_lcd

_outcw:
;Drv.c,93 :: 		void outcw(unsigned char c){
;Drv.c,96 :: 		RS = 0;
	CLR C
	MOV A, P3_6_bit+0
	MOV #224, C
	MOV P3_6_bit+0, A
;Drv.c,97 :: 		DB = c;
	MOV P2+0, FARG_outcw_c+0
;Drv.c,98 :: 		E = 1;
	SETB C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,99 :: 		E = 2;
	CLR C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,100 :: 		for (i=0; i<20; i++);
	MOV outcw_i_L0+0, #0
L_outcw51:
	CLR C
	MOV A, outcw_i_L0+0
	SUBB A, #20
	JNC L_outcw52
	INC outcw_i_L0+0
	SJMP L_outcw51
L_outcw52:
;Drv.c,101 :: 		if (c==1||c==2||c==3)
	MOV A, FARG_outcw_c+0
	XRL A, #1
	JZ L__outcw63
	MOV A, FARG_outcw_c+0
	XRL A, #2
	JZ L__outcw63
	MOV A, FARG_outcw_c+0
	XRL A, #3
	JZ L__outcw63
	SJMP L_outcw56
L__outcw63:
;Drv.c,102 :: 		for (j=0; j<500; j++);
	MOV outcw_j_L0+0, #0
	MOV outcw_j_L0+1, #0
L_outcw57:
	CLR C
	MOV A, outcw_j_L0+0
	SUBB A, #244
	MOV A, outcw_j_L0+1
	SUBB A, #1
	JNC L_outcw58
	MOV A, #1
	ADD A, outcw_j_L0+0
	MOV outcw_j_L0+0, A
	MOV A, #0
	ADDC A, outcw_j_L0+1
	MOV outcw_j_L0+1, A
	SJMP L_outcw57
L_outcw58:
L_outcw56:
;Drv.c,103 :: 		}
	RET
; end of _outcw

_outd:
;Drv.c,105 :: 		void outd(unsigned char c){
;Drv.c,107 :: 		RS = 1;
	SETB C
	MOV A, P3_6_bit+0
	MOV #224, C
	MOV P3_6_bit+0, A
;Drv.c,108 :: 		DB = c;
	MOV P2+0, FARG_outd_c+0
;Drv.c,109 :: 		E = 1;
	SETB C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,110 :: 		E = 2;
	CLR C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,111 :: 		for (i=0; i<21; i++);
	MOV outd_i_L0+0, #0
L_outd60:
	CLR C
	MOV A, outd_i_L0+0
	SUBB A, #21
	JNC L_outd61
	INC outd_i_L0+0
	SJMP L_outd60
L_outd61:
;Drv.c,112 :: 		}
	RET
; end of _outd
