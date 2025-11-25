
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
L_ScanKbd21:
;Drv.c,70 :: 		P0 = P0&0x1F|0xA0;    //столбец 2
	MOV A, P0+0
	ANL A, #31
	MOV R0, A
	ORL A, #160
	MOV P0+0, A
;Drv.c,71 :: 		for(i=0;i<10;i++);
	MOV ScanKbd_i_L0+0, #0
L_ScanKbd22:
	CLR C
	MOV A, ScanKbd_i_L0+0
	SUBB A, #10
	JNC L_ScanKbd23
	INC ScanKbd_i_L0+0
	SJMP L_ScanKbd22
L_ScanKbd23:
;Drv.c,72 :: 		if (!P1_0_bit) kp = 2;
	JB P1_0_bit+0, L_ScanKbd25
	NOP
	MOV ScanKbd_kp_L0+0, #2
L_ScanKbd25:
;Drv.c,77 :: 		P0 = P0&0x1F|0x60;    //столбец 3
	MOV A, P0+0
	ANL A, #31
	MOV R0, A
	ORL A, #96
	MOV P0+0, A
;Drv.c,78 :: 		for(i=0;i<10;i++);
	MOV ScanKbd_i_L0+0, #0
L_ScanKbd26:
	CLR C
	MOV A, ScanKbd_i_L0+0
	SUBB A, #10
	JNC L_ScanKbd27
	INC ScanKbd_i_L0+0
	SJMP L_ScanKbd26
L_ScanKbd27:
;Drv.c,79 :: 		if (!P1_0_bit) kp = 3;
	JB P1_0_bit+0, L_ScanKbd29
	NOP
	MOV ScanKbd_kp_L0+0, #3
L_ScanKbd29:
;Drv.c,83 :: 		return kp;
	MOV R0, ScanKbd_kp_L0+0
;Drv.c,84 :: 		}
	RET
; end of _ScanKbd

