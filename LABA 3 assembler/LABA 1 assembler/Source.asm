.686
.model flat,stdcall
.stack 100h
.data
;/*Точка А*/
x dd 0
y dd 0
;/*Точка В*/
xx dd 0
yy dd 4
;/*Точка С*/
xxx dd 3
yyy dd 0
;/*Длины векторов*/
AB dd ?
AC dd ?
BC dd ?

p dd ?
rez dd ?


.code
ExitProcess PROTO STDCALL :DWORD
Start:

mov eax, x; /*Передача значения Ах*/
mov ebx, xx ; /*Передача значения Вх*/
sub ebx, eax ; /*Вычисление первой кординаты вектора АВ*/
mov ecx, ebx; /*Сохранение первой кординаты вектора АВ*/

mov eax, y; /*Передача значения Ау*/
mov ebx, yy; /*Передача значения Ву*/
sub ebx, eax; /*Вычисление второй кординаты вектора АВ*/
mov p, ebx; /*Сохранение второй кординаты вектора АВ*/

; /*Возведение Х в квадрат*/
mov eax, ecx;
mov ebx, ecx;
mul ebx
mov ecx, eax;

; /*Возведение У в квадрат*/
mov eax, p;
mov ebx, p;
mul ebx

; /*Вычисление длины АВ*/
add eax, ecx
mov AB, eax
FINIT; /*Инициализация FPU*/
FLD AB; /*Выбор числа из памяти и помещение его в st(0)*/
FSQRT; /*Вычисляем квадратный корень*/
FSTP AB; /*Записываем результат в переменную АВ*/
mov eax, AB


mov eax, x; /*Передача значения Ах*/
mov ebx, xxx ; /*Передача значения Cх*/
sub ebx, eax ; /*Вычисление первой кординаты вектора АC*/
mov ecx, ebx; /*Сохранение первой кординаты вектора АC*/

mov eax, y; /*Передача значения Ау*/
mov ebx, yyy; /*Передача значения Cу*/
sub ebx, eax; /*Вычисление второй кординаты вектора АC*/
mov p, ebx; /*Сохранение второй кординаты вектора АC*/

; /*Возведение Х в квадрат*/
mov eax, ecx;
mov ebx, ecx;
mul ebx
mov ecx, eax;

; /*Возведение У в квадрат*/
mov eax, p;
mov ebx, p;
mul ebx

; /*Вычисление длины АC*/
add eax, ecx
mov AC, eax
FINIT
FLD AC
FSQRT
FSTP AC


mov eax, xx; /*Передача значения Bх*/
mov ebx, xxx ; /*Передача значения Cх*/
sub ebx, eax ; /*Вычисление первой кординаты вектора BC*/
mov ecx, ebx; /*Сохранение первой кординаты вектора BC*/

mov eax, yy; /*Передача значения Bу*/
mov ebx, yyy; /*Передача значения Cу*/
sub ebx, eax; /*Вычисление второй кординаты вектора BC*/
mov p, ebx; /*Сохранение второй кординаты вектора BC*/

; /*Возведение Х в квадрат*/
mov eax, ecx;
mov ebx, ecx;
mul ebx
mov ecx, eax;

; /*Возведение У в квадрат*/
mov eax, p;
mov ebx, p;
mul ebx

; /*Вычисление длины BC*/
add eax, ecx
mov BC, eax
FINIT
FLD BC
FSQRT
FSTP BC

; /*Возведение в квадрат длин всех сторон треугольника для проверки теоремы Пифогра*/
mov eax, AB
mov ebx, AB
mul ebx
mov AB, eax

mov eax, AC
mov ebx, AC
mul ebx
mov AC, eax

mov eax, BC
mov ebx, BC
mul ebx
mov BC, eax

mov ecx, 3; /*Кол-во итераций цикла*/
mov edx, 3
mov ebx, 2
begin:
cmp edx, ecx;/*Сравнение чисел 3=3*/
jne Next; /*Если числа не равны, то переходим в Next, иначе продолжаем выполнять операции */
mov eax, AB
add eax, AC; /*Суммируем квадраты предполагаемых катетов*/
cmp eax, BC; /*Сравниваем с вероятной гипотенузой*/
jne Ed; /*Если числа не равны, то переходим в конец цикла, иначе продолжаем */
mov rez, 1; /*rez = 1 - Треугольник прямоугольный, rez = 0 - Треугольник не прямоугольный */
jmp Go; /*Ввход из цикла*/

Next:
cmp ebx, ecx; /*Сравнение чисел 2=2*/
jne Last 
mov eax, AB
add eax, BC
cmp eax, AC
jne Ed
mov rez, 1
jmp Go

Last: 
mov eax, AC
add eax, BC
cmp eax, AB
jne Ed
mov rez, 1
jmp Go

Ed:
mov rez, 0
loop begin

Go:
exit:
Invoke ExitProcess, rez; /*вывод результата на экран*/
End Start