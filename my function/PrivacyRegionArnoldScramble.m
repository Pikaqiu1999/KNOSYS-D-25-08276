function encrypted_image = PrivacyRegionArnoldScramble(intermediate_encrypted_image,A,Loc)

  a = Loc.y2 - Loc.y1 + 1;
  b = Loc.x2 - Loc.x1 + 1;
  N = b;
   n1 = A.n1;
   aa =A.ax ;
   bb = A.bx;
   
   %置乱
   X1=zeros(a,b);
   temp_orig = intermediate_encrypted_image(Loc.y1:Loc.y2,Loc.x1:Loc.x2);
   
   for i=1:n1
       for y=1:a
            for x=1:b
                xx=mod((x-1)+bb*(y-1),N)+1;
                yy=mod(aa*(x-1)+(aa*bb+1)*(y-1),N)+1;
                X1(yy,xx)=temp_orig(y,x);
            end
        end
        intermediate_encrypted_image(Loc.y1:Loc.y2,Loc.x1:Loc.x2)=X1;
   end

   encrypted_image = intermediate_encrypted_image;
   
end