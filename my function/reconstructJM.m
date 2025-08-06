function resultImg=reconstructJM(origImg,newBlock)

    resultImg = origImg;

    numBlocksX = size(origImg, 2) / 8;  
    numBlocksY = size(origImg, 1) / 8;

    blockSize=8;

    for iBlock = 1:numBlocksX  
        for jBlock = 1:numBlocksY  
            % 计算当前8x8分块的起始索引  
            startX = (iBlock - 1) * 8 + 1;  
            startY = (jBlock - 1) * 8 + 1;  

            subBlock=resultImg(startX:startX+blockSize-1, startY:startY+blockSize-1);
            subBlock=dct2(subBlock);

            % 替换中心位置的值（即第4行第4列）  
            centerX =  4;  
            centerY =  5;  
                    
            % 替换值  
            %resultImg(centerY, centerX) = newBlock(rowIndex, blockIndex); 
            subBlock(centerX,centerY)=newBlock(iBlock, jBlock);
            
            subBlock=idct2(subBlock);
            resultImg(startX:startX+blockSize-1, startY:startY+blockSize-1)=subBlock;
        end  
    end  