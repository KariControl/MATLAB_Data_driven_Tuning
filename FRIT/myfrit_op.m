function J = myfrit_op(x,t,y,u,Td,Pm,Cfb0,r)

% [Am,Bm,Cm,Dm]=tf2ss(Td.num{1,1},Td.den{1,1});
% Hm=ss(Am,Bm,Cm,Dm);

Kp=x(1);
Ki=x(2);

Cfb=Kp*tf([1],[1])+Ki*tf([1],[1,0]);

rd=lsim(1/(Cfb),u,t)+y;% 擬似参照信号

% r=lsim(1/(C*Tn+Cn),(u+lsim(C,y,t)),t);
e=y-lsim(Td,rd,t); % 規範モデルから偏差計算
J=sum((e).*(e)/(length(e)));% 評価関数計算

end