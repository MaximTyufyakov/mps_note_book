//#include "89xs8252.h"
//#include "temperature.h"
#include "drv.h"
#include "1wire.h"


char yellow[17] = "YELLOW     ";
char red[17] = "RED         ";

char kn = 0;
char key=0;      // Идентификатор нажатой кнопки
char state=0;    // Идентификатор управляющего состояния
char t = 0;          // Значение счетчика
char TT = 100;
char T_FLAG = 0; // Сигнал счетчика "время истекло"
int ms = 0;      // Счетчик милисекунд


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

// Инициализация
     init();

     lcd_led = 0;  // Подсветка индикатора
     YEL = 1;
     RED = 0;
     GRN = 1;      // Зеленый цвет
          
     strcpy(str, red);
     out_str();
     
// Реализация управляющего автомата
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
                    YEL = 0;
                  }
                  break;
                case 1:
                  if (t == 0) {
                    state = 2;
                    t = TT-30;
                    strcpy(str, "GREEN            ");
                    out_str();
                    RED = 1;
                    YEL = 1;
                    GRN = 0;
                  }
                  break;
                case 2:
                  if (t == 0) {state = 3;t = 30;}
                  break;
                case 3:
                  if (t % 5 == 0) {GRN = ~GRN; lcd_led = ~lcd_led;}
                  if (t == 0) {
                    state = 4;
                    t = 20;
                    strcpy(str, yellow);
                    out_str();
                    GRN = 1;
                    YEL = 0;
                  }
                  break;
                case 4:
                  if (t == 0) {
                    state = 0;
                    t = TT;
                    YEL = 1;
                    RED = 0;
                    strcpy(str, red);
                    out_str();
                  }
                  break;
              }
              if (t != 0) t--;
              DelayMs(100);            // такт работы автомата
        }
}

void DelayMs(unsigned int m){  // задержка по таймеру
  ms=0;
  WMCON.WDTRST=1; // сброс сторожевого таймера
  while(ms!=m) continue;
}

void Timer1InterruptHandler() org IVT_ADDR_ET1{

  EA_bit = 0;        // Clear global interrupt enable flag
  TF1_bit = 0;       // Ensure that Timer1 interrupt flag is cleared

  TR1_bit = 0;       // Stop Timer1
  TH1 = 0xFC;        // Reset Timer1 high byte  65536-1000
  TL1 = 0x18;        // Reset Timer1 low byte

  ms++;

  EA_bit = 1;        // Set global interrupt enable flag
  TR1_bit = 1;       // Run Timer1
}

void INT0_Interrupt() org IVT_ADDR_EX0 {
     if (state == 0) kn = 1;
}


void INT1_Interrupt() org IVT_ADDR_EX1 {
     if (state == 0) kn = 1;
}