
_inputNumber:
;Calc2.c,32 :: 		void inputNumber(char number[], char key)
;Calc2.c,34 :: 		int len = strlen(number);
	MOV FARG_strlen_s+0, FARG_inputNumber_number+0
	LCALL _strlen+0
	MOV inputNumber_len_L0+0, 0
	MOV inputNumber_len_L0+1, 1
;Calc2.c,35 :: 		if (key == '0' && len == 1) {clear_lcd(); outcw(0x80); return;}
	MOV A, FARG_inputNumber_key+0
	XRL A, #48
	JNZ L_inputNumber2
	MOV A, #1
	XRL A, inputNumber_len_L0+0
	JNZ L__inputNumber79
	MOV A, #0
	XRL A, inputNumber_len_L0+1
L__inputNumber79:
	JNZ L_inputNumber2
L__inputNumber74:
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	RET
L_inputNumber2:
;Calc2.c,37 :: 		number[len] = key;
	MOV A, FARG_inputNumber_number+0
	ADD A, inputNumber_len_L0+0
	MOV R0, A
	MOV @R0, FARG_inputNumber_key+0
;Calc2.c,38 :: 		number[len + 1] = '\0';
	MOV A, #1
	ADD A, inputNumber_len_L0+0
	MOV R0, A
	MOV A, #0
	ADDC A, inputNumber_len_L0+1
	MOV R1, A
	MOV A, FARG_inputNumber_number+0
	ADD A, R0
	MOV R0, A
	MOV @R0, #0
;Calc2.c,39 :: 		}
	RET
; end of _inputNumber

_intToString:
;Calc2.c,42 :: 		void intToString(int number, char str[])
;Calc2.c,44 :: 		i = 0;
	MOV _i+0, #0
	MOV _i+1, #0
;Calc2.c,45 :: 		isNegative = 0;
	MOV _isNegative+0, #0
	MOV _isNegative+1, #0
;Calc2.c,48 :: 		if (number < 0) {
	CLR C
	MOV A, FARG_intToString_number+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_intToString_number+1
	XRL A, #128
	SUBB A, R0
	JNC L_intToString3
;Calc2.c,49 :: 		isNegative = 1;
	MOV _isNegative+0, #1
	MOV _isNegative+1, #0
;Calc2.c,50 :: 		number = -number;
	CLR C
	MOV A, #0
	SUBB A, FARG_intToString_number+0
	MOV FARG_intToString_number+0, A
	MOV A, #0
	SUBB A, FARG_intToString_number+1
	MOV FARG_intToString_number+1, A
;Calc2.c,51 :: 		}
L_intToString3:
;Calc2.c,54 :: 		while (number > 0) {
L_intToString4:
	SETB C
	MOV A, FARG_intToString_number+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, FARG_intToString_number+1
	XRL A, #128
	SUBB A, R0
	JC L_intToString5
;Calc2.c,55 :: 		int digit = number % 10;
	MOV R4, #10
	MOV R5, #0
	MOV R0, FARG_intToString_number+0
	MOV R1, FARG_intToString_number+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
;Calc2.c,56 :: 		str[i++] = '0' + digit;
	PUSH 0
	MOV A, FARG_intToString_str+0
	ADD A, _i+0
	MOV R0, A
	MOV FLOC__intToString+0, 0
	POP 0
	MOV A, #48
	ADD A, R0
	MOV R0, A
	PUSH 1
	MOV R1, FLOC__intToString+0
	MOV @R1, 0
	POP 1
	MOV A, #1
	ADD A, _i+0
	MOV _i+0, A
	MOV A, #0
	ADDC A, _i+1
	MOV _i+1, A
;Calc2.c,57 :: 		number /= 10;
	MOV R4, #10
	MOV R5, #0
	MOV R0, FARG_intToString_number+0
	MOV R1, FARG_intToString_number+1
	LCALL _Div_16x16_S+0
	MOV FARG_intToString_number+0, 0
	MOV FARG_intToString_number+1, 1
;Calc2.c,58 :: 		}
	SJMP L_intToString4
L_intToString5:
;Calc2.c,61 :: 		if (isNegative) {
	MOV A, _isNegative+0
	ORL A, _isNegative+1
	JZ L_intToString6
;Calc2.c,62 :: 		str[i++] = '-';
	MOV A, FARG_intToString_str+0
	ADD A, _i+0
	MOV R0, A
	MOV @R0, #45
	MOV A, #1
	ADD A, _i+0
	MOV _i+0, A
	MOV A, #0
	ADDC A, _i+1
	MOV _i+1, A
;Calc2.c,63 :: 		}
L_intToString6:
;Calc2.c,67 :: 		str[i] = '\0';
	MOV A, FARG_intToString_str+0
	ADD A, _i+0
	MOV R0, A
	MOV @R0, #0
