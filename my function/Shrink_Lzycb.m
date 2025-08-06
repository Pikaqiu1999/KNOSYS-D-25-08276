function G_t=Shrink_Lzycb(G,xi)
[m,n]=size(G);
G_t=zeros(m,n);
for i=1:n
    for j=1:n
        if i==j
            G_t(i,j)=1;
        else
            if abs(G(i,j))<=xi
                G_t(i,j)=G(i,j);
            else
                G_t(i,j)=sign(G(i,j))*xi;
            end
        end
    end
end
end