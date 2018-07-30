function classifier = train_classifier(rgb,idx,lumen,nuclei,stroma,cytoplasm)

% decision tree structure (first num vs. second num)
TREE = {0, [1 2 3]; ...     % lumen
        1, [2 3]; ...       % nuclei
        2, 3};              % stroma vs cytoplasm
    
% SVM parameters
KSVM = 1e4;                 % number of points per class for training            
FCN = 'polynomial';         % polynomial or rbf
ORDER = 1;                  % polynomial order
SIGMA = 1;                  % rbf sigma
BOXC = 0;                   % box constraint exponent (10^BOXC)
MAXITER = 10^6;             % maximum number of iterations


%% Training

% load cluster and assignment data
idx = idx(:);
assigned{1} = lumen;
assigned{2} = nuclei;
assigned{3} = stroma;
assigned{4} = cytoplasm;
clear lumen stroma nuclei cytoplasm centroid;

% transform HSV from cylindrical to cartesian coordinates
hsv = rgb2hsv(rgb);
[hsvc(:,:,1),hsvc(:,:,2),hsvc(:,:,3)] = pol2cart(2*pi*hsv(:,:,1),hsv(:,:,2),hsv(:,:,3));
clear hsv;

% change order
hsvc = permute(hsvc,[3 1 2]);
hsvc = hsvc([1 2 3],:);

% initialize
ntree = length(TREE);
classifier = NaN(ntree,4);

% train classifier
for i = 1:ntree

    % establish training data
    grp1 = find(ismember(idx,[assigned{TREE{i,1}+1}]));
    if length(grp1)>KSVM
        grp1 = randsample(grp1,KSVM,false);
    end
    grp2 = find(ismember(idx,[assigned{TREE{i,2}+1}]));
    if length(grp2)>KSVM
        grp2 = randsample(grp2,KSVM,false);
    end
    labels = [ones(length(grp1),1); zeros(length(grp2),1)];

    % perform SVM
    warning off;
    svm = fitcsvm([hsvc(:,grp1)'; hsvc(:,grp2)'], ...
                   labels, ...
                   'KernelFunction', FCN, ...
                   'PolynomialOrder', ORDER, ...
                   'BoxConstraint', 10^BOXC, ...
                   'IterationLimit', MAXITER, ...
                   'KernelScale','auto', ...
                   'HyperparameterOptimizationOptions',struct('UseParallel',true));
    warning on;
    clear grp1 grp2 labels;

    % update classifier
    classifier(i,:) = svmhyperplane(svm);
    clear svm;

end  
