function midFreqDCTMatrix = reconstructMidFreqDCTMatrix(img, blockSize)  
    numBlocksWidth = size(img, 2) / blockSize;  
    numBlocksHeight = size(img, 1) / blockSize;  
    midFreqDCTMatrix = zeros(16, 16);  
    for iBlock = 1:numBlocksWidth  
        for jBlock = 1:numBlocksHeight  
            iStart = (iBlock - 1) * blockSize + 1;  
            jStart = (jBlock - 1) * blockSize + 1;  
            subBlock = img(iStart:iStart+blockSize-1, jStart:jStart+blockSize-1);  
            dctSubBlock = dct2(subBlock);
            midFreqCoeffs = dctSubBlock(2,3);
%             disp(iBlock)
%             disp(jBlock)
%             disp(dctSubBlock)
            midFreqDCTMatrix(iBlock, jBlock) = midFreqCoeffs;
%             disp(midFreqDCTMatrix((iBlock), (jBlock)));
        end  
    end  
end