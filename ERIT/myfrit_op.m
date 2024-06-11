function J = myfrit_op(x,t,y,ref,Cfb,Cff,Td)
% N=100;
% Td=tf(1,[0.5,1]); %実験
% Cff_n=tf([x(1),x(2)],[x(3),x(4)]);　%実験
% Td=tf(1,[0.25,1])*tf(1,[0.25,1]); %sim 非最小 and siceac 0621
Pm=tf([x(1),x(2)],[x(3),x(4),x(5)]); %sim 最小 0621

% Cff_n=tf([x(1),x(2),x(3)],[x(4),x(5),x(6)]);%sim sice ac
Cff_n=Td/Pm;%sim

% Tn=tf([1,x(1),x(2)],[1,x(3),x(4)]);
% Tn=tf([1,2*x(1)*x(2)*x(3),x(3)*x(3)],[1,2*x(2)*x(3),x(3)*x(3)]);

yr=lsim((Cfb*Td+Cff_n)/(Cfb*Td+Cff),y,t);
yd=lsim(Td,ref,t);
e=yd-yr;

%VRFT------------------------%
% ur=lsim(Tn*Cfb*(1/Td-1),y,t);
% e=u-ur;

J=sum((e).*(e)/(length(e)));% 評価関数計算
end