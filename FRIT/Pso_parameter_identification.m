% PSOのイメージ
% 
% 各個体は、群れ全体で見つけた最良値(グローバルベスト)と
% 自分だけで見つけた最良値(パーソナルベスト)に重みづけをして、
% 自分なりに探索してみる（移動速度を決める)
% 
% 
% load initialdata10_20201008.mat u
% load initialdata10_20201008.mat y

num=2;% 同定パラメータの数
% x=[Trv.Numerator{1,1}(3);Trv.Numerator{1,1}(4);Trv.Denominator{1,1}(1);Trv.Denominator{1,1}(2);Trv.Denominator{1,1}(3);Trv.Denominator{1,1}(4)];

x=[0.1;0.5];%FRIT
% x=[0.4;2.5;0.3;3];%VRFT

% k=100; % 粒子数 FRIT(ゲインスケジュール)
k=100; % 粒子数 FRIT(参照信号整形)

% it=100;% 反復回数(ゲインスケジュール)
it=100;% 反復回数(参照信号整形)

xm=rand(num,k);
xkb=rand(num,k); %各粒子位置の最良
xg=x; % 粒子全体の最良
xk=xm; % 粒子位置
vk=xm; % 粒子速度
xk_1=xm; % 粒子位置
vk_1=xm; % 粒子速度
tune_flag=1; %1ならFRIT,2ならVRFT

Jkb=1000000*rand(1,k); % 各粒子の最良評価値
Jgb=myfrit_op(x,t,y,u,Td,Pm,Cfb0,ref); % 全体最良評価値
c1=2; %係数1 グローバルベストの重みづけ
c2=1; %係数2 パーソナルベストの重みづけ
r1=rand(1); %乱数1
r2=rand(1);%乱数2
wmax=0.9; %最大慣性 探索範囲大
wmin=0.1; %最小慣性 探索範囲小
p_flag=0;
Jst=1000000*rand(it,1); % 各粒子の最良評価値

for i=1:it
    for j=1:k
        
        xp=xk(:,j);
        xk_1(:,j)=xk(:,j); %1つ前の値
        vk_1(:,j)=vk(:,j); %1前の値        
        for mn=1:num
            % 探索範囲の制約
            if xk(mn,j)<0
                xk(mn,j)=0.001;
                xp(mn)=0.001;
                %p_flag=1;
            end
            if xk(mn,j)>1000
                xk(mn,j)=1000;
                xp(mn)=1000;
                %p_flag=1;
            end    
        end
        
%         sim(model_name);
        JJ=myfrit_op(xp,t,y,u,Td,Pm,Cfb0,ref);
        if Jkb(1,j)>JJ
            Jkb(1,j)=JJ;% 各粒子の粒子位置
            xkb(:,j)=xk(:,j);
        end
        
        if Jgb>JJ
            Jgb=JJ; %全体の最良値を更新
            xg=xp;
        end
        
        r1=rand(1);%乱数
        r2=rand(1);%乱数
        w=wmax-(wmax-wmin)*(i/it);%% PSOの拡張機能(時間経過とともに慣性を収束)
        vk(:,j)=w*vk_1(:,j)+c1*r1*(xkb(:,j)-xk_1(:,j))+c2*r2*(xg-xk_1(:,j)); %速度更新
        xk(:,j)=xk_1(:,j)+vk(:,j); %位置更新
        p_flag=0;
        
    end
    

    disp(i);
    disp(Jgb);
    Jst(i)=Jgb;
%   if i==1
%         xp=x;
%         sim(model_name);
%         J=evaluation(y,ysim);
%         Jgb=J; % 全体最良評価値
%         Jkb=J*ones(1,k); % 各粒子の最良評価値
%     end

end
% Cfm2=tf([xg(1),xg(2)],[1,0]);

% Cff_n=tf([xg(1),xg(2)],[xg(3),xg(4)]);
% Po=Td/(Cfb*(1-Td));
