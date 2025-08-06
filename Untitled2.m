T=100000;
   phix=zeros(1,T);
   phiy=zeros(1,T);
   phiz=zeros(1,T);
   
   phix(1)=0.1;%0.3;
   phiy(1)=0.21;%0.4;
   phiz(1)=0.3;%0.5;
   a=10;
   w=3;
   % 2) 三维混沌映射
   for i=2:T
    phix(i)=phiy(i-1)-phiz(i-1);
    phiy(i)=sin(pi*phix(i-1)-a*phiy(i-1));
    phiz(i)=cos(w*acos(phiz(i-1))+phiy(i-1));
    
   end
   
start_plot = 100; % 舍弃前100个点以避免初始瞬态
figure;
plot3(phix(start_plot:T), phiy(start_plot:T), phiz(start_plot:T), ...
    'LineWidth', 0.5, 'Color', 'b');
xlabel('u');
ylabel('v');
zlabel('w');
title('3D Chaotic Attractor');



% 3D-Sine-Chebyshev bifurcation diagram
 u_{k+1} = v_k - w_k
 v_{k+1} = sin(pi*u_k - p*v_k)
 w_{k+1} = cos(q*acos(w_k) + v_k)
