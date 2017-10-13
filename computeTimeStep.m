function [ returnIdx ] = computeTimeStep(inputName, nbFrame)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Initialization
% The event is assumed to be ongoing in the middle of the video
firstIdx=round(nbFrame/2);
src=loadImg(firstIdx,inputName);
beginFlag=0;
currIdx=firstIdx;

% We process all frames
while ~beginFlag && currIdx< nbFrame-1
    % Load the current and next frame
    src2=loadImg(currIdx+1,inputName);
    
    % Computation of the correlation coefficient
    C=corrcoef(src, src2);
    
    % Changes in the image (correlation coefficient change enough (0.5%))
  	if (C(2)<0.995)    
        beginFlag=1;
    else   
        %Update
        currIdx=currIdx+1;
    end
end

returnIdx=currIdx-firstIdx+1;

end

