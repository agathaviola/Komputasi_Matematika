% Metode Gauss-Seidel untuk Contoh 4.1

% Matriks koefisien A dan vektor b
A = [10 -1 2 0; 
    -1 11 -1 3; 
    2 -1 10 -1; 
    0 3 -1 8];
b = [6; 25; -11; 15];

% Nilai awal
x = zeros(4,1);

% Toleransi dan iterasi maksimum
tol = 1e-6;
N = 100;

% Cetak iterasi ke-0
fprintf('Iterasi 0: x1 = %.4f, x2 = %.4f, x3 = %.4f, x4 = %.4f\n', x(1), x(2), x(3), x(4));

for k = 1:N
    x_old = x;

    % Update dengan metode Gauss-Seidel
    x(1) = (1/10)*(6 + x(2) - 2*x(3));
    x(2) = (1/11)*(25 + x(1) + x(3) - 3*x(4));
    x(3) = (1/10)*(-11 + 2*x(1) - x(2) + x(4));
    x(4) = (1/8)*(15 - 3*x(2) + x(3));

    % Tampilkan hasil iterasi
    fprintf('Iterasi %d: x1 = %.4f, x2 = %.4f, x3 = %.4f, x4 = %.4f\n', k, x(1), x(2), x(3), x(4));

    % Cek konvergensi (norma infinity)
    if norm(x - x_old, inf) < tol
        break;
    end
end
