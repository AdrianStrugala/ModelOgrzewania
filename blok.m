%clear all;
%close all;
%clc;

%parametry krzywych pogodowych
a1 = 9/4;
b1 = -9/4;

%LICZENIE PARAMETROW REGULATORA

k=0.004;
T=55400;
tau=3800;

%OPTYMALNE
% ZP = T/k/tau;
% ZI = 1/(tau + 0.35*T)*ZP;
% ZD =  0;

% %z PIDA
% ZP = 423.45;
% ZI = 0.0094;
% ZD = -6922777.85;
% ZN = 3.215e-05;

%Z-N
ZP = 0.9*T/k/tau;
ZI = 1/(tau/0.3)*ZP;
ZD = 0;

ts = 1000; %step time
%wartosci nominalne
%ts=0;
TzewN = -20;
TkzN = 90;
TkpN = 70;
Twew1N = 20;
Twew2N = 20;
qkN = 10000;
qg1 = qkN/2.2;
qg2 = qkN*1.2/2.2;

%parametry
Cpw = 4190; %cieplo wlasciwe wody
Cpp = 1005; %cieplo wlasciwe powietrz
Rp = 1.168; %gestosc powietrza
Rw = 1000;  %gestosc wody
Rs = 2300;  %gestosc scian
Cws = 1000; %cieplo wlasciwe scian

gs = 0.1;  %grubosc scian
pp = 60; %powierzchnia pomieszczenia
hp = 2.5;  %wysokosc scian
ps = sqrt(pp); %dlugosc pomieszczenia
Vp = pp*hp; %objetosc pomieszczenia
Vw = 0.2;  %objetosc grzejnika
Vk = 0.2;   %objetosc kotla

Cvs = Cws*Rs*ps*hp*gs; %pojemnosc cieplna scian=cw*ro*Vs
Cvg = Cpw*Rw*Vw;  %pojemnosc cieplna grzejnika
Cvw1 = Cpp*Rp*Vp;  %pojemnosc cieplna powietrza
Cvw = (Cvw1+Cvs)/2;     %%po korekcie
Cvk = Cpp*Rw*Vk;    %pojemonsc cieplna kotla

%obliczanie K
Kcw1 = qg1/(Twew1N-TzewN);
Kcw2 = qg2/(Twew2N-TzewN);
Kcg1 = qg1/(TkpN-Twew1N);
Kcg2 = qg2/(TkpN-Twew2N);

Kcs = Kcw1*(pp/ps)/2;

fmg1N = qg1/Cpw/(TkzN-TkpN);
fmg2N = qg2/Cpw/(TkzN-TkpN);

%obliczanie wartosci poczatkowych


Twew10 = Twew1N;
Twew20 = Twew2N;

Tgp10 = TkpN;
Tgp20 = TkpN;
Tkz0 = TkzN;
qk0 = qkN;

%WARTOSCI POCZATKOWE WEJSCIA
%USTALANIE PUNKTU PRACY

fmg1 = fmg1N*1;
fmg2 = fmg2N*1;

Tzew0 = TzewN;
Twewz = Twew1N-5;


%for i=0.001:0.001:0.2   %do charakterystyk statycznych
%fmg1 = i;

A = ...
    [-Kcg1-Kcs-Kcw1 Kcg1 Kcs 0 0 0;
     Kcg1 (-Cpw*fmg1-Kcg1) 0 0 Cpw*fmg1 0;
     Kcs 0 (-Kcg2-Kcs-Kcw2) Kcg2 0 0;
     0 0 Kcg2 (-Kcg2-Cpw*fmg2) Cpw*fmg2 0;
     0 Cpw*fmg1 0 Cpw*fmg2 -Cpw*(fmg1+fmg2) 1;
     -1 0 0 0 0 0];    
x = [Twew10; Tgp10; Twew20; Tgp20; Tkz0; qk0];
u = [Tzew0; Twewz];
B = ...
    [Kcw1 0;
     0 0;
     Kcw2 0;
     0 0;
     0 0;
     0 1];


x = -inv(A)*B*u;
Twew10 = x(1,1);
Tgp10 = x(2,1);
Twew20 = x(3,1);
Tgp20 = x(4,1);
Tkz0 = x(5,1);
qk0 = x(6,1);

fk10 = fmg1/Rw;
fk20 = fmg2/Rw;


%roznice wejsc
dqk = 0;%.1*qkN;
dTzew = 0;
dfk1 = 0;
dfk2 = 0;

q1 = 0; %dodatkowe ciepla w pomieszczeniach
q2 = 0%.1*qkN;


dTwew = 0;

%TERMOSTATY U PAW£A I GAW£A
dTwew1 = 2;
dTwew2 = 0;

%sim('dom2_sim');

%hold on;
%grid on;

% %TRANSMITANCJE
% plot(t,Twew1,'r');
%plot(t,Tkz-90,'r');
% plot(t,Twewm+Twew10,'r');
% plot(t,Twewm)
% plot(t,qko-qkN);
% plot(t,qkmp,'r');

% 
% d1=((Twewm+Twew10)-Twew1);
% d1m=max(abs(d1));
% d1=sum(d1.*d1);

% plot(t,Tgp);
% plot(t,Tgpm+Tgp10,'r');
% 
% d2=((Tgpm+Tgp10)-Tgp)
% d2m=max(abs(d2));
% d2=sum(d2.*d2);
% 
% %plot(fmg1,Twew10,'*');
% %plot(fmg1,Tgp10,'*');
% %end

