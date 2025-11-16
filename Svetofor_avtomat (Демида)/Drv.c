//#include "89xs8252.h"
#include "drv.h"


void init(void){
unsigned char i;

//WDT
  WMCON = 0b11111001;  // Enable WatchDog Timer, set prescaller bits to 111

//Memory
  WMCON|=0x08;  // internal EEPROM enable
  WMCON&=0xfb;  // DPTR = DP0

//UART
  PCON |= 0x80;        // SMOD=1
  SCON = 0x72;        // mode 1, receiver enable
  TMOD = 0x22;        //Timers 0&1 are 8-bit timers with auto-reload
  TH1   = 0xF5;        // 9600 baud at 20 MHz
  ES_bit = 0;

//Timer 1
  TF1_bit = 0;       // Ensure that Timer1 interrupt flag is cleared
  ET1_bit = 1;       // Enable Timer1 interrupt
  EA_bit  = 1;       // Set global interrupt enable

  GATE1_bit = 0;     // Clear this flag to enable Timer1 whenever TR1 bit is set.
  C_T1_bit  = 0;     // Set Timer operation: Timer1 counts the divided-down systam clock.
  M11_bit   = 0;     // M11_M01 = 01    =>   Mode 1(16-bit Timer/Counter)
  M01_bit   = 1;

  TR1_bit = 0;       // Turn off Timer1
  TH1 = 0xFC;        // Reset Timer1 high byte  65536-1000
  TL1 = 0x18;        // Reset Timer1 low byte
  TR1_bit = 1;       // Run Timer1
  //TR1_bit = 0;

//External interrupt
  P3=0xff;
  EX0_bit = 1;
  EX1_bit = 1;

//LCD
  DelayMs(30);
  RW = 0;
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
  
  P0 = P0&0x1F|0xC0;    //столбец 1
  for(i=0;i<10;i++);
  if (!P1_0_bit) kp = 1;
//  else if (!P1_1_bit) kp = 2;
//  else if (!P1_2_bit) kp = 3;
//  else if (!P1_3_bit) kp = 4;

  P0 = P0&0x1F|0xA0;    //столбец 2
  for(i=0;i<10;i++);
  if (!P1_0_bit) kp = 2;
  //else if (!P1_1_bit) kp = '5';
  //else if (!P1_2_bit) kp = '2';
  //else if (!P1_3_bit) kp = '0';
  
  P0 = P0&0x1F|0x60;    //столбец 3
  for(i=0;i<10;i++);
  if (!P1_0_bit) kp = 3;
  //else if (!P1_1_bit) kp = '6';
  //else if (!P1_2_bit) kp = '3';
  //else if (!P1_3_bit) kp = 13;
  return kp;
}


unsigned char translate(unsigned char c){
switch (c){
  case 'А': return 'A';
  case 'Б': return 0xA0;
  case 'В': return 'B';
  case 'Г': return 0xA1;
  case 'Д': return 0xE0;
  case 'Е': return 'E';
  case 'Ё': return 0xA2;
  case 'Ж': return 0xA3;
  case 'З': return 0xA4;
  case 'И': return 0xA5;
  case 'Й': return 0xA6;
  case 'К': return 'K';
  case 'Л': return 0xA7;
  case 'М': return 'M';
  case 'Н': return 'H';
  case 'О': return 'O';
  case 'П': return 0xA8;
  case 'Р': return 'P';
  case 'С': return 'C';
  case 'Т': return 'T';
  case 'У': return 0xA9;
  case 'Ф': return 0xAA;
  case 'Х': return 'X';
  case 'Ц': return 0xE1;
  case 'Ч': return 0xAB;
  case 'Ш': return 0xAC;
  case 'Щ': return 0xE2;
  case 'Ъ': return 0xAD;
  case 'Ы': return 0xAE;
  case 'Ь': return 'b';
  case 'Э': return 0xAF;
  case 'Ю': return 0xB0;
  case 'Я': return 0xB1;
  case 'а': return 'a';
  case 'б': return 0xB2;
  case 'в': return 0xB3;
  case 'г': return 0xB4;
  case 'д': return 0xE3;
  case 'е': return 'e';
  case 'ё': return 0xB5;
  case 'ж': return 0xB6;
  case 'з': return 0xB7;
  case 'и': return 0xB8;
  case 'й': return 0xB9;
  case 'к': return 0xBA;
  case 'л': return 0xBB;
  case 'м': return 0xBC;
  case 'н': return 0xBD;
  case 'о': return 'o';
  case 'п': return 0xBE;
  case 'р': return 'p';
  case 'с': return 'c';
  case 'т': return 0xBF;
  case 'у': return 'y';
  case 'ф': return 0xE4;
  case 'х': return 'x';
  case 'ц': return 0xE5;
  case 'ч': return 0xC0;
  case 'ш': return 0xC1;
  case 'щ': return 0xE6;
  case 'ъ': return 0xC2;
  case 'ы': return 0xC3;
  case 'ь': return 0xC4;
  case 'э': return 0xC5;
  case 'ю': return 0xC6;
  case 'я': return 0xC7;
  default: return c;
  }
}

void wr_EEPROM(unsigned int addr,unsigned char eedata)
{
  //while(!(WMCON&2));
  DP0L=addr;  //addr1.byte_.l_byte;
  DP0H=addr>>8;
  WMCON|=0x10;
  ACC = eedata;
  asm  movx @DPTR,A;
  WMCON&=0xef;
}

unsigned char rd_EEPROM(unsigned int addr)
{
  //while(!(WMCON&2));
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
  RS = 0;
  DB = c;
  E = 1;
  E = 2;
  for (i=0; i<20; i++);
  if (c==1||c==2||c==3)
    for (j=0; j<500; j++);
}

void outd(unsigned char c){
unsigned char i;
  c=translate(c);
  RS = 1;
  DB = c;
  E = 1;
  E = 2;
  for (i=0; i<21; i++);
}