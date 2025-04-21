clc
clear

%METODE BAGI DUA
function [x, galat] = bagidua_1(f, X, N, tol)
%inputan
% f = fungsi
% x = interval dari [a,b] dimana a<b
% N = maksimum iterasi
% tol = 1e-3

%output 
% x = akar
% galat = error