_translate:
;Drv.c,87 :: 		unsigned char translate(unsigned char c){
;Drv.c,88 :: 		switch (c){
	LJMP L_translate30
;Drv.c,89 :: 		case 'А': return 'A';
L_translate32:
	MOV R0, #65
	RET
;Drv.c,90 :: 		case 'Б': return 0xA0;
L_translate33:
	MOV R0, #160
	RET
;Drv.c,91 :: 		case 'В': return 'B';
L_translate34:
	MOV R0, #66
	RET
;Drv.c,92 :: 		case 'Г': return 0xA1;
L_translate35:
	MOV R0, #161
	RET
;Drv.c,93 :: 		case 'Д': return 0xE0;
L_translate36:
	MOV R0, #224
	RET
;Drv.c,94 :: 		case 'Е': return 'E';
L_translate37:
	MOV R0, #69
	RET
;Drv.c,95 :: 		case 'Ё': return 0xA2;
L_translate38:
	MOV R0, #162
	RET
;Drv.c,96 :: 		case 'Ж': return 0xA3;
L_translate39:
	MOV R0, #163
	RET
;Drv.c,97 :: 		case 'З': return 0xA4;
L_translate40:
	MOV R0, #164
	RET
;Drv.c,98 :: 		case 'И': return 0xA5;
L_translate41:
	MOV R0, #165
	RET
;Drv.c,99 :: 		case 'Й': return 0xA6;
L_translate42:
	MOV R0, #166
	RET
;Drv.c,100 :: 		case 'К': return 'K';
L_translate43:
	MOV R0, #75
	RET
;Drv.c,101 :: 		case 'Л': return 0xA7;
L_translate44:
	MOV R0, #167
	RET
;Drv.c,102 :: 		case 'М': return 'M';
L_translate45:
	MOV R0, #77
	RET
;Drv.c,103 :: 		case 'Н': return 'H';
L_translate46:
	MOV R0, #72
	RET
;Drv.c,104 :: 		case 'О': return 'O';
L_translate47:
	MOV R0, #79
	RET
;Drv.c,105 :: 		case 'П': return 0xA8;
L_translate48:
	MOV R0, #168
	RET
;Drv.c,106 :: 		case 'Р': return 'P';
L_translate49:
	MOV R0, #80
	RET
;Drv.c,107 :: 		case 'С': return 'C';
L_translate50:
	MOV R0, #67
	RET
;Drv.c,108 :: 		case 'Т': return 'T';
L_translate51:
	MOV R0, #84
	RET
;Drv.c,109 :: 		case 'У': return 0xA9;
L_translate52:
	MOV R0, #169
	RET
;Drv.c,110 :: 		case 'Ф': return 0xAA;
L_translate53:
	MOV R0, #170
	RET
;Drv.c,111 :: 		case 'Х': return 'X';
L_translate54:
	MOV R0, #88
	RET
;Drv.c,112 :: 		case 'Ц': return 0xE1;
L_translate55:
	MOV R0, #225
	RET
;Drv.c,113 :: 		case 'Ч': return 0xAB;
L_translate56:
	MOV R0, #171
	RET
;Drv.c,114 :: 		case 'Ш': return 0xAC;
L_translate57:
	MOV R0, #172
	RET
;Drv.c,115 :: 		case 'Щ': return 0xE2;
L_translate58:
	MOV R0, #226
	RET
;Drv.c,116 :: 		case 'Ъ': return 0xAD;
L_translate59:
	MOV R0, #173
	RET
;Drv.c,117 :: 		case 'Ы': return 0xAE;
L_translate60:
	MOV R0, #174
	RET
;Drv.c,118 :: 		case 'Ь': return 'b';
L_translate61:
	MOV R0, #98
	RET
;Drv.c,119 :: 		case 'Э': return 0xAF;
L_translate62:
	MOV R0, #175
	RET
;Drv.c,120 :: 		case 'Ю': return 0xB0;
L_translate63:
	MOV R0, #176
	RET
;Drv.c,121 :: 		case 'Я': return 0xB1;
L_translate64:
	MOV R0, #177
	RET
;Drv.c,122 :: 		case 'а': return 'a';
L_translate65:
	MOV R0, #97
	RET
;Drv.c,123 :: 		case 'б': return 0xB2;
L_translate66:
	MOV R0, #178
	RET
;Drv.c,124 :: 		case 'в': return 0xB3;
L_translate67:
	MOV R0, #179
	RET
;Drv.c,125 :: 		case 'г': return 0xB4;
L_translate68:
	MOV R0, #180
	RET
;Drv.c,126 :: 		case 'д': return 0xE3;
L_translate69:
	MOV R0, #227
	RET
;Drv.c,127 :: 		case 'е': return 'e';
L_translate70:
	MOV R0, #101
	RET
;Drv.c,128 :: 		case 'ё': return 0xB5;
L_translate71:
	MOV R0, #181
	RET
;Drv.c,129 :: 		case 'ж': return 0xB6;
L_translate72:
	MOV R0, #182
	RET
;Drv.c,130 :: 		case 'з': return 0xB7;
L_translate73:
	MOV R0, #183
	RET
;Drv.c,131 :: 		case 'и': return 0xB8;
L_translate74:
	MOV R0, #184
	RET
;Drv.c,132 :: 		case 'й': return 0xB9;
L_translate75:
	MOV R0, #185
	RET
;Drv.c,133 :: 		case 'к': return 0xBA;
L_translate76:
	MOV R0, #186
	RET
;Drv.c,134 :: 		case 'л': return 0xBB;
L_translate77:
	MOV R0, #187
	RET
;Drv.c,135 :: 		case 'м': return 0xBC;
L_translate78:
	MOV R0, #188
	RET
;Drv.c,136 :: 		case 'н': return 0xBD;
L_translate79:
	MOV R0, #189
	RET
;Drv.c,137 :: 		case 'о': return 'o';
L_translate80:
	MOV R0, #111
	RET
;Drv.c,138 :: 		case 'п': return 0xBE;
L_translate81:
	MOV R0, #190
	RET
;Drv.c,139 :: 		case 'р': return 'p';
L_translate82:
	MOV R0, #112
	RET
;Drv.c,140 :: 		case 'с': return 'c';
L_translate83:
	MOV R0, #99
	RET
;Drv.c,141 :: 		case 'т': return 0xBF;
L_translate84:
	MOV R0, #191
	RET
;Drv.c,142 :: 		case 'у': return 'y';
L_translate85:
	MOV R0, #121
	RET
;Drv.c,143 :: 		case 'ф': return 0xE4;
L_translate86:
	MOV R0, #228
	RET
;Drv.c,144 :: 		case 'х': return 'x';
L_translate87:
	MOV R0, #120
	RET
;Drv.c,145 :: 		case 'ц': return 0xE5;
L_translate88:
	MOV R0, #229
	RET
;Drv.c,146 :: 		case 'ч': return 0xC0;
L_translate89:
	MOV R0, #192
	RET
;Drv.c,147 :: 		case 'ш': return 0xC1;
L_translate90:
	MOV R0, #193
	RET
;Drv.c,148 :: 		case 'щ': return 0xE6;
L_translate91:
	MOV R0, #230
	RET
;Drv.c,149 :: 		case 'ъ': return 0xC2;
L_translate92:
	MOV R0, #194
	RET
;Drv.c,150 :: 		case 'ы': return 0xC3;
L_translate93:
	MOV R0, #195
	RET
;Drv.c,151 :: 		case 'ь': return 0xC4;
L_translate94:
	MOV R0, #196
	RET
;Drv.c,152 :: 		case 'э': return 0xC5;
L_translate95:
	MOV R0, #197
	RET
;Drv.c,153 :: 		case 'ю': return 0xC6;
L_translate96:
	MOV R0, #198
	RET
;Drv.c,154 :: 		case 'я': return 0xC7;
L_translate97:
	MOV R0, #199
	RET
;Drv.c,155 :: 		default: return c;
L_translate98:
	MOV R0, FARG_translate_c+0
	RET
;Drv.c,156 :: 		}
L_translate30:
	MOV A, FARG_translate_c+0
	XRL A, #192
	JNZ #3
	LJMP L_translate32
	MOV A, FARG_translate_c+0
	XRL A, #193
	JNZ #3
	LJMP L_translate33
	MOV A, FARG_translate_c+0
	XRL A, #194
	JNZ #3
	LJMP L_translate34
	MOV A, FARG_translate_c+0
	XRL A, #195
	JNZ #3
	LJMP L_translate35
	MOV A, FARG_translate_c+0
	XRL A, #196
	JNZ #3
	LJMP L_translate36
	MOV A, FARG_translate_c+0
	XRL A, #197
	JNZ #3
	LJMP L_translate37
	MOV A, FARG_translate_c+0
	XRL A, #168
	JNZ #3
	LJMP L_translate38
	MOV A, FARG_translate_c+0
	XRL A, #198
	JNZ #3
	LJMP L_translate39
	MOV A, FARG_translate_c+0
	XRL A, #199
	JNZ #3
	LJMP L_translate40
	MOV A, FARG_translate_c+0
	XRL A, #200
	JNZ #3
	LJMP L_translate41
	MOV A, FARG_translate_c+0
	XRL A, #201
	JNZ #3
	LJMP L_translate42
	MOV A, FARG_translate_c+0
	XRL A, #202
	JNZ #3
	LJMP L_translate43
	MOV A, FARG_translate_c+0
	XRL A, #203
	JNZ #3
	LJMP L_translate44
	MOV A, FARG_translate_c+0
	XRL A, #204
	JNZ #3
	LJMP L_translate45
	MOV A, FARG_translate_c+0
	XRL A, #205
	JNZ #3
	LJMP L_translate46
	MOV A, FARG_translate_c+0
	XRL A, #206
	JNZ #3
	LJMP L_translate47
	MOV A, FARG_translate_c+0
	XRL A, #207
	JNZ #3
	LJMP L_translate48
	MOV A, FARG_translate_c+0
	XRL A, #208
	JNZ #3
	LJMP L_translate49
	MOV A, FARG_translate_c+0
	XRL A, #209
	JNZ #3
	LJMP L_translate50
	MOV A, FARG_translate_c+0
	XRL A, #210
	JNZ #3
	LJMP L_translate51
	MOV A, FARG_translate_c+0
	XRL A, #211
	JNZ #3
	LJMP L_translate52
	MOV A, FARG_translate_c+0
	XRL A, #212
	JNZ #3
	LJMP L_translate53
	MOV A, FARG_translate_c+0
	XRL A, #213
	JNZ #3
	LJMP L_translate54
	MOV A, FARG_translate_c+0
	XRL A, #214
	JNZ #3
	LJMP L_translate55
	MOV A, FARG_translate_c+0
	XRL A, #215
	JNZ #3
	LJMP L_translate56
	MOV A, FARG_translate_c+0
	XRL A, #216
	JNZ #3
	LJMP L_translate57
	MOV A, FARG_translate_c+0
	XRL A, #217
	JNZ #3
	LJMP L_translate58
	MOV A, FARG_translate_c+0
	XRL A, #218
	JNZ #3
	LJMP L_translate59
	MOV A, FARG_translate_c+0
	XRL A, #219
	JNZ #3
	LJMP L_translate60
	MOV A, FARG_translate_c+0
	XRL A, #220
	JNZ #3
	LJMP L_translate61
	MOV A, FARG_translate_c+0
	XRL A, #221
	JNZ #3
	LJMP L_translate62
	MOV A, FARG_translate_c+0
	XRL A, #222
	JNZ #3
	LJMP L_translate63
	MOV A, FARG_translate_c+0
	XRL A, #223
	JNZ #3
	LJMP L_translate64
	MOV A, FARG_translate_c+0
	XRL A, #224
	JNZ #3
	LJMP L_translate65
	MOV A, FARG_translate_c+0
	XRL A, #225
	JNZ #3
	LJMP L_translate66
	MOV A, FARG_translate_c+0
	XRL A, #226
	JNZ #3
	LJMP L_translate67
	MOV A, FARG_translate_c+0
	XRL A, #227
	JNZ #3
	LJMP L_translate68
	MOV A, FARG_translate_c+0
	XRL A, #228
	JNZ #3
	LJMP L_translate69
	MOV A, FARG_translate_c+0
	XRL A, #229
	JNZ #3
	LJMP L_translate70
	MOV A, FARG_translate_c+0
	XRL A, #184
	JNZ #3
	LJMP L_translate71
	MOV A, FARG_translate_c+0
	XRL A, #230
	JNZ #3
	LJMP L_translate72
	MOV A, FARG_translate_c+0
	XRL A, #231
	JNZ #3
	LJMP L_translate73
	MOV A, FARG_translate_c+0
	XRL A, #232
	JNZ #3
	LJMP L_translate74
	MOV A, FARG_translate_c+0
	XRL A, #233
	JNZ #3
	LJMP L_translate75
	MOV A, FARG_translate_c+0
	XRL A, #234
	JNZ #3
	LJMP L_translate76
	MOV A, FARG_translate_c+0
	XRL A, #235
	JNZ #3
	LJMP L_translate77
	MOV A, FARG_translate_c+0
	XRL A, #236
	JNZ #3
	LJMP L_translate78
	MOV A, FARG_translate_c+0
	XRL A, #237
	JNZ #3
	LJMP L_translate79
	MOV A, FARG_translate_c+0
	XRL A, #238
	JNZ #3
	LJMP L_translate80
	MOV A, FARG_translate_c+0
	XRL A, #239
	JNZ #3
	LJMP L_translate81
	MOV A, FARG_translate_c+0
	XRL A, #240
	JNZ #3
	LJMP L_translate82
	MOV A, FARG_translate_c+0
	XRL A, #241
	JNZ #3
	LJMP L_translate83
	MOV A, FARG_translate_c+0
	XRL A, #242
	JNZ #3
	LJMP L_translate84
	MOV A, FARG_translate_c+0
	XRL A, #243
	JNZ #3
	LJMP L_translate85
	MOV A, FARG_translate_c+0
	XRL A, #244
	JNZ #3
	LJMP L_translate86
	MOV A, FARG_translate_c+0
	XRL A, #245
	JNZ #3
	LJMP L_translate87
	MOV A, FARG_translate_c+0
	XRL A, #246
	JNZ #3
	LJMP L_translate88
	MOV A, FARG_translate_c+0
	XRL A, #247
	JNZ #3
	LJMP L_translate89
	MOV A, FARG_translate_c+0
	XRL A, #248
	JNZ #3
	LJMP L_translate90
	MOV A, FARG_translate_c+0
	XRL A, #249
	JNZ #3
	LJMP L_translate91
	MOV A, FARG_translate_c+0
	XRL A, #250
	JNZ #3
	LJMP L_translate92
	MOV A, FARG_translate_c+0
	XRL A, #251
	JNZ #3
	LJMP L_translate93
	MOV A, FARG_translate_c+0
	XRL A, #252
	JNZ #3
	LJMP L_translate94
	MOV A, FARG_translate_c+0
	XRL A, #253
	JNZ #3
	LJMP L_translate95
	MOV A, FARG_translate_c+0
	XRL A, #254
	JNZ #3
	LJMP L_translate96
	MOV A, FARG_translate_c+0
	XRL A, #255
	JNZ #3
	LJMP L_translate97
	LJMP L_translate98
;Drv.c,157 :: 		}
	RET
