function [ E ] = computeMarkovAttention( featureMatrix , sigma)
%COMPUTEATTENTION computes the amount of attention in terms of expected
%number of steps
%   Input:
%       @featureMatrix: size nxk, n number of samples
%   Ouput:
%       @E: the average step of reaching one node
%

%if isreal(featureMatrix)
% 

% make non-negative by scaling the input
%delta = max(featureMatrix, [], 2) - min(featureMatrix, [], 2);
%featureMatrix = bsxfun(@minus, featureMatrix, min(featureMatrix, [], 2)); % shift the feat
%featureMatrix = bsxfun(@minus, featureMatrix, min(featureMatrix(:))); % shift the features to the 0
%featureMatrix = bsxfun(@rdivide, featureMatrix,  delta);

%featureMatrix(featureMatrix < 0) = 0;
%featureMatrix(featureMatrix > 1) = 1;
%featureMatrix = bsxfun(@rdivide, featureMatrix,  max(featureMatrix, [], 2));

featureMatrix = bsxfun(@rdivide, featureMatrix, sum(featureMatrix, 2)); % L1 normalize

distanceMatrix = pdist2(featureMatrix, featureMatrix, @chi2distance);
%distanceMatrix = pdist2(featureMatrix, featureMatrix, 'Euclidean');
%else
%distanceMatrix = pdist2(featureMatrix, featureMatrix, 'correlation');
%distanceMatrix = pdist2(featureMatrix, featureMatrix, 'cosine');
%distanceMatrix = pdist2(abs(featureMatrix), abs(featureMatrix), @chi2distance);
%end

Deg = diag(sum(distanceMatrix,2));
  
P = Deg\distanceMatrix;

clear distanceMatrix Deg;

% solve pie
[VR, D, VL] = eig(P);
piP = VL(:,1)';
piP = piP / sum(piP);


%W = repmat(piP, [size(P, 1), 1]);
%I = eye(numel(piP));
%Z = inv(I - P + W);

E = 1./piP;

%E = E - mean(E(:));
%E = E / std(E(:));
%E = exp(-E/(0.15*sigma));
E = exp(-E/sigma);

%E = diag(1./piP);

% for i = 1:numel(piP)
%      for j = 1:numel(piP)
%          if ( i ~= j )
%              E(i,j) = E(j,j)*(Z(j,j) - Z(i,j));
%              E(j,i) = E(i,j);
%          end
%      end
% end

end

