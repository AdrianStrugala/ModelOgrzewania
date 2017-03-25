clear all; close all; clc;

k=0.004;
T=55400;
tau=3800;

%Pogodowe
k=0.011;
T=30000;
tau=0;

%OPTYMALNE
% ZP = T/k/tau;
% ZI = 1/(tau + 0.35*T)*ZP;
% 
% %Z Z-N
% ZP = 0.9*T/k/tau;
% ZI = 1/(tau/0.3)*ZP;
% ZD = 0;

%Z Z-N
ZP = 0.15309*5.3*10^3;
ZI = 0.15309;

ZD = 0.07*6.2*10^3;

s = tf('s');

%SISOTOOL
%obiekt = tf((0.004*exp(-s*tau))/(55400*s+ 1));
%reg = tf([ZP, ZI],[1 0]);

%OBIEKT
obiekt = tf((0.011)/(T*s+ 1));   %Tkz(qk)
reg = tf([ZP ZI],[1 0]);

%reg = tf([2.55e+03 0.182],[1 0]);

wyX = feedback(obiekt*reg,1); %uk³ad zamkniêty
%stepplot((obiekt))
%hold on;
test = tf(1/(s*(s^2+4)));

%pole(test)
pole(wyX)
pzmap(wyX)
%bodeplot(obiekt*reg)
%stepplot(wyX);
%wy = pade(wyX)
%impulseplot(wy)
%stepplot(obiekt)
%bodeplot(wy)
%bodeplot(obiekt*reg)
%sisotool(obiekt,reg);