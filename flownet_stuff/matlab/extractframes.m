clc;clear all;close all;
v = VideoReader('../input/2019-04-20-135350.webm');
video = VideoWriter('opticalcomp.mp4'); %create the video object
video.FrameRate = 15;`
open(video);
% output = '../input/mine/frame_';
% i=1;

flow21 = '../flownet2/inference/run.epoch-0-flow-field/';
flow2 = fileDatastore(flow21,'ReadFcn',@fopen,'FileExtensions','.flo');

flowc1 = '../flownetc/inference/run.epoch-0-flow-field/';
flowc = fileDatastore(flowc1,'ReadFcn',@fopen,'FileExtensions','.flo');

flows1 = '../flownetc/inference/run.epoch-0-flow-field/';
flows = fileDatastore(flows1,'ReadFcn',@fopen,'FileExtensions','.flo');

 for i=1:1:size(flow2.Files,1)
     
     fl2 = readFlowFile(flow2.Files{i});
     flc = readFlowFile(flowc.Files{i});
     fls = readFlowFile(flows.Files{i});
     
     
     imgfl2 = flowToColor(fl2);
     imgflc = flowToColor(flc);
     imgfls = flowToColor(fls);
     
     realimg = readFrame(v);
     
     subplot(2,2,1)
     imshow(realimg)
     title("RGB Image Input");
     subplot(2,2,2)
     imshow(imgfl2)
     title("FlowNet 2");
     subplot(2,2,3)
     imshow(imgflc)
     title("FlowNet-C");
     subplot(2,2,4)
     imshow(imgfls)
     title("FlowNet S");

     F = getframe(gcf);
%      imshow(F.cdata)
     writeVideo(video,F.cdata);
 end
close(video);
% while hasFrame(v)
%   img = readFrame(v);
% %   imshow(img);
%   imwrite(img,sprintf('%s%04d.png', output,i));
%   i=i+1;
