function matirx_Image = GetMatrixFormImage(Image_linear,t)
  if(mod(length(Image_linear),t) ~= 0)
     error('the length of Image_linear is invalid')
  end
matirx_Image = reshape(Image_linear,[],t);
end