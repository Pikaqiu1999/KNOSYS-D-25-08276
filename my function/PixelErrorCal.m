%
% function error = PixErrorCal(image1, image2)
%
%  returns the pixels error between image1 and image2.



function error = PixErrorCal(image1, image2)
  tmp = image1 - image2;
  error = sqrt(mean(tmp(:).^2));
end
