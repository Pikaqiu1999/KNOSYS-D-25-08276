
function [x, D] = SPLIterationUserB(y, x, Phi, param, lambda, num_levels)

    % x = col2im(x, [block_size block_size], ...
%     [num_rows num_cols], 'distinct');                      
% 
% x_hat = P1' * x * P2';      

%% added by hxf begin
 x_hat = x;
%% added by hxf end

x_hat = wiener2(x_hat, [3, 3]);                            

% x_hat = P1 * x_hat * P2;                            
% 
% x_hat = im2col(x_hat, [block_size block_size], 'distinct');        

x_hat = x_hat + Phi' * (y - Phi * x_hat);    

% x1 = col2im(x_hat, [block_size block_size], ...
%     [num_rows num_cols], 'distinct');                        
% 
% x_check = P1' * x1* P2';     

%% added by hxf begin

 x1 = x_hat;
 x_check = x1;
%% added by hxf end

% 稀疏化
x_check = waveletcdf97(x_check, num_levels);     

% added by hxf begin 6 12
% x_check = x_check(:);
% delta = -x_check.*exp(-abs(x_check).^2/(2*param.sigma^2));
% x_check = x_check+2*delta;
% x_check= reshape(x_check,256 ,256);

delta = -x_check.*exp(-abs(x_check).^2/(2*param.sigma^2));
x_check = x_check+4.3*delta; %2->4.3

% added by hxf end  6 12

threshold = lambda  * sqrt(2 * log(param.width * param.high)) * (median(abs(x_check(:))) / 0.6745);   


x_check(abs(x_check) < threshold) = 0;        

x_bar = waveletcdf97(x_check , -num_levels);                             

% x_bar  = P1 * x_bar * P2;                  
% x_bar = im2col(x_bar, [block_size block_size], 'distinct');

x = x_bar + Phi' * (y - Phi * x_bar);                                                

% x2 = col2im(x, [block_size block_size], ...
%     [num_rows num_cols], 'distinct');   

%% added by hxf begin
 x2 = x;
%  yita = yita*lambda;

%% added by hxf end
  
%D = RMS(x1, x2);                   
 D = PixelErrorCal(x1, x2);
end