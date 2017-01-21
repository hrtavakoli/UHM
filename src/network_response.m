function [ layer_result ] = network_response( X , net)
%gets the data and computes the output of the network for the given data
%  X  : data of the size suitable for the biggest possible patch we want
%  net: the network architecture

%nPatches = size(X, 2);

for i = 1:net.num_layers - 1
    layer_result{i}.output =  feedForward(X, net.layer{i}, net.layer{i+1}, net.input_type);
    layer_result{i}.reduced_output = net.layer{i+1}.V(1:size(net.layer{i+1}.H,1),:)*layer_result{i}.output;    
    X = layer_result{i}.output;
end

layer_result{net.num_layers}.output = activateLayer(X, net.layer{net.num_layers});
layer_result{net.num_layers}.reduced_output = net.layer{net.num_layers}.V(1:size(net.layer{net.num_layers}.H,1),:)*layer_result{i}.output; % whiten the data using layers

end

