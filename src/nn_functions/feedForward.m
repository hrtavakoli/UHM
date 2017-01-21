
function output = feedForward(X, sLayer, dLayer, inputType)
% now let us just feedforward the data and compute the output
% X is the input data
% s is the source layer
% d is the destination layer



% here simply apply the transform and feed forward the data

switch lower(inputType)
    case 'video'
        error('video handling not implemented yet')
    case 'image'
        output = feedForwardImage(X, sLayer, dLayer);
end




end