;Calc2.c,70 :: 		length = i;
	MOV _length+0, _i+0
	MOV _length+1, _i+1
;Calc2.c,78 :: 		}
	RET
; end of _intToString

_main:
	MOV SP+0, #128
;Calc2.c,80 :: 		void main (void)
;Calc2.c,83 :: 		init();
	LCALL _init+0
;Calc2.c,84 :: 		RED = 1;      // Красный цвет
	SETB P0_0_bit+0
;Calc2.c,85 :: 		YEL = 1;      // Желтый цвет
	SETB P0_1_bit+0
;Calc2.c,86 :: 		GRN = 0;      // Зеленый цвет
	CLR P0_2_bit+0
;Calc2.c,87 :: 		lcd_led = 0;  // Подсветка индикатора
	CLR P0_4_bit+0
;Calc2.c,88 :: 		clear_lcd();
	LCALL _clear_lcd+0
;Calc2.c,89 :: 		outcw(0x80);
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
;Calc2.c,91 :: 		while (1)
L_main7:
;Calc2.c,93 :: 		key=ScanKbd(); //опрашиваем кнопку
	LCALL _ScanKbd+0
	MOV _key+0, 0
;Calc2.c,94 :: 		DelayMs(100);
	MOV FARG_DelayMs_m+0, #100
	MOV FARG_DelayMs_m+1, #0
	LCALL _DelayMs+0
;Calc2.c,95 :: 		switch (state)
	LJMP L_main9
;Calc2.c,97 :: 		case INPUT_FN:
L_main11:
;Calc2.c,98 :: 		DelayMs(100);
	MOV FARG_DelayMs_m+0, #100
	MOV FARG_DelayMs_m+1, #0
	LCALL _DelayMs+0
;Calc2.c,99 :: 		if (key == 13 && kF != 0) {state = SELECT_OP; clear_lcd(); outcw(0x80); RED = 0; YEL = 1; GRN = 1;break;}
	MOV A, _key+0
	XRL A, #13
	JNZ L_main14
	MOV A, _kF+0
	ORL A, _kF+1
	JZ L_main14
L__main78:
	MOV _state+0, #2
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	CLR P0_0_bit+0
	SETB P0_1_bit+0
	SETB P0_2_bit+0
	LJMP L_main10
L_main14:
;Calc2.c,100 :: 		if (key == '#' || key == ' ') break;
	MOV A, _key+0
	XRL A, #35
	JZ L__main77
	MOV A, _key+0
	XRL A, #32
	JZ L__main77
	SJMP L_main17
L__main77:
	LJMP L_main10
L_main17:
;Calc2.c,101 :: 		if (kF == 4) break;
	MOV A, #4
	XRL A, _kF+0
	JNZ L__main80
	MOV A, #0
	XRL A, _kF+1
L__main80:
	JNZ L_main18
	LJMP L_main10
L_main18:
;Calc2.c,102 :: 		switch (key)
	SJMP L_main19
;Calc2.c,104 :: 		case '0':
L_main21:
;Calc2.c,105 :: 		case '1':
L_main22:
;Calc2.c,106 :: 		case '2':
L_main23:
;Calc2.c,107 :: 		case '3':
L_main24:
;Calc2.c,108 :: 		case '4':
L_main25:
;Calc2.c,109 :: 		case '5':
L_main26:
;Calc2.c,110 :: 		case '6':
L_main27:
;Calc2.c,111 :: 		case '7':
L_main28:
;Calc2.c,112 :: 		case '8':
L_main29:
;Calc2.c,113 :: 		case '9':
L_main30:
;Calc2.c,114 :: 		outd(key);
	MOV FARG_outd_c+0, _key+0
	LCALL _outd+0
;Calc2.c,115 :: 		fN[kF] = key;
	MOV A, #_fN+0
	ADD A, _kF+0
	MOV R0, A
	MOV @R0, _key+0
;Calc2.c,116 :: 		kF++;
	MOV A, #1
	ADD A, _kF+0
	MOV _kF+0, A
	MOV A, #0
	ADDC A, _kF+1
	MOV _kF+1, A
;Calc2.c,117 :: 		break;
	SJMP L_main20
