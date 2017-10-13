function [ mask ] = dif2mask( src,src2 )
%DIF2MASK Get a mask from a differentiation (origin or previous frame)
%   A daubechie wavelet transformation provides a spreading histogram which
%   allows us to compute a coarse mask from a global thresholding (Otsu)

%% Compute the differentiation
dif=src2-src;

%% Wavelet
[ca,~,~,~]=dwt2(abs(dif),'db1');
a=upcoef2('a',ca,'db1',1);

level=multithresh(abs(a),2);
mask=a;
mask(abs(mask)<level(1))=0;
mask(mask~=0)=1;

end
