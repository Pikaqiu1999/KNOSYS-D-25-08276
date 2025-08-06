function subBlocks = extractSubBlocks(img,blockSize)
    if size(img, 1) ~= size(img, 2) || mod(size(img, 1), blockSize) ~= 0 || mod(size(img, 2), blockSize) ~= 0  

        error('图像矩阵的维度必须为正方形且可以被blockSize整除。');  

    end
    
    numBlocks=(size(img,1)/blockSize)^2;

    subBlocks=cell(numBlocks,1);

    for i=1:blockSize:size(img,1)
        for j=1:blockSize:size(img,2)
            subBlock=img(i:i+blockSize-1,j:j+blockSize-1);
            subBlocks{((i-1)/blockSize)*blockSize + (j-1)/blockSize + 1} = subBlock;  
        end
    end
end
