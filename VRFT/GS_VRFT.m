L=Td;
% L=tf([1],[0.1,1]);
% L=c2d(L,0.01);
% intg=tf(0.01,[1,-1],0.01);
intg=tf(1,[1,0]);

% xsf=[]

d=lsim(L,uu,tt);
eth=lsim(L*(1-Td)/Td,yy,tt);
eth_intg=lsim(intg,eth,tt);

temp1=zeros(length(y_m(1:end,2)),3);
temp2=zeros(length(y_m(1:end,2)),3);

xsf_y=yy*1;
xsf_v=vv*1;

count=0;
for i=1:length(yy)
    temp1(i,:)=[eth(i),eth(i)*xsf_v(i),eth(i)*xsf_v(i)*xsf_v(i)];
    temp2(i,:)=[eth_intg(i),eth_intg(i)*xsf_v(i),eth_intg(i)*xsf_v(i)*xsf_v(i)];
    count=count+1;
end
zig=[temp1,temp2];
wp=pinv(zig)*d;

%%
zig_n=[eth,eth_intg];
wp_n=pinv(zig_n)*d;
