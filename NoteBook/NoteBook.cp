#line 1 "D:/Repos/mps_note_book/NoteBook/NoteBook.c"
#line 1 "d:/repos/mps_note_book/mikroc pro for 8051/include/89xs8252.h"
#line 10 "d:/repos/mps_note_book/mikroc pro for 8051/include/89xs8252.h"
typedef struct {
 unsigned B7:1;
 unsigned B6:1;
 unsigned B5:1;
 unsigned B4:1;
 unsigned B3:1;
 unsigned B2:1;
 unsigned B1:1;
 unsigned B0:1;
} SFR_BITS;

static volatile unsigned char P0 @ 0x80;
static volatile unsigned char SP @ 0x81;
static volatile unsigned char DP0L @ 0x82;
static volatile unsigned char DP0H @ 0x83;
static volatile unsigned char DP1L @ 0x84;
static volatile unsigned char DP1H @ 0x85;
static volatile unsigned char SPDR @ 0x86;
static unsigned char PCON @ 0x87;
static volatile unsigned char TCON @ 0x88;
static unsigned char TMOD @ 0x89;
static volatile unsigned char TL0 @ 0x8A;
static volatile unsigned char TL1 @ 0x8B;
static volatile unsigned char TH0 @ 0x8C;
static volatile unsigned char TH1 @ 0x8D;
static volatile unsigned char P1 @ 0x90;
static volatile unsigned char WMCON @ 0x96;
static volatile unsigned char SCON @ 0x98;
static volatile unsigned char SBUF @ 0x99;
static volatile unsigned char P2 @ 0xA0;
static unsigned char IE @ 0xA8;
static volatile unsigned char SPSR @ 0xAA;
static volatile unsigned char P3 @ 0xB0;
static unsigned char IP @ 0xB8;
static volatile unsigned char T2CON @ 0xC8;
static unsigned char T2MOD @ 0xC9;
static volatile unsigned char RCAP2L @ 0xCA;
static volatile unsigned char RCAP2H @ 0xCB;
static volatile unsigned char TL2 @ 0xCC;
static volatile unsigned char TH2 @ 0xCD;
static volatile unsigned char PSW @ 0xD0;
static unsigned char SPCR @ 0xD5;
static volatile unsigned char ACC @ 0xE0;
static volatile unsigned char B @ 0xF0;

static volatile SFR_BITS P0_BITS @ 0x80;
static SFR_BITS PCON_BITS @ 0x87;
static volatile SFR_BITS TCON_BITS @ 0x88;
static SFR_BITS TMOD_BITS @ 0x89;
static volatile SFR_BITS P1_BITS @ 0x90;
static volatile SFR_BITS WMCON_BITS @ 0x96;
static volatile SFR_BITS SCON_BITS @ 0x98;
static volatile SFR_BITS P2_BITS @ 0xA0;
static volatile SFR_BITS SPSR_BITS @ 0xAA;
static SFR_BITS IE_BITS @ 0xA8;
static volatile SFR_BITS P3_BITS @ 0xB0;
static SFR_BITS IP_BITS @ 0xB8;
static volatile SFR_BITS T2CON_BITS @ 0xC8;
static SFR_BITS T2MOD_BITS @ 0xC9;
static volatile SFR_BITS PSW_BITS @ 0xD0;
static volatile SFR_BITS SPCR_BITS @ 0xD5;
static volatile SFR_BITS ACC_BITS @ 0xE0;
static volatile SFR_BITS B_BITS @ 0xF0;



static volatile bit P00 @ 0x80;
static volatile bit P01 @ 0x81;
static volatile bit P02 @ 0x82;
static volatile bit P03 @ 0x83;
static volatile bit P04 @ 0x84;
static volatile bit P05 @ 0x85;
static volatile bit P06 @ 0x86;
static volatile bit P07 @ 0x87;

static volatile bit AD0 @ 0x80;
static volatile bit AD1 @ 0x81;
static volatile bit AD2 @ 0x82;
static volatile bit AD3 @ 0x83;
static volatile bit AD4 @ 0x84;
static volatile bit AD5 @ 0x85;
static volatile bit AD6 @ 0x86;
static volatile bit AD7 @ 0x87;


static bit IT0 @ 0x88;
static volatile bit IE0 @ 0x89;
static bit IT1 @ 0x8A;
static volatile bit IE1 @ 0x8B;
static bit TR0 @ 0x8C;
static volatile bit TF0 @ 0x8D;
static bit TR1 @ 0x8E;
static volatile bit TF1 @ 0x8F;


