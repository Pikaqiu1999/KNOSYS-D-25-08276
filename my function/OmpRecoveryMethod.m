% pic recovery through omp method
% y--测量值;A--观测矩阵；N--向量大小

function [hat_y] = OmpRecoveryMethod(y,A,N)
Size=size(A);                           % 观测矩阵大小
M=Size(1);                              % 测量
hat_y=zeros(1,N);                       % 待重构的谱域(变换域)向量(列向量)
Aug_t=[];                               % 增量矩阵(初始值为空矩阵)
r_n=y;                                  % 残差值
for times=1:M;                          % 迭代次数（不会超过测量值
   for col=1:N;                            %  恢复矩阵的所有列向量
       product(col)=abs(A(:,col)'*r_n);    %  恢复矩阵的列向量和残差的投影系数(内积值) 
   end
   [val,pos]=max(product);                 %  最大投影系数对应的位置
    Aug_t=[Aug_t,A(:,pos)];                 %  矩阵扩充
    A(:,pos)=zeros(M,1);                    %  选中的列置零（实质上应该去掉，为了简单我把它置零）
    aug_y=(Aug_t'*Aug_t)^(-1)*Aug_t'*y;     %  最小二乘,使残差最小
    r_n=y-Aug_t*aug_y;                      %  残差
    pos_array(times)=pos;                   %  纪录最大投影系数的位置
     if (norm(r_n)<0.9)                     %  自适应截断误差（***需要调整经验值）
     %if (abs(aug_y(end))^2/norm(aug_y)<0.05) 
        break;
    end
end
hat_y(pos_array)=aug_y;                  % 重构的向量
