function classified = color_classify(rgb,classifier)
% classify colors of rgb according to classifier passed
%   classifier can contain N classifiers to output likelihood metric
%   if only 1 classifier passed, likelihood ~ distance from hyperplane
    
% ensure classifier correct size
if ndims(classifier)<3
    classifier = permute(classifier,[3 1 2]);
end
[nclassifiers,ntree,~] = size(classifier);
    
% convert to cartesian HSV
[ysize,xsize,~] = size(rgb);
hsv = rgb2hsv(rgb);
hsv = reshape(hsv,xsize*ysize,3);
[hsvc(:,1),hsvc(:,2),hsvc(:,3)] = pol2cart(2*pi*hsv(:,1),hsv(:,2),hsv(:,3));
clear rgb hsv;

% classify image
aggregated = zeros(nclassifiers,xsize*ysize);
parfor j = 1:nclassifiers
    
    % classify pixels
    d = zeros(1,xsize*ysize);
    clss = zeros(1,xsize*ysize);
    for k = 1:ntree
        which_process = clss==0;
        d(which_process) = hsvc(which_process,:)*squeeze(classifier(j,k,1:3));
        clss(which_process) = k*(d(which_process)>classifier(j,k,end));
    end
    clss(clss==0) = ntree + 1;
    
    % aggregate result
    if nclassifiers>1
        aggregated(j,:) = clss;
    else
        aggregated(j,:) = clss + 1i*abs(d);
    end
     
end
clear hsvc classifier;

% build output
classified = zeros(ntree+1,ysize,xsize);
aggregated = reshape(aggregated,[nclassifiers,ysize,xsize]);
for k = 1:ntree+1
    classified(k,:,:) = sum(real(aggregated)==k,1);
end
if nclassifiers>1
    classified = uint8(classified);
else
    classified = classified.*repmat(imag(aggregated),[ntree+1 1 1]);    
end
