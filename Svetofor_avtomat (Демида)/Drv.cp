#line 1 "D:/study/win/semester-7/лоя/L4/mps_primery/Svetofor_avtomat/Drv.c"
#line 1 "d:/study/win/semester-7/лоя/l4/mps_primery/svetofor_avtomat/drv.h"
#line 13 "d:/study/win/semester-7/лоя/l4/mps_primery/svetofor_avtomat/drv.h"
unsigned char ScanKbd(void);
void init(void);
unsigned char translate(unsigned char c);
void DelayMs(unsigned int m);
void wr_EEPROM(unsigned int addr,unsigned char eedata);
unsigned char rd_EEPROM(unsigned int addr);
void clear_lcd(void);
void outcw(unsigned char c);
void outd(unsigned char c);
#line 5 "D:/study/win/semester-7/лоя/L4/mps_primery/Svetofor_avtomat/Drv.c"
void init(void){
unsigned char i;


 WMCON = 0b11111001;


 WMCON|=0x08;
 WMCON&=0xfb;


 PCON |= 0x80;
 SCON = 0x72;
 TMOD = 0x22;
 TH1 = 0xF5;
 ES_bit = 0;


 TF1_bit = 0;
 ET1_bit = 1;
 EA_bit = 1;

 GATE1_bit = 0;
 C_T1_bit = 0;
 M11_bit = 0;
 M01_bit = 1;

 TR1_bit = 0;
 TH1 = 0xFC;
 TL1 = 0x18;
 TR1_bit = 1;



 P3=0xff;
 EX0_bit = 1;
 EX1_bit = 1;


 DelayMs(30);
  P3_5_bit  = 0;
 outcw(0x3C);
 outcw(0x0C);
 outcw(0x01);
 outcw(0x06);
 outcw(0x40);
 for(i=0;i<8;i++) outd(0);
 for(i=0;i<8;i++) outd(0x10);
 for(i=0;i<8;i++) outd(0x18);
 for(i=0;i<8;i++) outd(0x1C);
 for(i=0;i<8;i++) outd(0x1E);
 for(i=0;i<8;i++) outd(0x1F);
}

unsigned char ScanKbd(void) {
 unsigned char i;
 unsigned char kp = 0;

 P0 = P0&0x1F|0xC0;
 for(i=0;i<10;i++);
 if (!P1_0_bit) kp = 1;




 P0 = P0&0x1F|0xA0;
 for(i=0;i<10;i++);
 if (!P1_0_bit) kp = 2;




 P0 = P0&0x1F|0x60;
 for(i=0;i<10;i++);
 if (!P1_0_bit) kp = 3;



 return kp;
}


unsigned char translate(unsigned char c){
switch (c){
 case 'ю': return 'A';
 case 'а': return 0xA0;
 case 'б': return 'B';
 case 'ц': return 0xA1;
 case 'д': return 0xE0;
 case 'е': return 'E';
 case '╗': return 0xA2;
 case 'ф': return 0xA3;
 case 'г': return 0xA4;
 case 'х': return 0xA5;
 case 'и': return 0xA6;
 case 'й': return 'K';
 case 'к': return 0xA7;
 case 'л': return 'M';
 case 'м': return 'H';
 case 'н': return 'O';
 case 'о': return 0xA8;
 case 'п': return 'P';
 case 'я': return 'C';
 case 'р': return 'T';
 case 'с': return 0xA9;
 case 'т': return 0xAA;
 case 'у': return 'X';
 case 'ж': return 0xE1;
 case 'в': return 0xAB;
 case 'ь': return 0xAC;
 case 'ы': return 0xE2;
 case 'з': return 0xAD;
 case 'ш': return 0xAE;
 case 'э': return 'b';
 case 'щ': return 0xAF;
 case 'ч': return 0xB0;
 case 'ъ': return 0xB1;
 case 'Ю': return 'a';
 case 'А': return 0xB2;
 case 'Б': return 0xB3;
 case 'Ц': return 0xB4;
 case 'Д': return 0xE3;
 case 'Е': return 'e';
 case '╦': return 0xB5;
 case 'Ф': return 0xB6;
 case 'Г': return 0xB7;
 case 'Х': return 0xB8;
 case 'И': return 0xB9;
 case 'Й': return 0xBA;
 case 'К': return 0xBB;
 case 'Л': return 0xBC;
 case 'М': return 0xBD;
 case 'Н': return 'o';
 case 'О': return 0xBE;
 case 'П': return 'p';
 case 'Я': return 'c';
 case 'Р': return 0xBF;
 case 'С': return 'y';
 case 'Т': return 0xE4;
 case 'У': return 'x';
 case 'Ж': return 0xE5;
 case 'В': return 0xC0;
 case 'Ь': return 0xC1;
 case 'Ы': return 0xE6;
 case 'З': return 0xC2;
 case 'Ш': return 0xC3;
 case 'Э': return 0xC4;
 case 'Щ': return 0xC5;
 case 'Ч': return 0xC6;
 case 'Ъ': return 0xC7;
 default: return c;
 }
}

void wr_EEPROM(unsigned int addr,unsigned char eedata)
{

 DP0L=addr;
 DP0H=addr>>8;
 WMCON|=0x10;
 ACC = eedata;
 asm movx @DPTR,A;
 WMCON&=0xef;
}

unsigned char rd_EEPROM(unsigned int addr)
{

 DP0L=addr;
 DP0H=addr>>8;
 asm movx A,@DPTR;
 return ACC;
}

void clear_lcd(void){
 unsigned char i;
 outcw(0x80);
 for(i=0;i<16;i++)
 outd(' ');
}

void outcw(unsigned char c){
unsigned char i;
unsigned int j;
  P3_6_bit  = 0;
  P2  = c;
  P3_7_bit  = 1;
  P3_7_bit  = 2;
 for (i=0; i<20; i++);
 if (c==1||c==2||c==3)
 for (j=0; j<500; j++);
}

void outd(unsigned char c){
unsigned char i;
 c=translate(c);
  P3_6_bit  = 1;
  P2  = c;
  P3_7_bit  = 1;
  P3_7_bit  = 2;
 for (i=0; i<21; i++);
}