; end of _translate

_wr_EEPROM:
;Drv.c,159 :: 		void wr_EEPROM(unsigned int addr,unsigned char eedata)
;Drv.c,162 :: 		DP0L=addr;  //addr1.byte_.l_byte;
	MOV DP0L+0, FARG_wr_EEPROM_addr+0
;Drv.c,163 :: 		DP0H=addr>>8;
	MOV R0, FARG_wr_EEPROM_addr+1
	MOV R1, #0
	MOV DP0H+0, 0
;Drv.c,164 :: 		WMCON|=0x10;
	ORL WMCON+0, #16
;Drv.c,165 :: 		ACC = eedata;
	MOV 224, FARG_wr_EEPROM_eedata+0
;Drv.c,166 :: 		asm  movx @DPTR,A;
	MOVX @DPTR, A
;Drv.c,167 :: 		WMCON&=0xef;
	ANL WMCON+0, #239
;Drv.c,168 :: 		}
	RET
; end of _wr_EEPROM

_rd_EEPROM:
;Drv.c,170 :: 		unsigned char rd_EEPROM(unsigned int addr)
;Drv.c,173 :: 		DP0L=addr;
	MOV DP0L+0, FARG_rd_EEPROM_addr+0
;Drv.c,174 :: 		DP0H=addr>>8;
	MOV R0, FARG_rd_EEPROM_addr+1
	MOV R1, #0
	MOV DP0H+0, 0
