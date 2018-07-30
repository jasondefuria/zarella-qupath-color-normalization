function [rgb,vectors] = color_normalize(rgb,target,classified)

%% CONSTANTS

D = 0;


%% PROGRAM BODY

% convert classified into clss and d
[d,clss] = max(classified);
d = double(d);
d = d/sum(classified(:,1,1));
d = squeeze(d);
clss = uint8(clss);
clss = squeeze(clss);
clear classified;

% deconstruct RGB into constituent HSV parts
[ysize,xsize,~] = size(rgb);
hsv = rgb2hsv(rgb);
clear rgb;

% transform HSV from cylindrical to cartesian coordinates
[hsvc(:,:,1),hsvc(:,:,2),hsvc(:,:,3)] = pol2cart(2*pi*hsv(:,:,1),hsv(:,:,2),hsv(:,:,3));
clear hsv;

% reshape
hsvc = reshape(hsvc,[],3);
clss = reshape(clss,[],1);
d = reshape(d,[],1);
nclasses = max(clss);  

% measure variation about mean
v = NaN(size(hsvc));
vectors = NaN(nclasses,3)
[target(:,1),target(:,2),target(:,3)] = pol2cart(2*pi*target(:,1),target(:,2),target(:,3));

for j = 1:nclasses
    which_pix = clss==j;
    idx_pix = which_pix & d>D;
    hsvc_mean = mean(hsvc(idx_pix,:));
    v(which_pix,:) = hsvc(which_pix,:) - repmat(hsvc_mean,sum(which_pix),1);
    vectors(j,:) = (target(j,:) - hsvc_mean);
    hsvc(idx_pix,:) = hsvc(idx_pix,:) + (target(j,:) - hsvc_mean);
end
clear which_pix hsvc_mean;

% rebuild image from target and add variation
%hsvc = target(clss,:) + v;
clear v;

% transform HSV from cartesian to cylindrical coordinates
[hsv(:,1),hsv(:,2),hsv(:,3)] = cart2pol(hsvc(:,1),hsvc(:,2),hsvc(:,3));
hsv(:,1) = mod(hsv(:,1),2*pi)/2/pi;
clear hsvc;

% ensure output is within bounds
gt1 = find(sum(hsv>1,2));
lt0 = find(sum(hsv<0,2));
hsv(gt1,:) = hsv(gt1,:)./repmat(max(hsv(gt1,:),[],2),1,3);
hsv(lt0,:) = hsv(lt0,:) - repmat(min(hsv(lt0,:),[],2),1,3);
clear gt1 lt0;

% save transformed RGB as mat or tif
rgb = hsv2rgb(hsv);
rgb = reshape(rgb,[ysize,xsize,3]);
end

