//#include &quot;89xs8252.h&quot;
//#include &quot;temperature.h&quot;
#include &quot;drv.h&quot;
#include &quot;1wire.h&quot;
#include &quot;string.h&quot;

#define INPUT_FN 1 //Состояние ввода первого числа
#define SELECT_OP 2 //Состояние выбора операции
#define INPUT_SN 3 //Состояние ввода второго числа
#define WAIT 4 //

unsigned char key; // Идентификатор нажатой кнопки
char state=INPUT_FN; // Идентификатор управляющего состояния
char fN[4]; //первое число
char sN[4]; //второе число
char op = &#39;/&#39;; //арифм операция
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
int ms = 0; // Счетчик милисекунд

//Процедура ввода добавления цифры в число
void inputNumber(char number[], char key)
{
int len = strlen(number);
if (key == &#39;0&#39; &amp;&amp; len == 1) {clear_lcd(); outcw(0x80); return;}
//if (len == 4) return;
number[len] = key;
number[len + 1] = &#39;\0&#39;;
}

//конвертация целочисл результата в строку
void intToString(int number, char str[])
{
i = 0;
isNegative = 0;

//проверка на отрицательное число
if (number &lt; 0) {
isNegative = 1;
number = -number;
}

//запись цифр в обратном порядке

while (number &gt; 0) {
int digit = number % 10;
str[i++] = &#39;0&#39; + digit;
number /= 10;
}

//добавление минуса если число отрицательное
if (isNegative) {
str[i++] = &#39;-&#39;;
}

str[i] = &#39;\0&#39;;

//обратный порядок цифр в строке
length = i;
//for (j = 0; j &lt; length / 2; j++)
//{
// char temp = str[j];
// str[j] = str[length - j - 1];
// str[length - j - 1] = temp;
//}

}

void main (void)
{
// Инициализация
init();

RED = 1; // Красный цвет
YEL = 1; // Желтый цвет
GRN = 0; // Зеленый цвет
lcd_led = 0; // Подсветка индикатора
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
if (key == 13 &amp;&amp; kF != 0) {state = SELECT_OP;
clear_lcd(); outcw(0x80); RED = 0; YEL = 1; GRN = 1;break;}
if (key == &#39;#&#39; || key == &#39; &#39;) break;
if (kF == 4) break;
switch (key)
{
case &#39;0&#39;:
case &#39;1&#39;:
case &#39;2&#39;:
case &#39;3&#39;:
case &#39;4&#39;:
case &#39;5&#39;:
case &#39;6&#39;:
case &#39;7&#39;:
case &#39;8&#39;:

case &#39;9&#39;:
outd(key);
fN[kF] = key;
kF++;
break;
}
case SELECT_OP:
DelayMs(100);
if (key == &#39;#&#39;) {
if (op == &#39;/&#39;) {clear_lcd(); outcw(0x80); op
= &#39;+&#39;; outd(&#39;+&#39;); break;}
else if (op == &#39;+&#39;) {op = &#39;-&#39;; clear_lcd();
outcw(0x80); outd(&#39;-&#39;); break;}
else if (op == &#39;-&#39;) {op = &#39;*&#39;; clear_lcd();
outcw(0x80); outd(&#39;*&#39;); break;}
else if (op == &#39;*&#39;) {op = &#39;/&#39;; clear_lcd();
outcw(0x80); outd(&#39;/&#39;); break;}
}
if (key == 13) {clear_lcd(); outcw(0x80); state
= INPUT_SN; RED = 1; YEL = 0; GRN = 1;}
break;
case INPUT_SN:
DelayMs(100);
if (key == 13 &amp;&amp; kS != 0)
{
clear_lcd();
switch (op)
{
case &#39;+&#39;:
res = atoi(fN) + atoi(sN);

break;

case &#39;-&#39;:
res = atoi(fN) - atoi(sN);
break;
case &#39;*&#39;:
res = atoi(fN) * atoi(sN);
break;
case &#39;/&#39;:
res = atoi(fN) / atoi(sN);
break;
}
//intToString(res, result);
clear_lcd();
outcw(0x80);

//intToString(res, result);

//isNegative = 0;

gg = &#39; &#39;;
if (res &lt; 0) {
gg = &#39;-&#39;;
res = -res;
}

//запись цифр в обратном порядке
i = 0x8a;
while ( res &gt; 0) {

int digit = res % 10;
outcw(i);
outd(&#39;0&#39; + digit);
res /= 10;
i--;
}

outcw(i);
outd(gg);

//outcw(0x80);

//outd(result[0]);
//outd(result[1]);
//outd(result[2]);
//outd(result[3]);
//outd(result[4]);
//outd(result[5]);
//outd(result[6]);
//outd(result[7]);

//outd(&#39;r&#39;);
//outd(result[0]); outd(result[1]);
//outd(result[6]); outd(result[7]);
fN[0] = &#39;\0&#39;; sN[0] = &#39;\0&#39;;
fN[1] = &#39;\0&#39;; sN[1] = &#39;\0&#39;;
fN[2] = &#39;\0&#39;; sN[2] = &#39;\0&#39;;
fN[3] = &#39;\0&#39;; sN[3] = &#39;\0&#39;;
//result[0] = &#39;\0&#39;; result[1] = &#39;\0&#39;;

//result[2] = &#39;\0&#39;; result[3] = &#39;\0&#39;;
//result[4] = &#39;\0&#39;; result[5] = &#39;\0&#39;;
//result[6] = &#39;\0&#39;; result[7] = &#39;\0&#39;;
//outcw(0x80);
kS = 0; kF = 0;
state = WAIT;
RED = 1; YEL = 1; GRN = 1;
break;
}
if (key == &#39;#&#39; || key == &#39; &#39;) break;
if (kS == 4) break;
switch (key)
{
case &#39;0&#39;:
case &#39;1&#39;:
case &#39;2&#39;:
case &#39;3&#39;:
case &#39;4&#39;:
case &#39;5&#39;:
case &#39;6&#39;:
case &#39;7&#39;:
case &#39;8&#39;:
case &#39;9&#39;:
//inputNumber(sN, key);
outd(key);
sN[kS] = key;
kS++;
break;
}
case WAIT:

DelayMs(100);
if (key == 13) {clear_lcd(); outcw(0x80); state =
INPUT_FN; RED = 1; YEL = 1; GRN = 0; break;}
break;
}
}

}
void DelayMs(unsigned int m){ // задержка по таймеру
//unsigned char a;
//a = ms+(m&lt;&lt;1);
ms=0;
WMCON.WDTRST=1; // сброс сторожевого таймера
while(ms!=m) continue;
}

void Timer1InterruptHandler() org IVT_ADDR_ET1{

EA_bit = 0; // Clear global interrupt enable flag
TF1_bit = 0; // Ensure that Timer1 interrupt flag is cleared

TR1_bit = 0; // Stop Timer1
TH1 = 0xFC; // Reset Timer1 high byte 65536-1000
TL1 = 0x18; // Reset Timer1 low byte

//P0 = ~P0; // Toggle PORT0
ms++;

EA_bit = 1; // Set global interrupt enable flag
TR1_bit = 1; // Run Timer1

}

void INT0_Interrupt() org IVT_ADDR_EX0 {
EA_bit = 0;
lcd_led=~lcd_led;
EA_bit = 1;
}
/*
void UART_Interrupt() iv IVT_ADDR_ES {
if (RI_bit){
if (SBUF==0x13) {state=SR; RED=1; YEL=1; GRN=1;}
RI_bit=0;
}
if (TI_bit) TI_bit = 0;
}
*/