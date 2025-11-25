#include "drv.h"
//#include "1wire.h"
#include "string.h"

#define INPUT_FN 1 //Состояние ввода первого числа
#define SELECT_OP 2 //Состояние выбора операции
#define INPUT_SN 3 //Состояние ввода второго числа
#define WAIT 4 //



unsigned char key;      // Идентификатор нажатой кнопки
char state=INPUT_FN;    // Идентификатор управляющего состояния
char fN[4]; //первое число
char sN[4]; //второе число
char op = '/'; //арифм операция
//char result[8]; //результат (строка)
int res = 0; //целочисленный результат
int number = 0;
char gg;

int kF = 0;
int kS = 0;

//вспомогательные переменные
int i, j;
int isNegative;
int length;
int ms = 0;      // Счетчик милисекунд

//Процедура ввода добавления цифры в число
void inputNumber(char number[], char key)
{
     int len = strlen(number);
     if (key == '0' && len == 1) {clear_lcd(); outcw(0x80); return;}
     //if (len == 4) return;
     number[len] = key;
     number[len + 1] = '\0';
}

//конвертация целочисл результата в строку
void intToString(int number, char str[])
{
    i = 0;
    isNegative = 0;

    //проверка на отрицательное число
    if (number < 0) {
        isNegative = 1;
        number = -number;
    }

    //запись цифр в обратном порядке
    while (number > 0) {
        int digit = number % 10;
        str[i++] = '0' + digit;
        number /= 10;
    }

    //добавление минуса если число отрицательное
    if (isNegative) {
        str[i++] = '-';
    }



    str[i] = '\0';

    //обратный порядок цифр в строке
    length = i;
    //for (j = 0; j < length / 2; j++)
    //{
    //    char temp = str[j];
    //    str[j] = str[length - j - 1];
    //    str[length - j - 1] = temp;
    //}

}

void main (void)
{
     // Инициализация
     init();
     RED = 1;      // Красный цвет
     YEL = 1;      // Желтый цвет
     GRN = 0;      // Зеленый цвет
     lcd_led = 0;  // Подсветка индикатора
     clear_lcd();
     outcw(0x80);

     while (1)
     {
           key=ScanKbd(); //опрашиваем кнопку
           DelayMs(100);
           switch (state)
           {
                  case INPUT_FN:
                       DelayMs(100);
                       if (key == 13 && kF != 0) {state = SELECT_OP; clear_lcd(); outcw(0x80); RED = 0; YEL = 1; GRN = 1;break;}
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
                  case SELECT_OP:
                       DelayMs(100);
                       if (key == '#') {
                         if (op == '/') {clear_lcd(); outcw(0x80); op = '+'; outd('+'); break;}
                         else if (op == '+') {op = '-'; clear_lcd(); outcw(0x80); outd('-'); break;}
                         else if (op == '-') {op = '*'; clear_lcd(); outcw(0x80); outd('*'); break;}
                         else if (op == '*') {op = '/'; clear_lcd(); outcw(0x80); outd('/'); break;}
                       }
                       if (key == 13) {clear_lcd(); outcw(0x80); state = INPUT_SN; RED = 1; YEL = 0; GRN = 1;}
                       break;
                  case INPUT_SN:
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
                         //intToString(res, result);
                         clear_lcd();
                         outcw(0x80);




                         gg = ' ';
                         if (res < 0) {
                            gg = '-';
                            res = -res;
                         }


                         //запись цифр в обратном порядке
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
                         state = WAIT;
                         RED = 1; YEL = 1; GRN = 1;
                         break;
                       }
                       if (key == '#'  || key == ' ') break;
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
                                //inputNumber(sN, key);
                                outd(key);
                                sN[kS] = key;
                                kS++;
                                break;
                       }
                  case WAIT:
                    DelayMs(100);
                    if (key == 13) {clear_lcd(); outcw(0x80); state = INPUT_FN; RED = 1; YEL = 1; GRN = 0; break;}
                    break;
           }
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
  EA_bit = 0;
  lcd_led=~lcd_led;
  EA_bit = 1;
}