;Calc2.c,118 :: 		}
L_main19:
	MOV A, _key+0
	XRL A, #48
	JZ L_main21
	MOV A, _key+0
	XRL A, #49
	JZ L_main22
	MOV A, _key+0
	XRL A, #50
	JZ L_main23
	MOV A, _key+0
	XRL A, #51
	JZ L_main24
	MOV A, _key+0
	XRL A, #52
	JZ L_main25
	MOV A, _key+0
	XRL A, #53
	JZ L_main26
	MOV A, _key+0
	XRL A, #54
	JZ L_main27
	MOV A, _key+0
	XRL A, #55
	JZ L_main28
	MOV A, _key+0
	XRL A, #56
	JZ L_main29
	MOV A, _key+0
	XRL A, #57
	JZ L_main30
L_main20:
;Calc2.c,119 :: 		case SELECT_OP:
L_main31:
;Calc2.c,120 :: 		DelayMs(100);
	MOV FARG_DelayMs_m+0, #100
	MOV FARG_DelayMs_m+1, #0
	LCALL _DelayMs+0
;Calc2.c,121 :: 		if (key == '#') {
	MOV A, _key+0
	XRL A, #35
	JNZ L_main32
;Calc2.c,122 :: 		if (op == '/') {clear_lcd(); outcw(0x80); op = '+'; outd('+'); break;}
	MOV A, _op+0
	XRL A, #47
	JNZ L_main33
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV _op+0, #43
	MOV FARG_outd_c+0, #43
	LCALL _outd+0
	LJMP L_main10
L_main33:
;Calc2.c,123 :: 		else if (op == '+') {op = '-'; clear_lcd(); outcw(0x80); outd('-'); break;}
	MOV A, _op+0
	XRL A, #43
	JNZ L_main35
	MOV _op+0, #45
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV FARG_outd_c+0, #45
	LCALL _outd+0
	LJMP L_main10
L_main35:
;Calc2.c,124 :: 		else if (op == '-') {op = '*'; clear_lcd(); outcw(0x80); outd('*'); break;}
	MOV A, _op+0
	XRL A, #45
	JNZ L_main37
	MOV _op+0, #42
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV FARG_outd_c+0, #42
	LCALL _outd+0
	LJMP L_main10
L_main37:
;Calc2.c,125 :: 		else if (op == '*') {op = '/'; clear_lcd(); outcw(0x80); outd('/'); break;}
	MOV A, _op+0
	XRL A, #42
	JNZ L_main39
	MOV _op+0, #47
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV FARG_outd_c+0, #47
	LCALL _outd+0
	LJMP L_main10
L_main39:
;Calc2.c,126 :: 		}
L_main32:
;Calc2.c,127 :: 		if (key == 13) {clear_lcd(); outcw(0x80); state = INPUT_SN; RED = 1; YEL = 0; GRN = 1;}
	MOV A, _key+0
	XRL A, #13
	JNZ L_main40
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV _state+0, #3
	SETB P0_0_bit+0
	CLR P0_1_bit+0
	SETB P0_2_bit+0
L_main40:
;Calc2.c,128 :: 		break;
	LJMP L_main10
;Calc2.c,129 :: 		case INPUT_SN:
L_main41:
;Calc2.c,130 :: 		DelayMs(100);
	MOV FARG_DelayMs_m+0, #100
	MOV FARG_DelayMs_m+1, #0
	LCALL _DelayMs+0
;Calc2.c,131 :: 		if (key == 13 && kS != 0)
	MOV A, _key+0
	XRL A, #13
	JZ #3
	LJMP L_main44
	MOV A, _kS+0
	ORL A, _kS+1
	JNZ #3
	LJMP L_main44
L__main76:
;Calc2.c,133 :: 		clear_lcd();
	LCALL _clear_lcd+0
;Calc2.c,134 :: 		switch (op)
	LJMP L_main45
;Calc2.c,136 :: 		case '+':
L_main47:
;Calc2.c,137 :: 		res = atoi(fN) + atoi(sN);
	MOV FARG_atoi_s+0, #_fN+0
	LCALL _atoi+0
	MOV FLOC__main+0, 0
	MOV FLOC__main+1, 1
	MOV FARG_atoi_s+0, #_sN+0
	LCALL _atoi+0
	MOV A, FLOC__main+0
	ADD A, R0
	MOV _res+0, A
	MOV A, FLOC__main+1
	ADDC A, R1
	MOV _res+1, A
;Calc2.c,139 :: 		break;
	LJMP L_main46