static volatile bit P10 @ 0x90;
static volatile bit P11 @ 0x91;
static volatile bit P12 @ 0x92;
static volatile bit P13 @ 0x93;
static volatile bit P14 @ 0x94;
static volatile bit P15 @ 0x95;
static volatile bit P16 @ 0x96;
static volatile bit P17 @ 0x97;

static volatile bit T2 @ 0x90;
static volatile bit T2EX @ 0x91;
static volatile bit SS @ 0x94;
static volatile bit MOSI @ 0x95;
static volatile bit MISO @ 0x96;
static volatile bit SCK @ 0x97;


static volatile bit RI @ 0x98;
static volatile bit TI @ 0x99;
static volatile bit RB8 @ 0x9A;
static bit TB8 @ 0x9B;
static bit REN @ 0x9C;
static bit SM2 @ 0x9D;
static bit SM1 @ 0x9E;
static bit SM0 @ 0x9F;


static volatile bit P20 @ 0xA0;
static volatile bit P21 @ 0xA1;
static volatile bit P22 @ 0xA2;
static volatile bit P23 @ 0xA3;
static volatile bit P24 @ 0xA4;
static volatile bit P25 @ 0xA5;
static volatile bit P26 @ 0xA6;
static volatile bit P27 @ 0xA7;

static volatile bit A8 @ 0xA0;
static volatile bit A9 @ 0xA1;
static volatile bit A10 @ 0xA2;
static volatile bit A11 @ 0xA3;
static volatile bit A12 @ 0xA4;
static volatile bit A13 @ 0xA5;
static volatile bit A14 @ 0xA6;
static volatile bit A15 @ 0xA7;


static bit EX0 @ 0xA8;
static bit ET0 @ 0xA9;
static bit EX1 @ 0xAA;
static bit ET1 @ 0xAB;
static bit ES @ 0xAC;
static bit ET2 @ 0xAD;
static bit EA @ 0xAF;


static volatile bit P30 @ 0xB0;
static volatile bit P31 @ 0xB1;
static volatile bit P32 @ 0xB2;
static volatile bit P33 @ 0xB3;
static volatile bit P34 @ 0xB4;
static volatile bit P35 @ 0xB5;
static volatile bit P36 @ 0xB6;
static volatile bit P37 @ 0xB7;

static volatile bit RXD @ 0xB0;
static volatile bit TXD @ 0xB1;
static volatile bit INT0 @ 0xB2;
static volatile bit INT1 @ 0xB3;
static volatile bit T0 @ 0xB4;
static volatile bit T1 @ 0xB5;
static volatile bit WR @ 0xB6;
static volatile bit RD @ 0xB7;


static bit PX0 @ 0xB8;
static bit PT0 @ 0xB9;
static bit PX1 @ 0xBA;
static bit PT1 @ 0xBB;
static bit PS @ 0xBC;
static bit PT2 @ 0xBD;


static bit CPRL2 @ 0xC8;
static bit CT2 @ 0xC9;
static bit TR2 @ 0xCA;
static bit EXEN2 @ 0xCB;
static volatile bit TCLK @ 0xCC;
static volatile bit RCLK @ 0xCD;
static volatile bit EXF2 @ 0xCE;
static volatile bit TF2 @ 0xCF;


static volatile bit P @ 0xD0;
static volatile bit F1 @ 0xD1;
static volatile bit OV @ 0xD2;
static bit RS0 @ 0xD3;
static bit RS1 @ 0xD4;
static volatile bit F0 @ 0xD5;
static volatile bit AC @ 0xD6;
static volatile bit CY @ 0xD7;


static volatile bit ACC0 @ 0xE0;
static volatile bit ACC1 @ 0xE1;
static volatile bit ACC2 @ 0xE2;
static volatile bit ACC3 @ 0xE3;
static volatile bit ACC4 @ 0xE4;
static volatile bit ACC5 @ 0xE5;
static volatile bit ACC6 @ 0xE6;
static volatile bit ACC7 @ 0xE7;


static volatile bit B0 @ 0xF0;
static volatile bit B1 @ 0xF1;
static volatile bit B2 @ 0xF2;
static volatile bit B3 @ 0xF3;
static volatile bit B4 @ 0xF4;
static volatile bit B5 @ 0xF5;
static volatile bit B6 @ 0xF6;
static volatile bit B7 @ 0xF7;
#line 11 "D:/Repos/mps_note_book/NoteBook/NoteBook.c"
unsigned char
 ms,
 t1,
 n_zap,
 k_zap,
 INTen,
 INSen,

 need_refresh,
 kill_zap,
 enter,
 delete,
 backspace,
 insert,
 edit,
 right,
 left;


