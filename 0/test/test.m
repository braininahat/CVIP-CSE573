load('release/data/blue.mat')
load('release/data/red.mat')
load('release/data/green.mat')

base_image = cat(3,red,green,blue);

dimensions = size(base_image);

window_centre = ceil(dimensions/2);

%temp_red = red(window_centre(1)-15:1:window_centre(1)+15,window_centre(2)-15:1:window_centre(2)+15)
%temp_green = green(window_centre(1)-15:1:window_centre(1)+15,window_centre(2)-15:1:window_centre(2)+15)
%temp_blue = blue(window_centre(1)-15:1:window_centre(1)+15,window_centre(2)-15:1:window_centre(2)+15)

%window = cat(3,temp_red,temp_green,temp_blue)
window = imcrop(base_image,[window_centre(1)-5,window_centre(2),10,0]);

temp_red = window(:,:,1);
temp_green = window(:,:,2);
temp_blue = window(:,:,3);

reds = [];
greens= [];
blues = [];
% for i = 1:1:30
%     reds = [reds;circshift(temp_red,i)];
%     greens = [greens;circshift(temp_green,i)];
%     blues = [blues;circshift(temp_blue,i)];
% end
% %reds = repmat(temp_red,1,1,31)
% %greens = repmat(temp_green,1,1,31)
% %blues = repmat(temp_blue,1,1,31)
% 
% % for i = 1:1:31
% %     reds(:,:,i) = circshift(reds(:,:,i),i)
% %     greens(:,:,i) = circshift(greens(:,:,i),i)
% %     blues(:,:,i) = circshift(blues(:,:,i),i)
% % end
% % 
% % 
% % corr_1 = []
% % for i = 1:1:31
% %     for j = 1:1:31
% %         corr_1 = cat(3,corr_1,normxcorr2(reds(:,:,i),greens(:,:,j)))
% %     end
% % end
% 
% corr_rg = normxcorr2(reds,greens);
% corr_gb = normxcorr2(greens,blues);
% [foo,bar] = max(corr_rg)
% [ham,eggs] = max(foo)
