function GatherReceivedShadowImage = ReceivedSensitivePartShadowImage(Sensitive_part_shadow_image,Users)
  shadowImageNumber = length(Users);
  for i = 1:shadowImageNumber
    % 接收到的影子图像 对应于总的影子图像的对应的列
    GatherReceivedShadowImage(:,i) = Sensitive_part_shadow_image(:,Users(i));  
  end
end