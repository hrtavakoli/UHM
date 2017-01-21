function [ output ] = activateLayer(X, layer)
%compute the output of one layer of data
%   Detailed explanation goes here

nSample = size(X, 2);
output = zeros(size(layer.H,1), nSample , 'single');

%compute the reponses in batch sizes of 5000

batch_size = 5000;
count = 0;

while(count ~= nSample)
    batch_end = min(count + batch_size, nSample);
    
    output(:, count+1:batch_end) = activateNeuron(X(:, count+1:batch_end), layer);
     
    count = batch_end;
end

end

