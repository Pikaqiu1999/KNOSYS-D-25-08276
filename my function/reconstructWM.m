function resultImg=reconstructWM(origImg,newBlock)

    resultImg = origImg;

    numBlocksX = size(origImg, 2) / 4;  
    numBlocksY = size(origImg, 1) / 4;

    blockSize=4;

    for iBlock = 1:numBlocksX  
        for jBlock = 1:numBlocksY  
            % 计算当前4x4分块的起始索引  
            startX = (iBlock - 1) * 4 + 1;  
            startY = (jBlock - 1) * 4 + 1;  

            subBlock=resultImg(startX:startX+blockSize-1, startY:startY+blockSize-1);
            subBlock=dct2(subBlock);

            % 替换中心位置的值（即第4行第4列）  
            centerX =  2;  
            centerY =  3;  
                    
            % 替换值  
            %resultImg(centerY, centerX) = newBlock(rowIndex, blockIndex);
%             disp(iBlock);
%             disp(jBlock);
            %disp(subBlock);
%             disp(newBlock(iBlock, jBlock))
%             disp(subBlock(centerX,centerY))
            subBlock(centerX,centerY)=newBlock(iBlock, jBlock);
%             subBlock(centerX,centerY)=0; 
% 
             subBlock(centerX,centerY);
%              subBlock(centerX,centerY)=randi([-300,300]); 
            subBlock=idct2(subBlock);
            resultImg(startX:startX+blockSize-1, startY:startY+blockSize-1)=subBlock;
        end  
    end  