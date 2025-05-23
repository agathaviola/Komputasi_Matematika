%Metode Jacobi untuk contoh 4.1
%Jacobi method - Contoh 4.1

% Matriks A dan vektor b
A = [10 -1 2 0;
    -1 11 -1 3;
     2 -1 10 -1;
     0 3 -1 8];
b = [6; 25; -11; 15];

% Nilai awal
x_j = [0; 0; 0; 0];

% Tampilkan hasil untuk iterasi 0
fprintf('Iterasi %d: x1 = %.4f, x2 = %.4f, x3 = %.4f, x4 = %.4f\n', ...
    0, x_j(1), x_j(2), x_j(3), x_j(4));

% Lakukan iterasi hingga 4 kali
for k = 1:4
    % Hitung dengan metode Jacobi
    x1 = (1/10)*(6 + x_j(2) - 2*x_j(3));
    x2 = (1/11)*(25 + x_j(1) + x_j(3) - 3*x_j(4));
    x3 = (1/10)*(-11 - 2*x_j(1) + x_j(2) + x_j(4));
    x4 = (1/8)*(15 - 3*x_j(2) + x_j(3));
    
    % Simpan hasil iterasi ke dalam vektor baru
    x_n = [x1; x2; x3; x4];
    
    % Tampilkan hasil iterasi ke-k
    fprintf('Iterasi %d: x1 = %.4f, x2 = %.4f, x3 = %.4f, x4 = %.4f\n', k, x_n(1), x_n(2), x_n(3), x_n(4));
    
    % Update nilai untuk iterasi berikutnya
    x_j = x_n;
end
