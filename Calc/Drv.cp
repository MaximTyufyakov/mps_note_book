#line 1 "D:/Repos/mps_note_book/Calc/Drv.c"
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
#line 5 "D:/Repos/mps_note_book/Calc/Drv.c"
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
 case 'À': return 'A';
 case 'Á': return 0xA0;
 case 'Â': return 'B';
 case 'Ã': return 0xA1;
 case 'Ä': return 0xE0;
 case 'Å': return 'E';
 case '¨': return 0xA2;
 case 'Æ': return 0xA3;
 case 'Ç': return 0xA4;
 case 'È': return 0xA5;
 case 'É': return 0xA6;
 case 'Ê': return 'K';
 case 'Ë': return 0xA7;
 case 'Ì': return 'M';
 case 'Í': return 'H';
 case 'Î': return 'O';
 case 'Ï': return 0xA8;
 case 'Ð': return 'P';
 case 'Ñ': return 'C';
 case 'Ò': return 'T';
 case 'Ó': return 0xA9;
 case 'Ô': return 0xAA;
 case 'Õ': return 'X';
 case 'Ö': return 0xE1;
 case '×': return 0xAB;
 case 'Ø': return 0xAC;
 case 'Ù': return 0xE2;
 case 'Ú': return 0xAD;
 case 'Û': return 0xAE;
 case 'Ü': return 'b';
 case 'Ý': return 0xAF;
 case 'Þ': return 0xB0;
 case 'ß': return 0xB1;
 case 'à': return 'a';
 case 'á': return 0xB2;
 case 'â': return 0xB3;
 case 'ã': return 0xB4;
 case 'ä': return 0xE3;
 case 'å': return 'e';
 case '¸': return 0xB5;
 case 'æ': return 0xB6;
 case 'ç': return 0xB7;
 case 'è': return 0xB8;
 case 'é': return 0xB9;
 case 'ê': return 0xBA;
 case 'ë': return 0xBB;
 case 'ì': return 0xBC;
 case 'í': return 0xBD;
 case 'î': return 'o';
 case 'ï': return 0xBE;
 case 'ð': return 'p';
 case 'ñ': return 'c';
 case 'ò': return 0xBF;
 case 'ó': return 'y';
 case 'ô': return 0xE4;
 case 'õ': return 'x';
 case 'ö': return 0xE5;
 case '÷': return 0xC0;
 case 'ø': return 0xC1;
 case 'ù': return 0xE6;
 case 'ú': return 0xC2;
 case 'û': return 0xC3;
 case 'ü': return 0xC4;
 case 'ý': return 0xC5;
 case 'þ': return 0xC6;
 case 'ÿ': return 0xC7;
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
