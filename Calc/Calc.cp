#line 1 "D:/Repos/mps_note_book/Calc/Calc.c"
#line 1 "d:/repos/mps_note_book/calc/drv.h"
#line 13 "d:/repos/mps_note_book/calc/drv.h"
unsigned char ScanKbd(void);
void init(void);
unsigned char translate(unsigned char c);
void DelayMs(unsigned int m);
void wr_EEPROM(unsigned int addr,unsigned char eedata);
unsigned char rd_EEPROM(unsigned int addr);
void clear_lcd(void);
void outcw(unsigned char c);
void outd(unsigned char c);
#line 1 "d:/repos/mps_note_book/mikroc pro for 8051/include/string.h"





void * memchr(void *p, char n, unsigned int v);
int memcmp(void *s1, void *s2, int n);
void * memcpy(void * d1, void * s1, int n);
void * memmove(void * to, void * from, int n);
void * memset(void * p1, char character, int n);
char * strcat(char * to, char * from);
char * strchr(char * ptr, char chr);
int strcmp(char * s1, char * s2);
char * strcpy(char * to, char * from);
int strlen(char * s);
char * strncat(char * to, char * from, int size);
char * strncpy(char * to, char * from, int size);
int strspn(char * str1, char * str2);
char strcspn(char * s1, char * s2);
int strncmp(char * s1, char * s2, char len);
char * strpbrk(char * s1, char * s2);
char * strrchr(char *ptr, char chr);
char * strstr(char * s1, char * s2);
char * strtok(char * s1, char * s2);
#line 12 "D:/Repos/mps_note_book/Calc/Calc.c"
unsigned char key;
char state= 1 ;
char fN[4];
char sN[4];
char op = '/';

int res = 0;
int number = 0;
char gg;

int kF = 0;
int kS = 0;


int i, j;
int isNegative;
int length;
int ms = 0;


void inputNumber(char number[], char key)
{
 int len = strlen(number);
 if (key == '0' && len == 1) {clear_lcd(); outcw(0x80); return;}

 number[len] = key;
 number[len + 1] = '\0';
}


void intToString(int number, char str[])
{
 i = 0;
 isNegative = 0;


 if (number < 0) {
 isNegative = 1;
 number = -number;
 }


 while (number > 0) {
 int digit = number % 10;
 str[i++] = '0' + digit;
 number /= 10;
 }


 if (isNegative) {
 str[i++] = '-';
 }



 str[i] = '\0';


 length = i;







}

void main (void)
{

 init();
  P0_0_bit  = 1;
  P0_1_bit  = 1;
  P0_2_bit  = 0;
  P0_4_bit  = 0;
 clear_lcd();
 outcw(0x80);

 while (1)
 {
 key=ScanKbd();
 DelayMs(100);
 switch (state)
 {
 case  1 :
 DelayMs(100);
 if (key == 13 && kF != 0) {state =  2 ; clear_lcd(); outcw(0x80);  P0_0_bit  = 0;  P0_1_bit  = 1;  P0_2_bit  = 1;break;}
 if (key == '#' || key == ' ') break;
 if (kF == 4) break;
 switch (key)
 {
 case '0':
 case '1':
 case '2':
 case '3':
 case '4':
 case '5':
 case '6':
 case '7':
 case '8':
 case '9':
 outd(key);
 fN[kF] = key;
 kF++;
 break;
 }
 case  2 :
 DelayMs(100);
 if (key == '#') {
 if (op == '/') {clear_lcd(); outcw(0x80); op = '+'; outd('+'); break;}
 else if (op == '+') {op = '-'; clear_lcd(); outcw(0x80); outd('-'); break;}
 else if (op == '-') {op = '*'; clear_lcd(); outcw(0x80); outd('*'); break;}
 else if (op == '*') {op = '/'; clear_lcd(); outcw(0x80); outd('/'); break;}
 }
 if (key == 13) {clear_lcd(); outcw(0x80); state =  3 ;  P0_0_bit  = 1;  P0_1_bit  = 0;  P0_2_bit  = 1;}
 break;
 case  3 :
 DelayMs(100);
 if (key == 13 && kS != 0)
 {
 clear_lcd();
 switch (op)
 {
 case '+':
 res = atoi(fN) + atoi(sN);

 break;
 case '-':
 res = atoi(fN) - atoi(sN);
 break;
 case '*':
 res = atoi(fN) * atoi(sN);
 break;
 case '/':
 res = atoi(fN) / atoi(sN);
 break;
 }

 clear_lcd();
 outcw(0x80);




 gg = ' ';
 if (res < 0) {
 gg = '-';
 res = -res;
 }



 i = 0x8a;
 while ( res > 0) {
 int digit = res % 10;
 outcw(i);
 outd('0' + digit);
 res /= 10;
 i--;
 }

 outcw(i);
 outd(gg);


 fN[0] = '\0'; sN[0] = '\0';
 fN[1] = '\0'; sN[1] = '\0';
 fN[2] = '\0'; sN[2] = '\0';
 fN[3] = '\0'; sN[3] = '\0';

 kS = 0; kF = 0;
 state =  4 ;
  P0_0_bit  = 1;  P0_1_bit  = 1;  P0_2_bit  = 1;
 break;
 }
 if (key == '#' || key == ' ') break;
 if (kS == 4) break;
 switch (key)
 {
 case '0':
 case '1':
 case '2':
 case '3':
 case '4':
 case '5':
 case '6':
 case '7':
 case '8':
 case '9':

 outd(key);
 sN[kS] = key;
 kS++;
 break;
 }
 case  4 :
 DelayMs(100);
 if (key == 13) {clear_lcd(); outcw(0x80); state =  1 ;  P0_0_bit  = 1;  P0_1_bit  = 1;  P0_2_bit  = 0; break;}
 break;
 }
 }

}
void DelayMs(unsigned int m){

 ms=0;
 WMCON.WDTRST=1;
 while(ms!=m) continue;
}

void Timer1InterruptHandler() org IVT_ADDR_ET1{

 EA_bit = 0;
 TF1_bit = 0;

 TR1_bit = 0;
 TH1 = 0xFC;
 TL1 = 0x18;

 ms++;

 EA_bit = 1;
 TR1_bit = 1;
}

void INT0_Interrupt() org IVT_ADDR_EX0 {
 EA_bit = 0;
  P0_4_bit =~ P0_4_bit ;
 EA_bit = 1;
}
