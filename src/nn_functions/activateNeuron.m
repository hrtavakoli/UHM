function [ output ] = activateNeuron( input, layer )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

global use_gpu

if use_gpu
    W = gpuArray(layer.W);    
    gPerturb = gpuArray(single(0));
    gInput = gpuArray(input);
else
    W = layer.W;
    gPerturb = single(0);
    gInput = input;
end

activation = W*gInput + gPerturb;

activation = activation .* activation;

activation = neuralPostProcess(activation, layer);

if use_gpu
    H = gpuArray(layer.H);
    gPerturb = gpuArray(single(1e-4));
else
    H = layer.H;
    gPerturb = single(1e-4);
end

activation = H*activation + gPerturb;

activation = sqrt(activation);

activation = neuralPostProcess(activation, layer);

if use_gpu
    output = single(gather(activation));
else
    output = single(activation);
end


end

