function Plz=OP_Lzycb_p_f(P0,D0)
%%
iter=2000; % 2000
P0=column_unit_norm(P0);
%D0=column_unit_norm(D0);
 PD=P0*D0;

[m,N]=size(PD);
[n,~]=size(D0);
xi=1.2*sqrt((N-m)/(m*(N-1)));
% xi=1/sqrt(m);
[Ud,Ld,Vd]=svd(D0);
G=PD'*PD;% Eq.(24)
for i=1:iter
    S_c=zeros(N);
    S_c(1:N+1:end)=1./sqrt(diag(G));
    G_bar=S_c'*G*S_c;% normlize G
    G_t=Shrink_Lzycb(G_bar,xi);% Eq.(25)
    Q=Vd'*G_t*Vd;
    Q11=Q(1:n,1:n);
    [V11,D11]=eig(Q11);
    [~,ind] = sort(diag(D11),'descend');
    V11=V11(:,ind);
    G=Vd*[V11,zeros(n,N-n);zeros(N-n,N)]*[eye(m),zeros(m,N-m);zeros(N-m,N)]*[V11',zeros(n,N-n);zeros(N-n,N)]*Vd';% Eq.(24)
end
Plz=sqrt(N/m)*[eye(m),zeros(m,n-m)]*(V11'*inv(Ld(:,1:n)))*Ud';
end