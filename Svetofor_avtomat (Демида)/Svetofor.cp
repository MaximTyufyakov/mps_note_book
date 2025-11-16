#line 1 "D:/study/win/semester-7/лоя/L4/mps_primery/Svetofor_avtomat/Svetofor.c"
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
#line 1 "d:/study/win/semester-7/лоя/l4/mps_primery/svetofor_avtomat/1wire.h"
#line 13 "d:/study/win/semester-7/лоя/l4/mps_primery/svetofor_avtomat/1wire.h"
unsigned char read_OW (void);
void OW_write_bit (unsigned char write_data);
unsigned char OW_read_bit (void);
unsigned char OW_reset_pulse(void);
void OW_write_byte (unsigned char write_data);
unsigned char OW_read_byte (void);
#line 7 "D:/study/win/semester-7/лоя/L4/mps_primery/Svetofor_avtomat/Svetofor.c"
char yellow[17] = "YELLOW     ";
char red[17] = "RED         ";

char kn = 0;
char key=0;
char state=0;
char t = 0;
char TT = 100;
char T_FLAG = 0;
int ms = 0;


char str[16] = "";

char pos = 16;

void out_str()
{
 int i = 0;
 outcw(0x80);
 for (i; i < 16; ++i)
 outd(str[(i+pos >= 16) ? i+pos-16 : i+pos]);
}

void main (void) {


 init();

  P0_4_bit  = 0;
  P0_1_bit  = 1;
  P0_0_bit  = 0;
  P0_2_bit  = 1;

 strcpy(str, red);
 out_str();


 while (1) {
 key=ScanKbd();
 switch (key) {
 case 1:
 TT = 100;
 key = 0;
 break;
 case 2:
 TT = 150;
 key = 0;
 break;
 case 3:
 TT = 200;
 key = 0;
 break;
 }

 switch (state) {
 case 0:
 if (kn == 1 & t == 0) {
 state = 1;
 kn = 0;
 t = 20;
 strcpy(str, yellow);
 out_str();
  P0_1_bit  = 0;
 }
 break;
 case 1:
 if (t == 0) {
 state = 2;
 t = TT-30;
 strcpy(str, "GREEN            ");
 out_str();
  P0_0_bit  = 1;
  P0_1_bit  = 1;
  P0_2_bit  = 0;
 }
 break;
 case 2:
 if (t == 0) {state = 3;t = 30;}
 break;
 case 3:
 if (t % 5 == 0) { P0_2_bit  = ~ P0_2_bit ;  P0_4_bit  = ~ P0_4_bit ;}
 if (t == 0) {
 state = 4;
 t = 20;
 strcpy(str, yellow);
 out_str();
  P0_2_bit  = 1;
  P0_1_bit  = 0;
 }
 break;
 case 4:
 if (t == 0) {
 state = 0;
 t = TT;
  P0_1_bit  = 1;
  P0_0_bit  = 0;
 strcpy(str, red);
 out_str();
 }
 break;
 }
 if (t != 0) t--;
 DelayMs(100);
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
 if (state == 0) kn = 1;
}


void INT1_Interrupt() org IVT_ADDR_EX1 {
 if (state == 0) kn = 1;
}
