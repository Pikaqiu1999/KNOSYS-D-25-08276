function [ Phi ] = csmatrix( M,N )
%PartFourierMtx Summary of this function goes here
%   Generate part Fourier matrix 
%   M -- RowNumber
%   N -- ColumnNumber
%   Phi -- The part Fourier matrix

%% Generate part Fourier matrix   
    
    Phi_t = fft(eye(N,N))/sqrt(N);%Fourier matrix
    RowIndex = randperm(N);
    Phi = Phi_t(RowIndex(1:M),:);%Select M rows randomly
    
%     Phi =  abs(imag(Phi))*1000;
%     Phi  = mapminmax(Phi,0,255);
%     Phi=round(Phi);
    %normalization
%     for ii = 1:N
%         Phi(:,ii) = Phi(:,ii)/norm(Phi(:,ii));
%     end
end

