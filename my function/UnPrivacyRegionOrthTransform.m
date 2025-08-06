% 
% function encrypted_image = PrivacyRegionOrthTransform(Original_image,Loc,RandOrthMatrix)
% 

function Encrypted_image = UnPrivacyRegionOrthTransform(Original_image,Loc,RandOrthMatrix)
  % obtain privacy-sensitive region info
  Sensitive_region = Original_image(Loc.y1:Loc.y2,Loc.x1:Loc.x2);
  
  % exec privacy-sensitve region encryption operation
  Sensitive_region = Sensitive_region*RandOrthMatrix';
  % sensitive_region_of_image = sensitive_region_of_image*index_matrix(Loc.y1:Loc.y2,Loc.x1:Loc.x2);
  Original_image(Loc.y1:Loc.y2,Loc.x1:Loc.x2) = Sensitive_region;

  Encrypted_image = Original_image;
end


