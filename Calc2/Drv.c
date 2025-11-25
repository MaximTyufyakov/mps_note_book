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
  RS = 1;
  DB = c;
  E = 1;
  E = 2;
  for (i=0; i<21; i++);
}