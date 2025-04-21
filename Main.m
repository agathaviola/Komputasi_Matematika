%Definisikan fungsi
f = inline('x^2 - 3', 'x');

%Interval [1,2]
X = [1,2];

%Panggil fungsi BagiDua
[x, galat] = bagidua_1(f, X);

%panggil fungsi PosisiPalsu
disp('akar hampiran = ');
disp(x)
disp('galat = ')
disp(galat)