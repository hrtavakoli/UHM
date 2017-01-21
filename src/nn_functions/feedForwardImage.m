function output = feedForwardImage(X, sLayer, dLayer)

if strcmp(lower(sLayer.type), 'pool')
    error('pooling layer needs to be implemented')
    return % we do not continue
end

nPatches = size(X, 2); % number of image patches

sFovea_spSize = sLayer.fovea.spatial_size;
dFovea_spSize = dLayer.fovea.spatial_size;

spatial_stride = sLayer.spatial_stride;

nSubSample_per_spCol_dL = floor(1 + (dLayer.fovea.spatial_size - sLayer.fovea.spatial_size)/sLayer.spatial_stride); 

nSubSample = sLayer.num_subsamples;

nFoveaSRC = 3*sFovea_spSize^2; % we assume that we have 3 channel data so the spatial size is multiplied by 3
nFoveaDES = 3*dFovea_spSize^2;

filt_dim = size(sLayer.H, 1);

output = zeros(nSubSample*filt_dim, size(X, 2), 'single');

X = reshape(X, [dFovea_spSize, size(X, 2)*dFovea_spSize*3]); % reshape the data to have exactly a fovea dimension

index = (1:size(X, 2))-1;

for it = 0: nSubSample - 1
    
    [x, y, t] = ind2sub([nSubSample_per_spCol_dL, nSubSample_per_spCol_dL, 3], it+1);
    
    startx = (x-1)*spatial_stride + 1;
    starty = (y-1)*spatial_stride + 1;
    startt = (t-1)*spatial_stride*3 + 1; % the color channels are treated as well
    
    endx = startx + sFovea_spSize - 1;
    
    y_filter_spatial = (mod(index, dFovea_spSize) >= starty-1) & (mod(index, dFovea_spSize) < starty+sFovea_spSize-1);
    y_filter_colorCH = (mod(index, dFovea_spSize*3) >= startt-1) & (mod(index, dFovea_spSize*3) < startt+dFovea_spSize*3-1);
    
    y_filter = logical(y_filter_spatial.*y_filter_colorCH); % index to the data
    
    subFoveaX = reshape(X(startx:endx, y_filter), nFoveaSRC, nPatches); % select a subwindow whitin the bigger window that matches the network architecture of previous layer
    
    resIdx = it*filt_dim+1: (it+1)*filt_dim;
    
    output(resIdx, :) = activateLayer(subFoveaX, sLayer);
end




end