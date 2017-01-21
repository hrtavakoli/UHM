%function saliency = compute_mcmcSal( img, chaneLen )
% train the filters of the network and save them,
%   Detailed explanation goes here

clc
clear 
close all

addpath(genpath('./src'));
addpath(genpath('./sc-master'));

fprintf('Load image \n')
imageName = 'test.jpg';
im = im2double(imread(imageName));

fprintf('compute saliecny \n')
tic
sal = computeSaliency(im);
toc

fprintf('done. \n')
sc(cat(3, sal, im), 'prob_jet');

rmpath(genpath('./src'));
rmpath(genpath('./sc-master'));