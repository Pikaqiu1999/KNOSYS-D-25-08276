function [dctSubBlocks,subBlocks]=dct0fSubBlocks(img,blockSize)
    if size(img, 1) ~= size(img, 2) || mod(size(img, 1), blockSize) ~= 0 || mod(size(img, 2), blockSize) ~= 0  
        error('图像矩阵的维度必须为正方形且可以被blockSize整除。');  
    end

   numBlocks = (size(img, 1) / blockSize) ^ 2;  
   dctSubBlocks=cell(numBlocks,1);
   subBlocks=cell(numBlocks,1);
     for i = 1:blockSize:size(img, 1)  
        for j = 1:blockSize:size(img, 2)  
            % 提取当前子块  
            subBlock = img(i:i+blockSize-1, j:j+blockSize-1);  
            % 对子块执行DCT  
            dctSubBlock = dct2(subBlock);  
            % 保存子块
            subBlocks{((i-1)/blockSize)*blockSize + (j-1)/blockSize + 1} = subBlock;
            % 将DCT后的子块保存到cell数组中  
            dctSubBlocks{((i-1)/blockSize)*blockSize + (j-1)/blockSize + 1} = dctSubBlock;  
        end  
    end  
end  