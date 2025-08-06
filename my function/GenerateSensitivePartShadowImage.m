function Sensitive_Shadow_Image = GenerateSensitivePartShadowImage(Matrix_Image,w,base)
  % 获取图像的行和列数，例如row_col = 1024 4,row_col(1)=1024;row_col(2)-4
  row_col = size(Matrix_Image); 

  Matrix_Image = int32(Matrix_Image);
  %w=int32(w);
  base = int32(base);

  % 初始为1024*8,其中所有元素都为0
  Sensitive_Part_Shadow_Image = int32(zeros(row_col(1),w)); 
  %Sensitive_Part_Shadow_Image = zeros(row_col(1),w); 
  for i=1:w  %i=1,2,3,4,5,6,7,8， 即a0+a1x+a2x2+a3x3 i的值就是这里多项式x的取值的变化
     for j = 1:row_col(2) %j=1,2,3,4,5
        % 第i列元素赋值
        %Sensitive_Part_Shadow_Image(:,i) = Sensitive_Part_Shadow_Image(:,i) + mod(Matrix_Image(:,j)*i^(j-1), base);
        Sensitive_Part_Shadow_Image(:,i) = Sensitive_Part_Shadow_Image(:,i) + Matrix_Image(:,j)*i^(j-1);
     end
  end
% Sensitive_Part_Shadow_Image = mod(Sensitive_Part_Shadow_Image,base);
 Sensitive_Shadow_Image = Sensitive_Part_Shadow_Image;
end 