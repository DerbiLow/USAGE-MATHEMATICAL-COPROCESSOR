# USAGE-MATHEMATICAL-COPROCESSOR

<h1> ЛАБОРАТОРНАЯ РАБОТА № 3 <br>
Цель работы: изучение принципов выполнения арифметических команд с помощью математического сопроцессора FPU микропроцессоров с 
архитектурой x86 </h1> <br> <br> 
Исходное задание выглядит следующим образом: <br> 
![image](https://user-images.githubusercontent.com/126500303/228458222-603cb194-fc51-47dd-8360-410fbc8df2f3.png) <br>   <br> 
Для проверки задается три точки А(0;0), B(0;4), C(3;0) <br>
Чтобы проверить является ли треугольник прямоугольным необходимо:  <br> 
1. Вычислить координаты векторов, для этого из конечной кординаты вычитается начальная.  <br> 
2. Вычислить длину векторов, для этого необходимо вычислить квадратный корень из суммы квадратов координат вектора. <br>
3. По теореме Пифагора проверить является ли треугольник прямоугольным.  <br> <br>

Вычисление координат вектора и его длины будет показано на примере вектора АВ, для оставшихся двух векторов операции аналогичны. <br>
А(0;0) и B(0;4), тогда координаты вектора АВ (0-0;4-0) = (0;4) <br>
Далее начинается вычисление длины вектора, для этого каждая координата вектора возводится в квадрат, а после они суммируются 4*4+0*0 = 16. <br>
Для вычисления корня необходимо подключить математический сопроцессор <br>
FINIT Инициализация математического сопроцессора. <br>
FLD AB Перемещение значения суммы квадратов двух кординат АВ из переменной в верхнюю часть стека st(0). <br>
FSQRT Вычисление квадратного корня значения st(0). <br>
FSTP AB Возврат значения в переменную АВ из st(0), при этом st(0) очищается (стэк сдвигается вверх). <br>
После выполнения всех результатов получаются значения длин векторов. <br> <br>

Для проверки теоремы Пифогора все длины векторов возводятся в квадрат. <br>
После в цикле два предполагаемых катета складываются, эта сумма сравнивается с предполагаемой гипотенузой. <br>
Если сумма катетов равна гипотенузе, то значеине rez = 1 показывает, что треугольник прямоугольный. <br>
Если сумма катетов не равна гипотенузе, то продолжается перебор всех возможных вариантов предполагаемых катетов и предполагаемой гипотенузы. <br>
Если таковой комбинации нет, то значеине rez = 0 показывает, что треугольник не прямоугольный. <br> <br>

Результат проверки для прямоугольного треугольника с координатами А(0;0), B(0;4), C(3;0) <br>
![image](https://user-images.githubusercontent.com/126500303/228457058-619b60b9-84b4-43ae-b9b7-dc92b28a9bb9.png) <br> <br>

Результат проверки для не прямоугольного треугольника с координатами А(0;0), B(0;4), C(3;1) <br>
![image](https://user-images.githubusercontent.com/126500303/228457544-bafb547c-8068-4c48-911d-6eea19643ce3.png) <br> <br>

Так как математический сопроцессор хранит данные в виде, в котором они невоможны для восприятия человеком. Для верефикации результатов была создана программа на C++<br>

Код программы C++ <br>
![C++](https://github.com/DerbiLow/USAGE-MATHEMATICAL-COPROCESSOR/assets/126500303/7fdaa44d-e805-4c82-8739-263bccc82846) <br>
![С++](https://github.com/DerbiLow/USAGE-MATHEMATICAL-COPROCESSOR/assets/126500303/fad8321f-73ed-4947-8a7e-37cc318d7bd2) <br>

Верификация результатов: <br>
![Ver1](https://github.com/DerbiLow/USAGE-MATHEMATICAL-COPROCESSOR/assets/126500303/08ea690a-6875-4831-b6d5-ebb9ffe49d45) <br>
![Ver2](https://github.com/DerbiLow/USAGE-MATHEMATICAL-COPROCESSOR/assets/126500303/c836a86f-33c5-4e15-a9e6-08a2bd321851) <br>
![Ver3](https://github.com/DerbiLow/USAGE-MATHEMATICAL-COPROCESSOR/assets/126500303/9ac8d0a0-eef8-4f43-a357-9064e2a29fda) <br>

Скорость работы программы на assembler:<br>
![image](https://github.com/DerbiLow/USAGE-MATHEMATICAL-COPROCESSOR/assets/126500303/52cc9247-91fe-4663-b546-f1910be53d7e)<br>
Скорость работы программы на C++: <br>
![image](https://github.com/DerbiLow/USAGE-MATHEMATICAL-COPROCESSOR/assets/126500303/d5275361-b7fa-4114-ab4f-99c532e99649) <br>

Таким образом, программа на C++ медленнее, чем assembler примерно в 5 раз.<br>
Код программы assembler представлен в файле Code2.txt (проект в LABA 3 assembler) <br>
Код программы C++ представлен в файле Ver3.txt (проект в ConsoleApplication51)

