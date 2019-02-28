inpath = 'E:\Projects\Node_SCFC\';
addpath('E:\MATLAB\drtoolbox\techniques');

% load `Mats` cell array containing group-consensus structural (sc) and
% functional (fc) networks and 3D coordinates
load(fullfile(inpath, 'data', 'G1000_SC.mat'), 'Mats');

% load node-wise R-square values (see 'scpt_get_rsq.m')
load(fullfile(inpath, 'results', 'rsq.mat'), 'rsq');

% set parcellation resolution to scale 5 (1000 cortical nodes)
ii = 5;

% load group-consensus structural network and binarize | nxn node matrix
sc = Mats{ii, 1};
sc(sc > 0) = 1;

% group-consensus resting-state functional network | nxn node matrix
fc = Mats{ii, 3};

% x,y,z node coordinates | nx3 matrix
coor = Mats{ii, 4};

% number of cortical nodes | resolutions 1 to 5 = 68,114,219,448,1000
n = length(fc);

% diffusion map algorithm on functional network
mappedX = diffusion_maps(fc, 10, 0.5, 1);
% node weights for first eigenvector/component
x = mappedX(:, 1);
% reverse weights such that positive = top of hierarchy
x = x * -1;

% plot relationship between gradient (x) and R-square (y)
figure;
y = rsq{ii};
[rho, pval] = corr(x, y);
lm = fitlm(x, y);
xhat = linspace(min(x), max(x), 100);
yhat = lm.Coefficients.Estimate(1) + (lm.Coefficients.Estimate(2) * xhat);

scatter(x, y, '.'); hold on
plot(xhat, yhat)
title(['rho = ' num2str(rho) ', p = ' num2str(pval)]);
axis square


