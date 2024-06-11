% Vn=10/3.6;
% b1=(2*Cf*lf/Iz);
% b2=(2*Cf*lf/Iz)*2*(Cf+Cr)/(m*Vn);
% a3=1;
% a2=Vn*Iz+2*Cf(1+lf)*++;
% a1=1;
% 
% Pn=tf([1,2*(Cf+Cr)/(m*(10/3.6)],[1,,1]);

ylsim=lsim(Td,ref,t)-lsim(Cfb*Td/(Cff+Cfb*Td),y,t);
ulsim=y;

Ty=Td/(Cff+Cfb*Td);

Pf=tf([1],[1]);%プレフィルタ
ylsim=lsim(Pf,ylsim,t);
ulsim=lsim(Pf,ulsim,t);

ulsim=ulsim';

pn=2;
% pn=3;
A=ones(pn,length(y));

v0=30/3.6;
Ts=tf([1],[0.01,1]);

A(1,:)=lsim(Ty,ulsim,t);
A(2,:)=lsim(Ty*tf([1,0],[1]),ulsim,t);
% A(3,:)=lsim(Ts*tf([1,0,0],[1]),ulsim,t);
A=A';
wp=pinv(A)*ylsim;
% wp=pinv(A)*lsim(Ts,ylsim,t);
Pm=tf([1],[wp(2),wp(1)]);

Cff=Td/Pm;