unsigned char nom_zap[5] = {"N = "},
 kol_zap[8] = {"Всего: "},
 no_zap[12] = {"Нет записей"};


char buf1[16];

unsigned char trans[64]=
{'A', 0xA0, 'B', 0xA1, 0xE0, 'E', 0xA3, 0xA4, 0xA5, 0xA6, 'K', 0xA7, 'M', 'H', 'O',
 0xA8,'P', 'C', 'T', 0xA9, 0xAA, 'X', 0xE1, 0xAB, 0xAC, 0xE2, 0xAD, 0xAE, 'b', 0xAF, 0xB0,
 0xB1, 'a', 0xB2, 0xB3, 0xB4, 0xE3, 'e', 0xB6, 0xB7, 0xB8, 0xB9, 0xBA, 0xBB, 0xBC,
 0xBD, 'o', 0xBE, 'p', 'c', 0xBF, 'y', 0xE4, 'x', 0xE5, 0xC0, 0xC1, 0xE6, 0xC2, 0xC3, 0xC4,
 0xC5, 0xC6, 0xC7
};


void wr_EEPROM(unsigned int addr,unsigned char data)
{
 while(!(WMCON&2));
 DP0L=addr;
 DP0H=addr>>8;
 WMCON|=0x10;
 ACC =data;

 movx @DPTR,A

 WMCON&=0xef;
}


unsigned char rd_EEPROM(unsigned int addr)
{
 while(!(WMCON&2));
 DP0L=addr;
 DP0H=addr>>8;

 movx A,@DPTR

 return ACC;
}


void waitms(unsigned char m){
 unsigned char a;
 a = ms + m;
 while(ms!=a);
}



void outcw(unsigned char c){
unsigned char i;
unsigned int j;
  P36  = 0;
  P2  = c;
  P37  = 1;
  P37  = 0;
 for (i=0; i<20; i++);
 if (c==1||c==2||c==3)
 for (j=0; j<500; j++);
}


void outd(unsigned char c){
unsigned char i;
  P36  = 1;
  P2  = c;
  P37  = 1;
  P37  = 0;
 for (i=0; i<21; i++);
}


void SaveBuf(){
 char i;
 for(i=0;i<16;i++)
 wr_EEPROM(n_zap * 16 + i, buf1[i]);
}


void SaveVar(){
 wr_EEPROM(0,n_zap);
 wr_EEPROM(1,k_zap);
}


unsigned char translate(unsigned char c)
{
 if (c>191) return (trans[c-192]);
 else return c;
}


void clearbuf1(){
unsigned char i;
for (i = 0; i < 16; i++) buf1[i] = ' ';
}


void ClearOrderCommamd(){
 need_refresh = 0;
 kill_zap = 0;
 enter = 0;
 delete = 0;
 backspace = 0;
 insert = 0;
 edit = 0;
 left = 0;
 right = 0;
}


void clear1(){
 unsigned char i;
 outcw(0x80);
 for(i=0;i<16;i++)
 outd(' ');
 t1 = 0;
}


void clear2(){
 unsigned char i;
 outcw(0xC0);
 for(i=0;i<16;i++)
 outd(' ');
}


void type2(){
unsigned char i;
for (i = 0; i < 4; i++) {
 outcw(i|0xC0);
 outd(translate(nom_zap[i]));}

 outcw(4|0xC0);
 outd((n_zap/10) + 0x30);

 outcw(5|0xC0);
 outd(n_zap%10 + 0x30);

for (i = 7; i < 14; i++) {
 outcw(i|0xC0);
 outd(translate(kol_zap[i-7]));}

 outcw(14|0xC0);
 outd(k_zap/10 + 0x30);

 outcw(15|0xC0);
 outd(k_zap%10 + 0x30);
}


void type1(unsigned char c){
 EA = 0;
 if (!INSen){
 outcw(t1|0x80);
 outd(translate(c));
 buf1[t1] = c;
 ++t1;
 }

 if(t1 > 14){
 t1 = 15;
 outcw(0x8F);
 outd(' ');
 buf1[t1] = ' ';
 outcw(0x0F);
 outcw(0x8F);
 }
 EA = 1;
}



void init(){

 ROM_VECTOR( 0x0B , int_timer0);
 ROM_VECTOR( 0x03 , int_XT0);
 ROM_VECTOR( 0x13 , int_XT1);
 ROM_VECTOR( 0x23 , int_UART);

 WMCON|=0x08;
 WMCON&=0xfb;

 WMCON|=0xD1;


 t1=0;

 PCON |= 0x80;
 SCON = 0x72;
 TMOD = 0x22;
 TH1 = 0xFA;
 TR1 = 1;
 ES = 1;

 TH0 = 0x8D;
 TR0 = 1;
 ET0 = 1;
 EX0 = 1;
 EX1 = 1;
 PT0 = 1;
 EA = 1;


 waitms(30);
  P35  = 0;
 outcw(0x3C);
 outcw(0x0C);
 outcw(0x01);
 outcw(0x06);
}


