function [ im, nbFrame ] = loadImg( i, name, rotateFlag, angle )
%LOADIMG Summary of this function goes here
%   Detailed explanation goes here

if nargin<3
    rotateFlag=0;
    angle=-90;
else if nargin<4
    angle=-90;
    end
end


if ~strcmp( name(length(name)), '\')
    name=[name '\'];
end

S=dir([name '*.mat']);
ind=S(i).name;
im=load([name ind]);
ind=fieldnames(im) ;
im=getfield(im,ind{1});

if nargout>1
    nbFrame=size(dir([name '*.mat']),1);
end

if rotateFlag
    im=imrotate(im,angle);
end

end


