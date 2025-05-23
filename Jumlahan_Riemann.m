% Jumlahan Riemann untuk contoh 10.1

function R = riemann(f,x,n)

% Jumlah Riemann Menyelesaikan integral f(x) atas interval [a,b] menggunakan
% Jumlah Riemann dengan n sub interval
% Input: 
% f = fungsi yang diintegralkan
% x = vektor [a b]
% n = jumlah sub interval dalam interval x
% Output:
% R = jumlah Riemann dari f(x) pada interval [a, b]

% Fungsi dan interval
f = @(x) 2*x.^3;    % Definisi Fungsi
a = 0;              % Titik awal dari interval
b = 1;              % Titik akhir dari interval
n = 10;             
h = (b-a)/n;

% Riemann tengah
x_mid = a + h/2 : h : b - h/2;

% Hitung menggunakan Jumlahan Riemann
R_mid = sum(f(x_mid)) * h;                 

% Riemann Kiri
x_left = a : h : b - h; 
R_left = sum(f(x_left)) * h;

% Riemann Kanan
x_right = a + h : h : b; 
R_right = sum(f(x_right)) * h;

fprintf('Hasil dengan Jumlahan Riemann Tengah: %.4f\n', R_mid);
fprintf('Hasil dengan Jumlahan Riemann Kiri: %.4f\n', R_left);
fprintf('Hasil dengan Jumlahan Riemann Kanan: %.4f\n', R_right);