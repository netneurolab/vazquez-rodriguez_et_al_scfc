inpath = 'E:\Projects\Node_SCFC\';

% load `Mats` cell array containing group-consensus structural (sc) and
% functional (fc) networks and 3D coordinates
load(fullfile(inpath, 'data', 'G1000_SC'), 'Mats');

nscale = 5;             % 5 parcellation scales for the Lausanne atlas
rsq = cell(nscale, 1);  % vector of nodal R-square values for each parcellation

% loop over parcellations
for ii = 1:nscale
    % load group-consensus structural network and binarize | nxn node matrix
    % for more information on methods used to generate group-consensus
    % structural network see: Betzel et al., (in press), Net Neurosci
    sc = Mats{ii, 1};
    sc(sc > 0) = 1;

    % group-consensus resting-state functional network | nxn node matrix
    fc = Mats{ii, 3};

    % x,y,z node coordinates | nx3 matrix
    coor = Mats{ii, 4};

    % number of cortical nodes | resolutions 1 to 5 = 68,114,219,448,1000
    n = length(fc);

    sp = distance_bin(sc);         % path length (brain connectivity toolbox)
    co = fcn_communicability(sc);  % communicability
    eu = squareform(pdist(coor));  % euclidean distance

    % initialize node-wise R-square values for resolution ii
    rsq{ii} = zeros(n, 1);
    for jj = 1:n
        % define fc response (y) and sc predictors (x_i)
        y = fc(:, jj);

        x1 = sp(:, jj);
        x2 = co(:, jj);
        x3 = eu(:, jj);

        % standardize predictors
        x = zscore([x1, x2, x3]);

        % fit multiple regression (OLS, main effects only)
        % exclude self-connections for all variables
        % N.B., `fitlm` adds an intercept by default
        lm = fitlm(x, y, 'Exclude', jj);
        % record adjusted R-square for parcellation ii, node jj
        rsq{ii}(jj) = lm.Rsquared.Adjusted;

        % let me know how we're doing :)
        fprintf('scale %i: node %i out of %i done\n', ii, jj, n)
    end
end

save(fullfile(inpath, 'results', 'rsq.mat'), 'rsq');
