% PSO�̃C���[�W
% 
% �e�̂́A�Q��S�̂Ō������ŗǒl(�O���[�o���x�X�g)��
% ���������Ō������ŗǒl(�p�[�\�i���x�X�g)�ɏd�݂Â������āA
% �����Ȃ�ɒT�����Ă݂�i�ړ����x�����߂�)
% 
% 
% load initialdata10_20201008.mat u
% load initialdata10_20201008.mat y

num=2;% ����p�����[�^�̐�
% x=[Trv.Numerator{1,1}(3);Trv.Numerator{1,1}(4);Trv.Denominator{1,1}(1);Trv.Denominator{1,1}(2);Trv.Denominator{1,1}(3);Trv.Denominator{1,1}(4)];

x=[0.1;0.5];%FRIT
% x=[0.4;2.5;0.3;3];%VRFT

% k=100; % ���q�� FRIT(�Q�C���X�P�W���[��)
k=100; % ���q�� FRIT(�Q�ƐM�����`)

% it=100;% ������(�Q�C���X�P�W���[��)
it=100;% ������(�Q�ƐM�����`)

xm=rand(num,k);
xkb=rand(num,k); %�e���q�ʒu�̍ŗ�
xg=x; % ���q�S�̂̍ŗ�
xk=xm; % ���q�ʒu
vk=xm; % ���q���x
xk_1=xm; % ���q�ʒu
vk_1=xm; % ���q���x
tune_flag=1; %1�Ȃ�FRIT,2�Ȃ�VRFT

Jkb=1000000*rand(1,k); % �e���q�̍ŗǕ]���l
Jgb=myfrit_op(x,t,y,u,Td,Pm,Cfb0,ref); % �S�̍ŗǕ]���l
c1=2; %�W��1 �O���[�o���x�X�g�̏d�݂Â�
c2=1; %�W��2 �p�[�\�i���x�X�g�̏d�݂Â�
r1=rand(1); %����1
r2=rand(1);%����2
wmax=0.9; %�ő劵�� �T���͈͑�
wmin=0.1; %�ŏ����� �T���͈͏�
p_flag=0;
Jst=1000000*rand(it,1); % �e���q�̍ŗǕ]���l

for i=1:it
    for j=1:k
        
        xp=xk(:,j);
        xk_1(:,j)=xk(:,j); %1�O�̒l
        vk_1(:,j)=vk(:,j); %1�O�̒l        
        for mn=1:num
            % �T���͈͂̐���
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
            Jkb(1,j)=JJ;% �e���q�̗��q�ʒu
            xkb(:,j)=xk(:,j);
        end
        
        if Jgb>JJ
            Jgb=JJ; %�S�̂̍ŗǒl���X�V
            xg=xp;
        end
        
        r1=rand(1);%����
        r2=rand(1);%����
        w=wmax-(wmax-wmin)*(i/it);%% PSO�̊g���@�\(���Ԍo�߂ƂƂ��Ɋ���������)
        vk(:,j)=w*vk_1(:,j)+c1*r1*(xkb(:,j)-xk_1(:,j))+c2*r2*(xg-xk_1(:,j)); %���x�X�V
        xk(:,j)=xk_1(:,j)+vk(:,j); %�ʒu�X�V
        p_flag=0;
        
    end
    

    disp(i);
    disp(Jgb);
    Jst(i)=Jgb;
%   if i==1
%         xp=x;
%         sim(model_name);
%         J=evaluation(y,ysim);
%         Jgb=J; % �S�̍ŗǕ]���l
%         Jkb=J*ones(1,k); % �e���q�̍ŗǕ]���l
%     end

end
% Cfm2=tf([xg(1),xg(2)],[1,0]);

% Cff_n=tf([xg(1),xg(2)],[xg(3),xg(4)]);
% Po=Td/(Cfb*(1-Td));
