function [ sal ] = normalizeSalVal( sal )
%NORMALIZESALVAL Summary of this function goes here
%   Detailed explanation goes here

sal = ( sal - min(sal(:)) ) / (max(sal(:)) - min(sal(:)));
end

