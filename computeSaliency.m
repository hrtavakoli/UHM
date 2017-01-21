
function saliency = computeSaliency(im, bias)

if nargin < 2
    bias = true;
end

setup_globalSetting();

[x, y, ~] = size(im);
saliency = zeros(x, y);

for scale =  155:100:480
    tmpSal = compute_glSaliency(im, scale);
     
    tmpSal = exp(tmpSal)./sum(sum(exp(tmpSal)));
    saliency = saliency + imresize(tmpSal, [x y]);
    
end


saliency = exp(saliency)./sum(sum(exp(saliency)));
saliency = normalizeSalVal(saliency);

saliency = imfilter(saliency, fspecial('Gaussian', 50, 0.35*50));

if bias
    saliency = center_bias(saliency);
end
saliency = normalizeSalVal(saliency);
