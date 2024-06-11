function [kp,ki,kd]=myVRFT(y,u,t,Td)
L=Td;%プレフィルタ(カスタマイズした場合はここを変更)
pn=3;
A=ones(pn,length(y));

intg=tf([1],[1,0]); %積分
dif=tf([1,0],[0.05,1]);% 微分

A(1,:)=lsim(L*(1-Td)/Td,y,t);
A(2,:)=lsim(L*intg*(1-Td)/Td,y,t);
A(3,:)=lsim(L*dif*(1-Td)/Td,y,t);
A=A';

ul=lsim(L,u,t);
wp=pinv(A)*ul;

kp=wp(1);%調整後比例ゲイン
ki=wp(2);%調整後積分ゲイン
kd=wp(3);%調整後微分
