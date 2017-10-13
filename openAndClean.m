function [ imageOutput ] = openAndClean( imageInput )
%OPENANDCLEAN Do an opening to remove small  objects from the foreground of
%the imageInput.
%   Detailed explanation goes here

% Create a structur
se=strel('disk',1);
% Opening
imageOutput=imopen(imageInput,se);
% Compute the connex components
connex= bwconncomp(imageOutput);
pix=connex.PixelIdxList;
numPixels= cellfun(@numel,pix);
% Remove smallest particles
pix(numPixels==5)=[];
area=zeros(size(imageInput));
for j=1:size(pix,2)
    area(pix{j})=1;
end
imageOutput=area;


end

