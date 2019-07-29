inpath = fullfile(dirname(dirname(mfilename('fullpath'))));

% load node-wise R-square values (see 'scpt_get_rsq.m')
load(fullfile(inpath, 'results', 'rsq.mat'), 'rsq');

% load spin-test resampling indices
load(fullfile(inpath, 'data', 'spinmat.mat'), 'spinmat');

% load partitions
% rsn_mapping + rsn_names | resting state networks | Yeo et al. (2011) J Neurophysiol
% ve_mapping + ve_names | von Economo classes | Scholtens et al. (2018) NeuroImage
load(fullfile(inpath, 'data', 'rsn_mapping.mat'), 'rsn_mapping', 'rsn_names');
load(fullfile(inpath, 'data', 've_mapping.mat'), 've_mapping', 've_names');

% set parcellation resolution to scale 5 (1000 cortical nodes)
scale = 5;

% partition (ci) | 1000x1 vector
% toggle for resting state networks (RSNs) or von Economo (VE) classes
ci = rsn_mapping{scale};
%ci = ve_mapping{scale};

% number of communities / classes
nci = max(ci);

% dummy-code community assignments
dumdum = dummyvar(ci);

% get mean R-square for each community
ci_mu = rsq{scale}' * dumdum ./ sum(dumdum);

% label-permuting null model, set number of permutations
nperm = 10000;
% initialize community-wise mean R-square for each permutation
ci_perm = zeros(nci, nperm);

for ii = 1:nperm
    % permute community assignments using spatially-autocorrelated null model
    p = spinmat{5}(:, ii) + 1; % originally done in python, so must add 1

    % dummy-code permuted community assignments
    dumdum = dummyvar(ci(p));

    % get mean R-square for permuted community assignments
    ci_perm(:, ii) = rsq{scale}' * dumdum ./ sum(dumdum);
    fprintf('permutation %i out of %i done\n', ii, nperm)
end

% initialize z-scores of mean community R-square values relative to
% permuted null
ci_z = zeros(nci, 1);
for ii = 1:nci
    % mean R-square for real community ii
    x = ci_mu(ii);

    % mean R-square for permuted community ii
    mu = mean(squeeze(ci_perm(ii, :)));

    % standard devitation of R-square for permuted community ii
    sigma = std(squeeze(ci_perm(ii, :)));

    % z-score
    ci_z(ii) = (x - mu) / sigma;
end

% plot z-scores
[~, i] = sort(ci_z);
figure;
barh(ci_z(i));
set(gca, 'YTick', 1:nci, 'YTickLabel', rsn_names(i))
% set(gca, 'YTick', 1:nci, 'YTickLabel', ve_names(i))
