function [ distance ] = chi2distance( x, y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
distance = bsxfun(@minus, y, x).^2;
distanceDenum = bsxfun(@plus, y, x);
distance = sum(distance ./ (distanceDenum+eps), 2);

%distance = 2*bsxfun(@times, y, x);
%distance = distance ./ ((bsxfun(@plus, y, x))+eps);
%distance = sum(distance, 2);


end

