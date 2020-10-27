function mp2rage_main(config_file)
disp(' ');
disp('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
disp([datestr(datetime('now')),'        MP2RAGE-Utils']);
disp('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
disp(' ');
%% Do checks
% Check if check_inputs exists on path
if exist('check_inputs')==0
    disp('++++ MP2RAGE-utils sub-dirs required in path.');
    disp(' ');
    utils_directory=uigetdir(matlabroot,'Select MP2RAGE-utils directory');
    addpath(genpath(utils_directory));
    disp(['> ',utils_directory]);
    disp(['> Added to path']);
else
    utils_directory=which('check_inputs');
    [utils_directory,~,~]=fileparts(utils_directory);
    disp('++++ MP2RAGE-Utils directory exists in path.');
    disp(['> ',utils_directory]);
end
% Check if config file was provided
if exist('config_file','var')==1
    disp(' ');
    disp('++++ Config file found.');
    disp(['> ',config_file]);
else
    config_file=uigetfile('*.yml','Select Config file');
    disp(' ');
    disp('++++ Config file found.');
    disp(['> ',config_file]);
end
%% Read Config file
MP2RAGE = ReadYaml(config_file);
%% Check input parameters
MP2RAGE = check_inputs(MP2RAGE);
%% Check parameters and necessary setup
[MP2RAGE,Sa2RAGE] = check_params(MP2RAGE);
%% Check options
[MP2RAGE,Sa2RAGE] = check_do_options(MP2RAGE,Sa2RAGE);

