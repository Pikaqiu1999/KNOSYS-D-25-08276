function D0=column_unit_norm(D0)
[~,n]=size(D0);
% D=zeros(m,n);
for j=1:n
    D0(:,j)=D0(:,j)/sqrt(D0(:,j)'*D0(:,j));
end
end