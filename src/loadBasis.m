function net = loadBasis(net, params, layerlist, basisPath)
% function to load the basis from the files

for i = layerlist
    file2load = sprintf('%s%s', basisPath, params.base_id{i}, '.mat');
    %fprintf('loading layer %d bases from : %s \n', i, file2load);
    
    load(file2load) % load basesInfo structure
    
    if exist('basesInfo', 'var') % 
        idx = numel(basesInfo); % the bases from last iteration if we have multiple iterations recorded in the file should be loaded
        net.layer{i}.W = basesInfo{idx}.W;
        net.layer{i}.H = basesInfo{idx}.H;
        net.layer{i}.V = basesInfo{idx}.V;
        net.layer{i}.fovea_numel = size(net.layer{i}.W, 2);
        net.layer{i}.feature_num = size(net.layer{i}.H, 1);
        net.layer{i}.pca_dim = size(net.layer{i}.H, 2);
        %net.layer{i}.group_size = net.layer{i}.pca_dim / net.layer{i}.feature_num;
    else
        error('there is no basis vector file to load')
    end
    
end