;Calc2.c,140 :: 		case '-':
L_main48:
;Calc2.c,141 :: 		res = atoi(fN) - atoi(sN);
	MOV FARG_atoi_s+0, #_fN+0
	LCALL _atoi+0
	MOV FLOC__main+0, 0
	MOV FLOC__main+1, 1
	MOV FARG_atoi_s+0, #_sN+0
	LCALL _atoi+0
	CLR C
	MOV A, FLOC__main+0
	SUBB A, R0
	MOV _res+0, A
	MOV A, FLOC__main+1
	SUBB A, R1
	MOV _res+1, A
;Calc2.c,142 :: 		break;
	SJMP L_main46
;Calc2.c,143 :: 		case '*':
L_main49:
;Calc2.c,144 :: 		res = atoi(fN) * atoi(sN);
	MOV FARG_atoi_s+0, #_fN+0
	LCALL _atoi+0
	MOV FLOC__main+0, 0
	MOV FLOC__main+1, 1
	MOV FARG_atoi_s+0, #_sN+0
	LCALL _atoi+0
	MOV R4, FLOC__main+0
	MOV R5, FLOC__main+1
	LCALL _Mul_16x16+0
	MOV _res+0, 0
	MOV _res+1, 1
;Calc2.c,145 :: 		break;
	SJMP L_main46
;Calc2.c,146 :: 		case '/':
L_main50:
;Calc2.c,147 :: 		res = atoi(fN) / atoi(sN);
	MOV FARG_atoi_s+0, #_fN+0
	LCALL _atoi+0
	MOV FLOC__main+0, 0
	MOV FLOC__main+1, 1
	MOV FARG_atoi_s+0, #_sN+0
	LCALL _atoi+0
	MOV R4, 0
	MOV R5, 1
	MOV R0, FLOC__main+0
	MOV R1, FLOC__main+1
	LCALL _Div_16x16_S+0
	MOV _res+0, 0
	MOV _res+1, 1
;Calc2.c,148 :: 		break;
	SJMP L_main46
;Calc2.c,149 :: 		}
L_main45:
	MOV A, _op+0
	XRL A, #43
	JNZ #3
	LJMP L_main47
	MOV A, _op+0
	XRL A, #45
	JNZ #3
	LJMP L_main48
	MOV A, _op+0
	XRL A, #42
	JZ L_main49
	MOV A, _op+0
	XRL A, #47
	JZ L_main50
L_main46:
;Calc2.c,151 :: 		clear_lcd();
	LCALL _clear_lcd+0
;Calc2.c,152 :: 		outcw(0x80);
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
;Calc2.c,160 :: 		gg = ' ';
	MOV _gg+0, #32
;Calc2.c,161 :: 		if (res < 0) {
	CLR C
	MOV A, _res+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, _res+1
	XRL A, #128
	SUBB A, R0
	JNC L_main51
;Calc2.c,162 :: 		gg = '-';
	MOV _gg+0, #45
;Calc2.c,163 :: 		res = -res;
	CLR C
	MOV A, #0
	SUBB A, _res+0
	MOV _res+0, A
	MOV A, #0
	SUBB A, _res+1
	MOV _res+1, A
;Calc2.c,164 :: 		}
L_main51:
;Calc2.c,168 :: 		i = 0x8a;
	MOV _i+0, #138
	MOV _i+1, #0
;Calc2.c,169 :: 		while ( res > 0) {
L_main52:
	SETB C
	MOV A, _res+0
	SUBB A, #0
	MOV A, #0
	XRL A, #128
	MOV R0, A
	MOV A, _res+1
	XRL A, #128
	SUBB A, R0
	JC L_main53
;Calc2.c,170 :: 		int digit = res % 10;
	MOV R4, #10
	MOV R5, #0
	MOV R0, _res+0
	MOV R1, _res+1
	LCALL _Div_16x16_S+0
	MOV R0, 4
	MOV R1, 5
	MOV main_digit_L4+0, 0
	MOV main_digit_L4+1, 1
;Calc2.c,171 :: 		outcw(i);
	MOV FARG_outcw_c+0, _i+0
	LCALL _outcw+0
;Calc2.c,172 :: 		outd('0' + digit);
	MOV A, #48
	ADD A, main_digit_L4+0
	MOV FARG_outd_c+0, A
	LCALL _outd+0
;Calc2.c,173 :: 		res /= 10;
	MOV R4, #10
	MOV R5, #0
	MOV R0, _res+0
	MOV R1, _res+1
	LCALL _Div_16x16_S+0
	MOV _res+0, 0
	MOV _res+1, 1
;Calc2.c,174 :: 		i--;
	CLR C
	MOV A, _i+0
	SUBB A, #1
	MOV _i+0, A
	MOV A, _i+1
	SUBB A, #0
	MOV _i+1, A
;Calc2.c,175 :: 		}
	SJMP L_main52