;Drv.c,175 :: 		asm movx A,@DPTR;
	MOVX A, @DPTR
;Drv.c,176 :: 		return ACC;
	MOV R0, 224
;Drv.c,177 :: 		}
	RET
; end of _rd_EEPROM

_clear_lcd:
;Drv.c,179 :: 		void clear_lcd(void){
;Drv.c,181 :: 		outcw(0x80);
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
;Drv.c,182 :: 		for(i=0;i<16;i++)
	MOV clear_lcd_i_L0+0, #0
L_clear_lcd99:
	CLR C
	MOV A, clear_lcd_i_L0+0
	SUBB A, #16
	JNC L_clear_lcd100
;Drv.c,183 :: 		outd(' ');
	MOV FARG_outd_c+0, #32
	LCALL _outd+0
;Drv.c,182 :: 		for(i=0;i<16;i++)
	INC clear_lcd_i_L0+0
;Drv.c,183 :: 		outd(' ');
	SJMP L_clear_lcd99
L_clear_lcd100:
;Drv.c,184 :: 		}
	RET
; end of _clear_lcd

_outcw:
;Drv.c,186 :: 		void outcw(unsigned char c){
;Drv.c,189 :: 		RS = 0;
	CLR C
	MOV A, P3_6_bit+0
	MOV #224, C
	MOV P3_6_bit+0, A
;Drv.c,190 :: 		DB = c;
	MOV P2+0, FARG_outcw_c+0
;Drv.c,191 :: 		E = 1;
	SETB C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,192 :: 		E = 2;
	CLR C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,193 :: 		for (i=0; i<20; i++);
	MOV outcw_i_L0+0, #0
L_outcw102:
	CLR C
	MOV A, outcw_i_L0+0
	SUBB A, #20
	JNC L_outcw103
	INC outcw_i_L0+0
	SJMP L_outcw102
L_outcw103:
;Drv.c,194 :: 		if (c==1||c==2||c==3)
	MOV A, FARG_outcw_c+0
	XRL A, #1
	JZ L__outcw114
	MOV A, FARG_outcw_c+0
	XRL A, #2
	JZ L__outcw114
	MOV A, FARG_outcw_c+0
	XRL A, #3
	JZ L__outcw114
	SJMP L_outcw107
L__outcw114:
;Drv.c,195 :: 		for (j=0; j<500; j++);
	MOV outcw_j_L0+0, #0
	MOV outcw_j_L0+1, #0
L_outcw108:
	CLR C
	MOV A, outcw_j_L0+0
	SUBB A, #244
	MOV A, outcw_j_L0+1
	SUBB A, #1
	JNC L_outcw109
	MOV A, #1
	ADD A, outcw_j_L0+0
	MOV outcw_j_L0+0, A
	MOV A, #0
	ADDC A, outcw_j_L0+1
	MOV outcw_j_L0+1, A
	SJMP L_outcw108
L_outcw109:
L_outcw107:
;Drv.c,196 :: 		}
	RET
; end of _outcw

_outd:
;Drv.c,198 :: 		void outd(unsigned char c){
;Drv.c,200 :: 		c=translate(c);
	MOV FARG_translate_c+0, FARG_outd_c+0
	LCALL _translate+0
	MOV FARG_outd_c+0, 0
;Drv.c,201 :: 		RS = 1;
	SETB C
	MOV A, P3_6_bit+0
	MOV #224, C
	MOV P3_6_bit+0, A
;Drv.c,202 :: 		DB = c;
	MOV P2+0, 0
;Drv.c,203 :: 		E = 1;
	SETB C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,204 :: 		E = 2;
	CLR C
	MOV A, P3_7_bit+0
	MOV #224, C
	MOV P3_7_bit+0, A
;Drv.c,205 :: 		for (i=0; i<21; i++);
	MOV outd_i_L0+0, #0
L_outd111:
	CLR C
	MOV A, outd_i_L0+0
	SUBB A, #21
	JNC L_outd112
	INC outd_i_L0+0
	SJMP L_outd111
L_outd112:
;Drv.c,206 :: 		}
	RET
; end of _outd
