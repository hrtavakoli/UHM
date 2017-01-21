function output = neuralPostProcess(input, layer)

switch(lower(layer.output.type))
    case 'lhthresh'
        input(input > layer.output.threshold.high) = layer.output.threshold.high;
        input(input < layer.output.threshold.low) = layer.output.threshold.low;
    case 'abs'
        input = abs(input);     
    case 'softmax'
        input = abs(input);  
        input = bsxfun(@rdivide, input, sum(input)); %L1 normalize
        input = bsxfun(@rdivide, exp(input), (sum(exp(input))+eps)); % pass to softmax
    otherwise
        error('unrecognized post processing funciton')       
end
    output = input;

end
