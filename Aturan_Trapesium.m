% Aturan Trapesium untuk contoh 10.1

function Tn = trapesium(f,x,n)

 % Trapesium Menyelesaikan integral f(x) atas interval[a,b] menggunakan
 % Aturan trapesium dengann sub interval
 % Input: 
 % f = fungsi yang di integralkan
 % x = vektor [ab]
 % n = lebar langkah/banyak sub interval dalam interval x
 % Output:
 % Tn = luas bidang data r yang dibatasi oleh f(x)dan sumbu x dalam
 
% Fungsi dan interval
f = @(x) 2*x.^3;    % Definisi fungsi
a = 0;              % Titik awal dari interval
b = 1;              % Titik akhir dari interval
n = 10;             
h = (b-a)/n;

% Titik-titik pada interval
x = a:h:b;
y = f(x);

% Hitung menggunakan aturan trapesium
Tn = h/2 * (y(1) + 2*sum(y(2:end-1)) + y(end));

fprintf('Hasil menggunakan Aturan Trapesium: %.4f\n', Tn);
