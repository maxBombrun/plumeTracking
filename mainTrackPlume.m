function mainTrackPlume(input_args  )
%MAINTRACKPLUME Summary of this function goes here
%   Main routine of the plume algorithm

%% Load data set and Initialisation
inputName='.\data\stromb\';
outputName='.\results\';
mkdir(outputName);

listImg= dir([inputName '*.mat']);

S0=strsplit(listImg(1).name,{',',';','_','-','.',':'});
S1=strsplit(listImg(2).name,{',',';','_','-','.',':'});
idxDif=find(strcmp(S0,S1)==0);
S0=str2double(S0{idxDif});
S1=str2double(S1{idxDif});
if (S1-S0 ==1)
    deb=S0;
else
    prompt = 'What is the first frame number? ';
    deb=input(prompt);
end

freq=15;

src= load([inputName listImg(deb+1).name]);
src=src.Frame;
nbFrame= length(listImg);
fin=deb+nbFrame-1;
step=computeTimeStep(inputName, nbFrame);

entete={'Frame' 'Relative Time (s)' 'Height (pix)' 'Width (pix)'};
contenu=cell(10,4);

[~,xInit]=max(src(:));
[xInit,~]=ind2sub(size(src),xInit);

maskTSave=zeros(size(src,1),size(src,2),10);
idx=1;
%%%%%%%%%%%%%%%%%% VIDEO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open a video writer
vidObj = VideoWriter(['./' outputName '/mapT'],'MPEG-4');
open(vidObj);
% Open a figure and parameterize it
fig=figure;
set(fig, 'Position', [100 100 2*size(src,2) 2*size(src,1)])
axis([0 size(src,1) 0 size(src,2)]);
set(gcf, 'PaperPositionMode', 'auto');
set(gca,'position',[0 0 1 1],'units','normalized')
colormap(jet);

%% Run through all images
for i=deb:step:fin
    % Extract mask
    [contour, mask] = trackingPlume(i,inputName,step);
    zoneT=find(mask==1);
    [x0,y0]=ind2sub(size(mask), zoneT);
    
    currSrc=loadImg(i+step,inputName);
    
    %Save the images
    imagesc(mask)
    saveas(gcf,['./' outputName '/mask_' num2str(i+step,'%0.4d') '.png'],'png');
    imagesc(contour)
    saveas(gcf,['./' outputName '/contour_' num2str(i+step,'%0.4d') '.png'],'png');
    
    mapT=currSrc.*mask;
    
    %% Extract height and width
    Pt=min(x0);
    if xInit ~= max(x0)
        xInit=max(x0);
    end
    plumeHeight=abs(xInit-Pt);
    plumeWidth=abs(max(y0)-min(y0));
    
    %% Set the Gif
    maskT=mask;
    for z=Pt:xInit
        slice=mask(z,:).*currSrc(z,:);
        list=slice~=0;
        M=mean(slice(list));
        maskT(z,:)=M.*list;
    end
    maskTSave(:,:,idx)=maskT;
    
    %%%%%%%%%%%%%%%%%% VIDEO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    imagesc(contour);
    hold on;
    timing= (i+step)/30;
    M=floor(timing/60);
    S=num2str(floor(timing-M*60));
    M=num2str(M);
    timing= [sprintf('%02s',M) ':' sprintf('%02s',S)];
    leg=sprintf('%s\n', timing);
    t=text(10,30,leg,'FontSize',36,'Color', [1 1 1]);
    %scale if known
%     rectangle('Position', [size(src,2)-50, size(src,1)-50, 4, 34],'FaceColor', [1 1 1])
%     t2=text(260,217,'200 m','FontSize',20,'Color', [1 1 1]);
    %colorbar
    hold off;
    axis off
    % Transform the frame in video
    F = getframe(fig);
    writeVideo(vidObj,F);
    %%%%%%%%%%%%%%%%%% VIDEO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%% GIF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    im = frame2im(F);
    [imind,cm] = rgb2ind(im,256);
    if i == deb
        imwrite(imind,cm,[outputName 'mapT.gif'],'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,[outputName 'mapT.gif'],'gif','WriteMode','append');
    end
    %%%%%%%%%%%%%%%%%%% GIF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %% Save information in 'content'
    listImg(i+step).name
    time=i/freq;
    [H,M,S]=secs2hms(time);
    time=[sprintf('%02.0f', H) ':' sprintf('%02.0f', M) ':' sprintf('%02.0f', S)];
    contenu(idx,:)={num2str(i)  time num2str(plumeHeight) num2str(plumeWidth)};
    idx=idx+1;
end

% Close the objects
if exist('fig')
    close(fig);
end
if exist('vidObj')
    close(vidObj);
end

%% Save the content
if ~isempty(contenu)
    fprintf('Writing...\n');
    filename=['./' outputName '/measures_res.xlsx'];
    if(exist(filename, 'file')==2)
        delete(filename);
    end
    xlswrite(filename,entete,1,'A1');
    if(~isempty(contenu))
        xlswrite(filename,contenu,1,'A2');
    end
end
fprintf('Done\n');

end

