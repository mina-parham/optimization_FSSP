sets
i / 1*3/
j /1*9/ ;
alias(j,j1);

parameters
d(j)
/1 23
 2 22
 3 22
 4 27
 5 26
 6 33
 7 29
 8 29
 9 31/;

table t(i,j)
     1  2  3  4  5  6  7  8  9
  1  2  5  4  1  2  5  1  3  2
  2  5  1  1  3  2  4  5  4  3
  3  2  1  2  1  4  3  4  1  5    ;

parameters
p(i,j,j);
p(i,j,j)=round(uniform(0,10));

variables
y(i,j,j)
a(i,j)
b(i,j)
x(i,j)
w
f1(i,j)
f2(i,j)
z

nonnegative variable x(i,j)
binary variable a(i,j)
binary variable b(i,j)
binary variable y(i,j,j)
nonnegative variable w
binary variables f1
binary variables f2;

equations
objectivefunction
equ1
equ2
equ3
equ4
equ5
equ6
equ7
equ8
equ9
equ10
equ11
equ12
equ13
;

objectivefunction ..    z =e= w  ;

equ1(j) ..              w =g= x('3',j)+t('3',j);
equ2(i,j)$(ord(i)<3) .. x(i,j)+ t(i,j) =l= x(i+1,j);

equ3(i) ..              sum(j,a(i,j))=e= 1;
equ4(i)..               sum(j,b(i,j))=e= 1;

equ5(i,j,j1)$(ord(j) ne ord(j1)).. x(i,j) + t(i,j)+p(i,j,j1) =l= x(i,j1)+ 100*(1-y(i,j,j1));

equ6 (i,j) ..         a(i,j) =g= 1-100*(1-f1(i,j));
equ7(i,j) ..          sum(j1 $(ord(j) ne ord(j1)),y(i,j1,j)) =g= 1-100*f1(i,j);
equ8(i,j) ..          sum(j1 $(ord(j) ne ord(j1)),y(i,j1,j)) =l= 1+100*f1(i,j);

equ9(i,j) ..          b(i,j) =g= 1-100*(1-f2(i,j));
equ10(i,j)..         sum(j1 $(ord(j) ne ord(j1)),y(i,j,j1)) =g= 1-100*f2(i,j);
equ11(i,j) ..        sum(j1 $(ord(j) ne ord(j1)),y(i,j,j1)) =l= 1+100*f2(i,j);

equ12(i,j) ..        f1(i,j)+f2(i,j) =l=1;

equ13(j) ..          x('3',j)+t('3',j) =l= d(j);

model process /all/;
solve process using MIP minimizing z;
display z.l ,x.l, y.l,a.l , b.l;
option MIP=CPLEX;


