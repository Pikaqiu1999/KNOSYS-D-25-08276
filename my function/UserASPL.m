function RecoveredImage = UserASPL(Y, Phi, param, num_levels, PSI)
    Y=Y-PSI;
    % 3） execute decryption
    % 3.1）参数初始化
    lambda = 0.8;               %  convergence-control factor
    max_iterations = 100;       %  maximum iteration numbers
    TOL = 0.0001;               %  error tolerance
    D_prev = 0;                             
    
    % 3.2） start decryption
    X = Phi'*Y;  % Initial value
    
    % added by hxf begin 2023 6 10
    beta = 0.8;                       %  sigma的衰减因子
    sigma_x = X(:);
    sigma = 2*max(abs( sigma_x ));    %  光滑函数的初始参数
    sigma_min = 0.01;                 %  算法终止的界限
    %sigma_min = 0.0005;
    param.beta = beta;
    param.sigma = sigma;
    param.sigma_min = sigma_min;
    % added by hxf end  2023 6 10
    
    
    for i = 1:max_iterations
        [X, D_cur] = SPLIterationUserA(Y, X, Phi, param, lambda, num_levels);
        
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
    
    [X, D_cur] = SPLIterationUserA(Y, X, Phi, param, lambda, num_levels);
    RecoveredImage = X;

    %msgbox('userASPL called end','信息对话框','help');
end