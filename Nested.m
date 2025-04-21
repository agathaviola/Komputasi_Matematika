%NESTED
%Program Barisan Fibonacci
n = input('Masukkan suku ke-n = ');
v = [1 1];
for u=3:1:n
    a=u-1;b=u-2
    v(u)=v(a)+v(b)
end
disp(v);
