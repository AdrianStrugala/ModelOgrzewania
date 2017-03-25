clear all;

%wartoœci nominalne
TzewN=-20;
TwewN=20;
TgzN=90;
TgpN=70;
PgN=10000;

TkzN=90;
TkpN=70;
qkN=10000;

%parametry
Cpw=4190;
Cpp=1005;
Rp=1.168;
Rw=1000;
Vw=2;
Vp=150;

Vk=2;


Cvg=Cpw*Rw*Vp;  %??
Cvw=Cpp*Rp*Vw;  %??
%Cvw=Cvg;     %%po korekcie

Cvk=Cpp*Rw*Vk;

%obliczanie K
Kcw=PgN/(TwewN-TzewN);
Kcg=PgN/(TgpN-TwewN);
fgN=PgN/((TgzN-TgpN)*Rw*Cpw);

fkN=qkN/((TkzN-TkpN)*Rw*Cpw);

fmg=Rw*fgN;

dTzew=0;
dTgz=0;
dfg=0;

dfk=0;

Tzew0=TzewN;
Tgz0=TgzN;
fg0=fgN;

Tkp0=TkpN;
qk0=qkN;
fk0=fkN;

Twew0=(Cpw*fmg*Kcg*Tgz0+Kcw*(Kcg+Cpw*fmg)*Tzew0)/(Kcg*Kcw+Cpw*fmg*(Kcg+Kcw));
%Tgp0=((Kcg+Kcw)*Tgz0-Kcw*Tzew0)/Kcg;

Tgp0=Kcw*(Twew0-Tzew0)/Kcg+Twew0;

%Twew0=TwewN;
%Tgp0=TgpN;

%kocio³
Tkz0=qk0/((Cpw*Rw*fk0))+Tkp0;

%sim('dom_sim');
