function midFreqDCTMatrix = reconstructMidFreqDCTMatrix(img, blockSize)  
    % 假设 img 是一个可以被 4 整除的正方形图像  
    % blockSize 必须是 4，因为我们处理的是 4x4 的子块  
%     if size(img, 1) ~= size(img, 2) || blockSize ~= 4 || mod(size(img, 1), blockSize) ~= 0  
%         error('图像矩阵的维度必须为正方形且边长可以被4整除。');  
%     end  
      
    % 计算子块的数量  
    numBlocksWidth = size(img, 2) / blockSize;  
    numBlocksHeight = size(img, 1) / blockSize;  
      
    % 初始化一个用于保存16x16 DCT中频系数的矩阵  
    % 由于我们是从4x4子块中提取，所以最终矩阵是4个4x4块组成的16x16矩阵  
    midFreqDCTMatrix = zeros(16, 16);  
      
    % 遍历图像矩阵并提取每个4x4子块的DCT  
    for iBlock = 1:numBlocksWidth  
        for jBlock = 1:numBlocksHeight  
            % 计算当前子块的左上角坐标  
            iStart = (iBlock - 1) * blockSize + 1;  
            jStart = (jBlock - 1) * blockSize + 1;  
              
            % 提取当前子块  
            subBlock = img(iStart:iStart+blockSize-1, jStart:jStart+blockSize-1);  
              
            % 对子块执行DCT  
            dctSubBlock = dct2(subBlock);  
              
            % 选择中频系数（非角落和非边缘的系数）  
            % 对于4x4 DCT，中频系数是除了第一行、第一列、最后一行和最后一列的其他系数  
            midFreqCoeffs = dctSubBlock(3,2); % 提取2,3的中频区域  
              
            % 将中频系数放置到16x16矩阵中的正确位置  
            % 注意：这里我们简单地将2x2的中频区域复制到16x16矩阵的对应4x4区域中  
            % 这意味着16x16矩阵的每个4x4块都会有相同的2x2中频模式  
            midFreqDCTMatrix((iBlock), (jBlock)) = midFreqCoeffs;  
            %midFreqDCTMatrix((iBlock-1)*4+(3:4), (jBlock-1)*4+(1:2)) = midFreqCoeffs;  
            %midFreqDCTMatrix((iBlock-1)*4+(1:2), (jBlock-1)*4+(3:4)) = midFreqCoeffs;  
            %midFreqDCTMatrix((iBlock-1)*4+(3:4), (jBlock-1)*4+(3:4)) = midFreqCoeffs;  
        end  
    end  
end  