% PSO�̃C���[�W
% 
% �e�̂́A�Q��S�̂Ō������ŗǒl(�O���[�o���x�X�g)��
% ���������Ō������ŗǒl(�p�[�\�i���x�X�g)�ɏd�݂Â������āA
% �����Ȃ�ɒT�����Ă݂�i�ړ����x�����߂�)
% 
% 
% load initialdata10_20201008.mat u
% load initialdata10_20201008.mat y

% Pm=tf([1400],[0.3,1]);

% num=4;% ����p�����[�^�̐�
num=5;% ����p�����[�^�̐�

% x=[Trv.Numerator{1,1}(3);Trv.Numerator{1,1}(4);Trv.Denominator{1,1}(1);Trv.Denominator{1,1}(2);Trv.Denominator{1,1}(3);Trv.Denominator{1,1}(4)];
x=[1;1;1;1;1];
% x=[1.3;0.13;0.3];
% x=[0.0337;0.1815;0.242;0.41;1.548;1.61];
k=100; % ���q��
it=100;% ������
xm=rand(num,k);
xkb=rand(num,k); %�e���q�ʒu�̍ŗ�
xg=x; % ���q�S�̂̍ŗ�
xk=xm; % ���q�ʒu
vk=xm; % ���q���x
xk_1=xm; % ���q�ʒu
vk_1=xm; % ���q���x

Jkb=1000000*rand(1,k); % �e���q�̍ŗǕ]���l
Jgb=myfrit_op(x,t,y,ref,Cfb,Cff,Td); % �S�̍ŗǕ]���l
c1=2; %�W��1 �O���[�o���x�X�g�̏d�݂Â�
c2=1; %�W��2 �p�[�\�i���x�X�g�̏d�݂Â�
r1=rand(1); %����1
r2=rand(1);%����2
wmax=0.9; %�ő劵�� �T���͈͑�
wmin=0.1; %�ŏ����� �T���͈͏�
p_flag=0;

for i=1:it
    for j=1:k
        
        xp=xk(:,j);
        xk_1(:,j)=xk(:,j); %1�O�̒l
        vk_1(:,j)=vk(:,j); %1�O�̒l        
        for mn=1:num
            % �T���͈͂̐���
            if xk(mn,j)<0
                xk(mn,j)=0.0001;
                xp(mn)=0.0001;
                %p_flag=1;
            end
            if xk(mn,j)>100000
                xk(mn,j)=100000;
                xp(mn)=100000;
                %p_flag=1;
            end    
        end
        
%         sim(model_name);
        JJ=myfrit_op(xp,t,y,ref,Cfb,Cff,Td);
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
%   if i==1
%         xp=x;
%         sim(model_name);
%         J=evaluation(y,ysim);
%         Jgb=J; % �S�̍ŗǕ]���l
%         Jkb=J*ones(1,k); % �e���q�̍ŗǕ]���l
%     end

end
% Cff_n=tf([xg(1),xg(2)],[xg(3),xg(4)]);
% Cff_n=tf([xg(1),xg(2),xg(3)],[xg(4),xg(5),xg(6)]);

% Po=Td/(Cfb*(1-Td));
