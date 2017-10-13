function [ contourOut, closeImg ] = trackingPlume(  i,name,step )
%TRACKINGPLUME Summary of this function goes here
%   Detailed explanation goes here

%% Load Images
src=loadImg(i,name);
src2=loadImg(i+step,name);
[ origin, ~ ]=loadImg(1,name);

%% Get a mask of the moving objects
% Load the consecutive differentiation
maskPrec=dif2mask(src,src2);
maskPrec=openAndClean(maskPrec);

% Load the original differentiation
maskOri=dif2mask(origin,src2);
maskOri(maskOri>1)=1;

% Create a mask from both differentiations (moving object which was not
% there at the beginning
mask=maskOri+maskPrec;
mask=imfill(mask,'holes');

%% Clean Image
cleanImg=openAndClean(biggestConnexComponent(mask));

% We redefine the edges since the wavelet transformation is coarse
rIm=imreconstruct(cleanImg,src2);

% We chose the larger area reconstruct inside the mask as the plume.
val=unique(rIm);
m=0;
ind=0;
for j=1:size(val,1)
    m2=size(find(rIm==val(j)),1);
    if m2>m
        m=m2;
        ind=j;
    end
end
val=val(j);

% We binarize the area
rIm(rIm~=val)=-Inf;
rIm(rIm==val)=1;
rIm(rIm~=1)=0;
cleanImg=rIm.*cleanImg;

% We do a closing transformation to remove the last outliers
se=strel('disk',2);
closeImg=imclose(cleanImg,se);
closeImg=imfill(closeImg,'holes');
closeImg=biggestConnexComponent(closeImg);

% We compute the contour to draw it on the original image
BW=edge(closeImg,'canny');
contourOut=src2+max(src2(:))*BW;

end
