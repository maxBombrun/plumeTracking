function [ area ] = biggestConnexComponent( imageIn )
%BIGGESTCONNEXCOMPONENT Get the biggest 4-connexe component 

connex= bwconncomp(imageIn,4);
pix=connex.PixelIdxList;
numPixels= cellfun(@numel,pix);
[~,idx]=max(numPixels);
area=zeros(size(imageIn));
area(pix{idx})=1;

end

