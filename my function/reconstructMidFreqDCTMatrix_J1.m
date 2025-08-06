function midFreqDCTMatrix_J1 = reconstructMidFreqDCTMatrix_J1(img, blockSize)
    %if size(img, 1) ~= size(img, 2) || blockSize ~= 8 || mod(size(img, 1), blockSize) ~= 0  
    %    error('图像矩阵的维度必须为正方形且边长可以被8整除。');  
    %end

    % 计算子块的数量  
    numBlocksWidth = size(img, 2) / blockSize;  
    numBlocksHeight = size(img, 1) / blockSize;

    midFreqDCTMatrix_J1 = zeros(16, 16);

    for iBlock = 1:numBlocksWidth  
        for jBlock = 1:numBlocksHeight 
            % 计算当前子块的左上角坐标  
            iStart = (iBlock - 1) * blockSize + 1;  
            jStart = (jBlock - 1) * blockSize + 1;  
              
            % 提取当前子块  
            subBlock = img(iStart:iStart+blockSize-1, jStart:jStart+blockSize-1);  
              
            % 对子块执行DCT  
            dctSubBlock = dct2(subBlock);  
            %imagesc(dctSubBlock);
            % 选择中频系数（非角落和非边缘的系数）  
            % 对于4x4 DCT，中频系数是除了第一行、第一列、最后一行和最后一列的其他系数  
            midFreqCoeffs_J1 = dctSubBlock(4, 5); % 提取2x2的中频区域  
              
            % 将中频系数放置到16x16矩阵中的正确位置  
            % 注意：这里我们简单地将2x2的中频区域复制到16x16矩阵的对应4x4区域中  
            % 这意味着16x16矩阵的每个4x4块都会有相同的2x2中频模式  
            midFreqDCTMatrix_J1((iBlock), (jBlock)) = midFreqCoeffs_J1;  
            %midFreqDCTMatrix((iBlock-1)*4+(3:4), (jBlock-1)*4+(1:2)) = midFreqCoeffs;  
            %midFreqDCTMatrix((iBlock-1)*4+(1:2), (jBlock-1)*4+(3:4)) = midFreqCoeffs;  
            %midFreqDCTMatrix((iBlock-1)*4+(3:4), (jBlock-1)*4+(3:4)) = midFreqCoeffs;  
        end  
    end  
end  