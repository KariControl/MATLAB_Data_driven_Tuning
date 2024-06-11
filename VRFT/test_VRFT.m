%test_VRFT.m
close all
clear
%テストデータ生成処理(初期制御器による初期シミュレーション

kp0=0.1;%比例ゲイン(初期値)
ki0=0.5;%積分ゲイン(初期値)
kd0=0.01;%微分ゲイン(初期値)

P=tf([1],[1,1]);%制御対象
Cfb=kp0*tf([1],[1])+ki0*tf([1],[1,0])+kd0*tf([1,0],[0.05,1]);%初期制御器
t=(0:0.01:5)';%シミュレーション時間(サンプリング0.01s)
ref=ones(length(t),1);%目標値計算処理
ref(1)=0;%目標値計算処理(ステップ指令)

y=lsim(P*Cfb/(1+P*Cfb),ref,t);%閉ループ系の出力信号シミュレーション
u=lsim(Cfb/(1+P*Cfb),ref,t);%閉ループ系の制御入力シミュレーション

Ts=0.5;%規範モデルの時定数
Td=tf([1],[Ts,1]);%規範モデル
[kp,ki,kd]=myVRFT(y,u,t,Td);
Cfb=kp*tf([1],[1])+ki*tf([1],[1,0])+kd*tf([1,0],[0.05,1]);%制御器更新

ya=lsim(P*Cfb/(1+P*Cfb),ref,t);%閉ループ系の出力信号シミュレーション(調整後)
ua=lsim(Cfb/(1+P*Cfb),ref,t);%閉ループ系の制御入力シミュレーション(調整後)

% 初期シミュレーション結果のプロット
figure(1)
plot(t,y,'linewidth',8);
hold on;
plot(t,ref,'-.','linewidth',8);
hold on;
plot(t,lsim(Td,ref,t),':','linewidth',8);
hold on;
xlabel('Time [s]');
ylabel('Output');
legend('Output','reference','desired');
hold on;
set(gca,'FontSize',45);
xlim([0 5]);

% 調整後シミュレーション結果のプロット
figure(2)
plot(t,ya,'linewidth',8);
hold on;
plot(t,ref,'-.','linewidth',8);
hold on;
plot(t,lsim(Td,ref,t),':','linewidth',8);
hold on;
xlabel('Time [s]');
ylabel('Output');
legend('Output','reference','desired');
hold on;
set(gca,'FontSize',45);
xlim([0 5]);