void main(){
unsigned char i;
 init();

  P04  = 0;

 if (rd_EEPROM(0) > 100) {
 wr_EEPROM(0,0);
 wr_EEPROM(1,0);
 }

 n_zap = rd_EEPROM(0);
 k_zap = rd_EEPROM(1);

 INTen = 1;
 INSen = 1;

 need_refresh = 1;


while(1){
 if (need_refresh) {
 EA = 0;
 ClearOrderCommamd();
 t1 = 0;
 clear1();
 if (n_zap == 0) for (i=0; i < 11; i++) {outcw(i|0x80); outd(translate(no_zap[i]));}
 else for (i=0; i<16; i++) {outcw(i|0x80); outd(translate(rd_EEPROM(n_zap * 16 + i)));}
 type2();
 EA = 1;
 }

 if (kill_zap){
 if (INSen){
 EA = 0;
 ClearOrderCommamd();
 INTen = 1;
 INSen = 1;
 n_zap = 0;
 k_zap = 0;
 wr_EEPROM(0,n_zap);
 wr_EEPROM(1,k_zap);
 clear1();
 for (i=0; i < 11; i++) {outcw(i|0x80); outd(translate(no_zap[i]));}
 type2();
 EA = 1;
 }
 }

 if (enter){
 EA = 0;
 ClearOrderCommamd();
 SaveBuf();
 SaveVar();
 INTen = 1;
 INSen = 1;
 outcw(0x0C);
 EA = 1;
 }

 if (delete){
 if (INSen){
 EA = 0;
 ClearOrderCommamd();
 clear1();
 clearbuf1();
 SaveBuf();
 EA = 1;
 }
 }

 if (backspace){
 if (!INSen){
 EA = 0;
 ClearOrderCommamd();
 if (t1) t1--;
 outcw(t1|0x80);
 outd(' ');
 buf1[t1] = ' ';
 outcw(0x0F);
 outcw(t1|0x80);
 EA = 1;
 }
 }

 if (left){
 if (!INSen){
 EA = 0;
 ClearOrderCommamd();
 if (t1) t1--;
 outcw(0x0F);
 outcw(t1|0x80);
 EA = 1;
 }
 }

 if (right){
 if (!INSen){
 EA = 0;
 ClearOrderCommamd();
 if (t1 < 16) t1++;
 outcw(0x0F);
 outcw(t1|0x80);
 EA = 1;
 }
 }


 if (insert){
 if (INSen){
 EA = 0;
 ClearOrderCommamd();
 INTen = 0;
 INSen = 0;
 n_zap = ++k_zap;
 clear1();
 clearbuf1();
 t1 = 0;
 type2();
 outcw(0x0F);
 outcw(0x80);
 EA = 1;
 }
 }

 if (edit){
 if (INSen){
 EA = 0;
 ClearOrderCommamd();
 INTen = 0;
 INSen = 0;
 for (i=0; i<16; i++) buf1[i] = rd_EEPROM(n_zap * 16 + i);
 t1 = 15;
 while (buf1[--t1] == ' ');
 t1++;
 outcw(0x0F);
 outcw(t1|0x80);
 EA = 1;
 }
 }

 }
}



static interrupt void int_timer0(){
 static unsigned char st1;
 if (++st1>7) st1 = 0; else return;
 WMCON|=0x02;
 ms++;
}


static interrupt void int_XT0(){
if (!P33){
 EA = 0;
 while(1);}

if ((n_zap == k_zap) || (!INTen) ) return;

n_zap++;
need_refresh = 1;
SaveVar();
while(!P32);
}


static interrupt void int_XT1(){
if (!P32){
 EA = 0;
 while(1);}

if ((n_zap < 2) || (!INTen)) return;

n_zap--;
need_refresh = 1;
SaveVar();
while(!P33);
}



static interrupt void int_UART(){
if (RI){
 RI=0;
 switch (SBUF){
 case 68: kill_zap = 1; return;
 case 13: enter = 1; return;
 case 46: delete = 1; return;
 case 90: delete = 1; return;
 case 8 : backspace = 1; return;
 case 65: insert = 1; return;
 case 45: insert = 1; return;
 case 69: edit = 1; return;
 case 37: left = 1; return;
 case 39: right = 1; return;
 }

 type1(SBUF);
 }
}
