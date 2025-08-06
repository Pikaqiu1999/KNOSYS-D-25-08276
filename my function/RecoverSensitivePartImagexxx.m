function RecoveredImage = RecoverSensitivePartImagexxx(ReceivedShadowImage,Users,param)

  row_column = size(ReceivedShadowImage);
  tmp = ones(row_column(2),row_column(2));
  for i = 1:row_column(2)
    % tmp矩阵赋值，每一列的值是对应Users元素值的i-1次方
    tmp(:,i) = tmp(:,i).*(Users.^(i-1))';
  end

  for i = 1:row_column(1)
    % tmp此处是一个5x5 matrix;
    % RecievedShowImage是一个nx5的矩阵，通过循环row_column(1）次，
    % 把每一个数据恢复
    RecoveredImage(i,:) = solveEq(tmp,ReceivedShadowImage(i,:),param.base);
  end
  
  % 去除多余的部分
  RecoveredImage = RecoveredImage(:);
  temp = param.t - param.temp;
  if temp > 0 && temp < param.t
  [width ,high]= size(RecoveredImage);
  RecoveredImage = RecoveredImage(1:width - temp);
  end
  
  RecoveredImage = reshape(RecoveredImage,param.width,param.high);
end

% 秘密信息具体恢复函数
function b = solveEq(tmp,shadowimagerow,base)
  % tmp此处是一个5x5矩阵； shadowimaerow是一个1x5的行向量
  b = GetIntMod(pinv(sym(tmp))*shadowimagerow',base)';
  %b = GetIntMod(sym(inv(tmp)*shadowimagerow'),base)';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Re_b = GetIntMod(b,base)
 [n,d] = numden(b);
 n = double(n);
 d = double(d);
%  Re_b = mod(n.*powermod(d,-1,base),base);
Re_b = n.*powermod(d,-1,base);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = powermod(a,z,n)
  % 注意：形参n <==> base, z此处为-1， a =d

  % This function calculates y = a^z mod n
  % If a is a matrix, it calculates a(j,k)^z mod for every element in a
  [ax,ay]=size(a);


  % If a is negative, put it back to between 0 and n-1
  %a=mod(a,n);

  % Take care of any cases where the exponent is negative
  if (z<0)
     z=-z;
     for j=1:ax
        for k=1:ay
            %a(j,k)=invmodn(a(j,k),n);
        end
     end
  end
  
  for j=1:ax
    for k=1:ay
      x=1;
      a1=a(j,k);
      z1=z;
      while (z1 ~= 0)
         while (mod(z1,2) ==0)
           z1=(z1/2);
           %a1=mod((a1*a1), n);
           a1 = a1*a1;
         end %end while
         z1=z1-1;
         x=x*a1;
         %% x=mod(x,n);
      end
      y(j,k)=x;  
    end %end for k
  end %end for j
end

function y = invmodn( b,n)
  % This function calculates the inverse of an element b mod n
  % It uses the extended euclidean algorithm

% n0=n;
  n0 =1;
  b0=b;
  t0=0;
  t=1;
  %q=floor(n0/b0);
  q =1;
  
  r=n0-q*b0;
 
  while r>0
    temp=t0-q*t;
    if (temp >=0)
      %temp=mod(temp,n);
    end
    if (temp < 0)
      %temp= n - ( mod(-temp,n));
      temp = -temp;
    end
    t0=t;
    t=temp;
    n0=b0;
    b0=r;
    q=floor(n0/b0);
    r=n0-q*b0;
  end

  if b0 ~=1
     y=[];
     disp('No inverse');
  else
     y=mod(t,n);
  end
end
