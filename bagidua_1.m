%METODE BAGI DUA
function [x, galat] = BagiDua(f, X, N, tol)
%inputan
% f = fungsi
% x = interval dari [a,b] dimana a<b
% N = maksimum iterasi
% tol = 1e-3

%output 
% x = akar
% galat = error
if nargin < 4, tol = 1e-3; end
if nargin < 3, N = 100; end

a = X(1);
b = X(2);
x = (a+b)/2;
n = 1;
galat = 1;

while(n <= N && galat > tol)
    if f(a)*f(x)< 0
        b = x
    elseif f(a)*f(x)> 0
        a = x;
    else 
        break;
    end
    xnew = (a+b)/2;
    galat = abs((xnew-x)/xnew)*100;
    x = xnew;
    n = n+1;
end
end