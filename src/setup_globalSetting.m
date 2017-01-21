function setup_globalSetting()
% set up the global settings of the system
%   

install_path = pwd;
addpath(install_path); 

%addpath([install_path filesep 'utility_functions']);
%addpath([install_path filesep 'utility_functions/pinky']);
%addpath([install_path filesep 'nis_functions']);
%addpath([install_path filesep 'nn_functions']);
%addpath(genpath([install_path filesep 'tools/liblinear-2.1'])); 

global data_dir
global basesPath 
global tmpFolder
global imgExt
global n_samplePerData
global color_space
global image_canonical_size
global use_cache
global use_gpu

use_gpu = 0;
use_cache = 1;
data_dir = [install_path filesep 'images' filesep];
imgExt = '.jpg';
basesPath = [install_path filesep 'bases' filesep];
tmpFolder = [install_path filesep 'tmpData' filesep];

color_space = 'rgb';

n_samplePerData = [500; 500];   % number of training samples is 200 per image or video 
image_canonical_size = 800;

end

