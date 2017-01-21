function saliency = compute_glSaliency(img, scale)
% compute the global and local saliency using the network features and Graphs.

global basesPath
global image_canonical_size


params = set_params(); % set the system parameters

net = setup_network(params, basesPath, 1, [1, 2]);
image_canonical_size = scale;

img  = loadImage(img);
[x, y, c] = size(img);

step = net.layer{end}.fovea.spatial_size;
X = [];
hW = round(net.layer{end}.fovea.spatial_size/2);
for i = hW:step:x-hW
    for j = hW:step:y-hW
        patch = img(i-hW+1:i+hW, j-hW+1:j+hW, :);
        X = cat(2, X, patch(:));
    end
end

result = network_response(X, net);

feature = [result{1}.output; result{2}.output];

E2 = computeMarkovAttention(result{1}.output', max(x,y)); % translates to global saliency
E = sum(feature); % translates to local saliency
saliency = zeros(x,y);
cnt = 1;
f = round(step/2);
for i = hW:step:x-hW
    for j = hW:step:y-hW
        saliency(i-f+1:i+f,j-f+1:j+f) = saliency(i-f+1:i+f,j-f+1:j+f) + E(cnt) .* E2(cnt);
        cnt = cnt + 1;
    end
end

saliency(1:hW, :) = mean(saliency(:));
saliency(x-hW:x, :) = mean(saliency(:));
saliency(:, 1:hW) = mean(saliency(:));
saliency(:, y-hW:hW) = mean(saliency(:));
saliency = imresize(saliency, [x, y]);

saliency =  ( saliency - min(saliency(:)) ) / ( max(saliency(:)) - min(saliency(:)) );

saliency = imfilter(saliency, fspecial('Gaussian', 20, 0.4*20));
saliency = imresize(saliency, [x, y]);

saliency =  ( saliency - min(saliency(:)) ) / ( max(saliency(:)) - min(saliency(:)) );

end