L_main53:
;Calc2.c,177 :: 		outcw(i);
	MOV FARG_outcw_c+0, _i+0
	LCALL _outcw+0
;Calc2.c,178 :: 		outd(gg);
	MOV FARG_outd_c+0, _gg+0
	LCALL _outd+0
;Calc2.c,195 :: 		fN[0] = '\0'; sN[0] = '\0';
	MOV _fN+0, #0
	MOV _sN+0, #0
;Calc2.c,196 :: 		fN[1] = '\0'; sN[1] = '\0';
	MOV _fN+1, #0
	MOV _sN+1, #0
;Calc2.c,197 :: 		fN[2] = '\0'; sN[2] = '\0';
	MOV _fN+2, #0
	MOV _sN+2, #0
;Calc2.c,198 :: 		fN[3] = '\0'; sN[3] = '\0';
	MOV _fN+3, #0
	MOV _sN+3, #0
;Calc2.c,204 :: 		kS = 0; kF = 0;
	MOV _kS+0, #0
	MOV _kS+1, #0
	MOV _kF+0, #0
	MOV _kF+1, #0
;Calc2.c,205 :: 		state = WAIT;
	MOV _state+0, #4
;Calc2.c,206 :: 		RED = 1; YEL = 1; GRN = 1;
	SETB P0_0_bit+0
	SETB P0_1_bit+0
	SETB P0_2_bit+0
;Calc2.c,207 :: 		break;
	LJMP L_main10
;Calc2.c,208 :: 		}
L_main44:
;Calc2.c,209 :: 		if (key == '#'  || key == ' ') break;
	MOV A, _key+0
	XRL A, #35
	JZ L__main75
	MOV A, _key+0
	XRL A, #32
	JZ L__main75
	SJMP L_main56
L__main75:
	LJMP L_main10
L_main56:
;Calc2.c,210 :: 		if (kS == 4) break;
	MOV A, #4
	XRL A, _kS+0
	JNZ L__main81
	MOV A, #0
	XRL A, _kS+1
L__main81:
	JNZ L_main57
	LJMP L_main10
L_main57:
;Calc2.c,211 :: 		switch (key)
	SJMP L_main58
;Calc2.c,213 :: 		case '0':
L_main60:
;Calc2.c,214 :: 		case '1':
L_main61:
;Calc2.c,215 :: 		case '2':
L_main62:
;Calc2.c,216 :: 		case '3':
L_main63:
;Calc2.c,217 :: 		case '4':
L_main64:
;Calc2.c,218 :: 		case '5':
L_main65:
;Calc2.c,219 :: 		case '6':
L_main66:
;Calc2.c,220 :: 		case '7':
L_main67:
;Calc2.c,221 :: 		case '8':
L_main68:
;Calc2.c,222 :: 		case '9':
L_main69:
;Calc2.c,224 :: 		outd(key);
	MOV FARG_outd_c+0, _key+0
	LCALL _outd+0
;Calc2.c,225 :: 		sN[kS] = key;
	MOV A, #_sN+0
	ADD A, _kS+0
	MOV R0, A
	MOV @R0, _key+0
;Calc2.c,226 :: 		kS++;
	MOV A, #1
	ADD A, _kS+0
	MOV _kS+0, A
	MOV A, #0
	ADDC A, _kS+1
	MOV _kS+1, A
;Calc2.c,227 :: 		break;
	SJMP L_main59
;Calc2.c,228 :: 		}
L_main58:
	MOV A, _key+0
	XRL A, #48
	JZ L_main60
	MOV A, _key+0
	XRL A, #49
	JZ L_main61
	MOV A, _key+0
	XRL A, #50
	JZ L_main62
	MOV A, _key+0
	XRL A, #51
	JZ L_main63
	MOV A, _key+0
	XRL A, #52
	JZ L_main64
	MOV A, _key+0
	XRL A, #53
	JZ L_main65
	MOV A, _key+0
	XRL A, #54
	JZ L_main66
	MOV A, _key+0
	XRL A, #55
	JZ L_main67
	MOV A, _key+0
	XRL A, #56
	JZ L_main68
	MOV A, _key+0
	XRL A, #57
	JZ L_main69
