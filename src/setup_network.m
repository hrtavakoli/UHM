function  net  = setup_network( params, basisPath, loadFlag, layerlist)
%setup a network architecture using the parmeters
% params : the parameters of the system
% loadFlag : if set it will load the basis files from a file
% layerlist : is the list of layers to load
% basisPath : path to the basis files

%todo add video support

if nargin < 4
    layerlist = 1:params.num_layers; % load the basis for all the layers
end

if nargin < 3
    loadFlag = 0;
end


net.num_layers = params.num_layers;
%net.basis_type = params.type;
net.input_type = params.inputType;

for i = 1:net.num_layers
    net.layer{i}.level = i;
    net.layer{i}.type = params.type{i};
    net.layer{i}.fovea = params.fovea{i};
    net.layer{i}.base_id = params.base_id{i};
    
    net.layer{i}.pca_dim = params.pca_dim{i};
    net.layer{i}.group_size = params.group_size{i};
    
    net.layer{i}.output = params.outputConfig{i};
    
    % let us set the stides this is a bit triky
    if i < net.num_layers 
        net.layer{i}.spatial_stride = params.stride{i}.spatial_stride;
        
        nSubSample = floor(1 + (params.fovea{i+1}.spatial_size - params.fovea{i}.spatial_size)/net.layer{i}.spatial_stride); 
        
        net.layer{i}.num_subsamples = nSubSample^2;
        
        if strcmp(params.inputType, 'video')
            net.layer{i}.temporal_stride = params.stride{i}.temporal_stride;
            nTemporalSubSample = floor(1 + (params.fovea{i+1}.temporal_size - params.fovea{i}.temporal_size)/net.layer{i}.temporal_stride);
            
            net.layer{i}.temporal_stride = params.stride{i}.temporal_stride;
            net.layer{i}.num_subsamples = net.layer{i}.num_subsamples*nTemporalSubSample;
        end
                
    end
end

if loadFlag
    net = loadBasis(net, params, layerlist, basisPath);
end

end

