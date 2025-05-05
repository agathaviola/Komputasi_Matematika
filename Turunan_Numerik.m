%Fungsi eksak
f = @(x) 2*x;
%Titik evaluasi
x = 1;
%Daftar nilai h
h_values = 0.01;
%h_values = [1e-1, 1e-2, 1e-3, 1e-4];
%Turunan eksak
df_exact = 2;
disp('--Perbandingan Turunan Numerik untuk f(x) = 2x --')
%loop untuk tiap nilai h
%for i = 1:5
for i = 1:5
    h = h_values;
    %Metode beda maju
    df_forward = (f(x + h)-f(x))/h;
    %Metode beda mundur
    df_backward = (f(x)-f(x-h))/h;
    %Metode beda tengah
    df_central = (f(x+h)-f(x - h))/(2*h);
    %Tampilkan hasil
    disp(['h = ', num2str(h)])
    disp(['Beda Maju    : ', num2str(df_forward)])
    disp(['Beda Mundur  : ', num2str(df_backward)])
    disp(['Beda Tengah  : ', num2str(df_central)])
    disp(['Turunan Eksak: ', num2str(df_exact)])
    disp('')
    end 