L_main59:
;Calc2.c,229 :: 		case WAIT:
L_main70:
;Calc2.c,230 :: 		DelayMs(100);
	MOV FARG_DelayMs_m+0, #100
	MOV FARG_DelayMs_m+1, #0
	LCALL _DelayMs+0
;Calc2.c,231 :: 		if (key == 13) {clear_lcd(); outcw(0x80); state = INPUT_FN; RED = 1; YEL = 1; GRN = 0; break;}
	MOV A, _key+0
	XRL A, #13
	JNZ L_main71
	LCALL _clear_lcd+0
	MOV FARG_outcw_c+0, #128
	LCALL _outcw+0
	MOV _state+0, #1
	SETB P0_0_bit+0
	SETB P0_1_bit+0
	CLR P0_2_bit+0
	SJMP L_main10
L_main71:
;Calc2.c,232 :: 		break;
	SJMP L_main10
;Calc2.c,233 :: 		}
L_main9:
	MOV A, _state+0
	XRL A, #1
	JNZ #3
	LJMP L_main11
	MOV A, _state+0
	XRL A, #2
	JNZ #3
	LJMP L_main31
	MOV A, _state+0
	XRL A, #3
	JNZ #3
	LJMP L_main41
	MOV A, _state+0
	XRL A, #4
	JZ L_main70
L_main10:
;Calc2.c,234 :: 		}
	LJMP L_main7
;Calc2.c,236 :: 		}
	SJMP #254
; end of _main

_DelayMs:
;Calc2.c,237 :: 		void DelayMs(unsigned int m){  // задержка по таймеру
;Calc2.c,240 :: 		ms=0;
	MOV _ms+0, #0
	MOV _ms+1, #0
;Calc2.c,241 :: 		WMCON.WDTRST=1; // сброс сторожевого таймера
	SETB C
	MOV A, WMCON+0
	MOV #224, C
	MOV WMCON+0, A
;Calc2.c,242 :: 		while(ms!=m) continue;
L_DelayMs72:
	MOV A, _ms+0
	XRL A, FARG_DelayMs_m+0
	JNZ L__DelayMs82
	MOV A, _ms+1
	XRL A, FARG_DelayMs_m+1
L__DelayMs82:
	JZ L_DelayMs73
	SJMP L_DelayMs72
L_DelayMs73:
;Calc2.c,243 :: 		}
	RET
; end of _DelayMs

_Timer1InterruptHandler:
	PUSH PSW+0
	PUSH 224
	PUSH B+0
	PUSH 130
	PUSH 131
;Calc2.c,245 :: 		void Timer1InterruptHandler() org IVT_ADDR_ET1{
;Calc2.c,247 :: 		EA_bit = 0;        // Clear global interrupt enable flag
	CLR EA_bit+0
;Calc2.c,248 :: 		TF1_bit = 0;       // Ensure that Timer1 interrupt flag is cleared
	CLR TF1_bit+0
;Calc2.c,250 :: 		TR1_bit = 0;       // Stop Timer1
	CLR TR1_bit+0
;Calc2.c,251 :: 		TH1 = 0xFC;        // Reset Timer1 high byte  65536-1000
	MOV TH1+0, #252
;Calc2.c,252 :: 		TL1 = 0x18;        // Reset Timer1 low byte
	MOV TL1+0, #24
;Calc2.c,255 :: 		ms++;
	MOV A, #1
	ADD A, _ms+0
	MOV _ms+0, A
	MOV A, #0
	ADDC A, _ms+1
	MOV _ms+1, A
;Calc2.c,257 :: 		EA_bit = 1;        // Set global interrupt enable flag
	SETB EA_bit+0
;Calc2.c,258 :: 		TR1_bit = 1;       // Run Timer1
	SETB TR1_bit+0
;Calc2.c,259 :: 		}
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
;Calc2.c,261 :: 		void INT0_Interrupt() org IVT_ADDR_EX0 {
;Calc2.c,262 :: 		EA_bit = 0;
	CLR EA_bit+0
;Calc2.c,263 :: 		lcd_led=~lcd_led;
	MOV C, P0_4_bit+0
	CPL C
	MOV P0_4_bit+0, C
;Calc2.c,264 :: 		EA_bit = 1;
	SETB EA_bit+0
;Calc2.c,265 :: 		}
	POP 131
	POP 130
	POP B+0
	POP 224
	POP PSW+0
	RETI
; end of _INT0_Interrupt
