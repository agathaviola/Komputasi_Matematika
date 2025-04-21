%WHILE TEBAK ANGKA
tebakan = 0;
angka_tebakan = 12;
while tebakan ~= angka_tebakan
    tebakan = input('Tebak angka: ');
    if tebakan < angka_tebakan
        disp('Angka tebakan masih kurang');
    elseif tebakan > angka_tebakan
        disp('Angka tebakan terlalu tinggi');
    end
end
disp('Selamat tebakan anda benar!');
