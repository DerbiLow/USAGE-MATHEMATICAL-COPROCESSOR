.686
.model flat,stdcall
.stack 100h
.data
;/*����� �*/
x dd 0
y dd 0
;/*����� �*/
xx dd 0
yy dd 4
;/*����� �*/
xxx dd 3
yyy dd 0
;/*����� ��������*/
AB dd ?
AC dd ?
BC dd ?

p dd ?
rez dd ?


.code
ExitProcess PROTO STDCALL :DWORD
Start:

mov eax, x; /*�������� �������� ��*/
mov ebx, xx ; /*�������� �������� ��*/
sub ebx, eax ; /*���������� ������ ��������� ������� ��*/
mov ecx, ebx; /*���������� ������ ��������� ������� ��*/

mov eax, y; /*�������� �������� ��*/
mov ebx, yy; /*�������� �������� ��*/
sub ebx, eax; /*���������� ������ ��������� ������� ��*/
mov p, ebx; /*���������� ������ ��������� ������� ��*/

; /*���������� � � �������*/
mov eax, ecx;
mov ebx, ecx;
mul ebx
mov ecx, eax;

; /*���������� � � �������*/
mov eax, p;
mov ebx, p;
mul ebx

; /*���������� ����� ��*/
add eax, ecx
mov AB, eax
FINIT; /*������������� FPU*/
FLD AB; /*����� ����� �� ������ � ��������� ��� � st(0)*/
FSQRT; /*��������� ���������� ������*/
FSTP AB; /*���������� ��������� � ���������� ��*/
mov eax, AB


mov eax, x; /*�������� �������� ��*/
mov ebx, xxx ; /*�������� �������� C�*/
sub ebx, eax ; /*���������� ������ ��������� ������� �C*/
mov ecx, ebx; /*���������� ������ ��������� ������� �C*/

mov eax, y; /*�������� �������� ��*/
mov ebx, yyy; /*�������� �������� C�*/
sub ebx, eax; /*���������� ������ ��������� ������� �C*/
mov p, ebx; /*���������� ������ ��������� ������� �C*/

; /*���������� � � �������*/
mov eax, ecx;
mov ebx, ecx;
mul ebx
mov ecx, eax;

; /*���������� � � �������*/
mov eax, p;
mov ebx, p;
mul ebx

; /*���������� ����� �C*/
add eax, ecx
mov AC, eax
FINIT
FLD AC
FSQRT
FSTP AC


mov eax, xx; /*�������� �������� B�*/
mov ebx, xxx ; /*�������� �������� C�*/
sub ebx, eax ; /*���������� ������ ��������� ������� BC*/
mov ecx, ebx; /*���������� ������ ��������� ������� BC*/

mov eax, yy; /*�������� �������� B�*/
mov ebx, yyy; /*�������� �������� C�*/
sub ebx, eax; /*���������� ������ ��������� ������� BC*/
mov p, ebx; /*���������� ������ ��������� ������� BC*/

; /*���������� � � �������*/
mov eax, ecx;
mov ebx, ecx;
mul ebx
mov ecx, eax;

; /*���������� � � �������*/
mov eax, p;
mov ebx, p;
mul ebx

; /*���������� ����� BC*/
add eax, ecx
mov BC, eax
FINIT
FLD BC
FSQRT
FSTP BC

; /*���������� � ������� ���� ���� ������ ������������ ��� �������� ������� �������*/
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

mov ecx, 3; /*���-�� �������� �����*/
mov edx, 3
mov ebx, 2
begin:
cmp edx, ecx;/*��������� ����� 3=3*/
jne Next; /*���� ����� �� �����, �� ��������� � Next, ����� ���������� ��������� �������� */
mov eax, AB
add eax, AC; /*��������� �������� �������������� �������*/
cmp eax, BC; /*���������� � ��������� �����������*/
jne Ed; /*���� ����� �� �����, �� ��������� � ����� �����, ����� ���������� */
mov rez, 1; /*rez = 1 - ����������� �������������, rez = 0 - ����������� �� ������������� */
jmp Go; /*����� �� �����*/

Next:
cmp ebx, ecx; /*��������� ����� 2=2*/
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
Invoke ExitProcess, rez; /*����� ���������� �� �����*/
End Start