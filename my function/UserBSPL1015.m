function RecoveredImage = UserBSPL1015(Y, Phi, param, num_levels,Index,P)
   %msgbox('userBSPL called begin','信息对话框','help');
   
   % 0) index unscrambing process
   Y = Unscramble(Index, Y);

    %% 秘钥敏感性测试begin
%     T=param.width*param.high;
%     x=zeros(1,T);
%     y=zeros(1,T);
%     z=zeros(1,T);
%    
%     %x(1)=0.311111111111111;
%     x(1)=0.3;
%     y(1)=0.4;
%     z(1)=0.5;
%     a=10;
%     w=3;
%     % 2) 三维混沌映射
%     for i=2:T
%      x(i)=y(i-1)-z(i-1);
%      y(i)=sin(pi*x(i-1)-a*y(i-1));
%      z(i)=cos(w*acos(z(i-1))+y(i-1));
%     end
%     z_matrix = reshape(z,param.width,param.high);
%     Phi = orth(z_matrix)'; 
%   
%     Phi = Phi(1:param.M, :);
    %% 秘钥敏感性测试end

% % %     % 1）Remove R from Y before decryption 
% % %     distance=4; %采样间隔
% % %     n=param.high*param.width*distance;
% % %     k=param.k;    %tent分形参数
% % %     zz(1)=param.zz; %初值
% % % 
% % %     % key sensitive test begin
% % %     %zz(1) = 0.281111111111111111;
% % %     % key sensitive test end
% % %     
% % %     for i=1:n-1
% % %         if(zz(i)>0 & zz(i)<k)
% % %             zz(i+1)=zz(i)/k;
% % %         else
% % %             zz(i+1)=(1-zz(i))/(1-k);
% % %         end   %tent的映射关系
% % %     end
% % %     %将生成的序列采样得矩阵
% % %     z_sample=downsample(zz,param.distance);
    
   %% added by hxf another method begin
   % 1) 初始值
   % T=5000;
   T=param.width*param.width;
   xxx=zeros(1,T);
   yyy=zeros(1,T);
   zzz=zeros(1,T);
 
   xxx(1)=0.3;
   yyy(1)=0.4;
   zzz(1)=0.5;
   %zzz(1)=0.511111111111111;
   a=10;
   w=3;
   % 2) 三维混沌映射
   for i=2:T
    xxx(i)=yyy(i-1)-zzz(i-1);
    yyy(i)=sin(pi*xxx(i-1)-a*yyy(i-1));
    zzz(i)=cos(w*acos(zzz(i-1))+yyy(i-1));
   end
   z_sample = zzz;
  %% added by hxf another method end
  
    R = reshape(z_sample,param.width,param.width);
     Y = Y*pinv(R);

    % 2 ) remve P before decryption
    Y = Y*pinv(P); %% new addded 和 UserASPL的区别
    
    
    % 3） execute decryption
    % 3.1）参数初始化
    lambda = 0.8;               %  convergence-control factor
    max_iterations = 200;       %  maximum iteration numbers
    TOL = 0.0001;               %  error tolerance
    D_prev = 0;                             

    % 3.2） start decryption
    X = Phi'*Y;  % Initial value
    
    % added by hxf begin 2023 6 10
    beta = 0.8;                       %  sigma的衰减因子
    sigma_x = X(:);
    sigma = 2*max(abs( sigma_x ));            %  光滑函数的初始参数
    sigma_min = 0.01;                 %  算法终止的界限
    %sigma_min = 0.0005;
    param.beta = beta;
    param.sigma= sigma;
    param.sigma_min = sigma_min;
    % added by hxf end  2023 6 10
    
    for i = 1:max_iterations
        [X, D_cur] = SPLIterationUserB(Y, X, Phi, param, lambda, num_levels);                
        
        % if the error smaller than the given error tolerance, break.
        if ((D_prev ~= 0) && (abs(D_cur - D_prev) < TOL))     
            break;
        end
        D_prev = D_cur; % update D_prev
        % added by hxf begin 6 12 
        if  param.sigma > param.sigma_min
            param.sigma = param.sigma*beta;
        end
        % addd by hxf end  6 12
    end
    
    [X, D_cur] = SPLIterationUserB(Y, X, Phi, param, lambda, num_levels);
    RecoveredImage = X;

    %msgbox('userBSPL called end','信息对话框','help');
end