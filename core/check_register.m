function [MP2RAGE,Sa2RAGE] = check_register(MP2RAGE,Sa2RAGE)
%% Check if SPM Directory exists on path
if exist('spm')==0
    disp('++++ SPM directory not found in path.');
    disp('++++ SPM is required.');
    disp(' ');
    spm_directory=uigetdir(matlabroot,'Select directory with SPM 12');
    addpath(spm_directory);
    disp(['> ',spm_directory]);
    disp(['> Added to path']);
else
    spm_directory=which('spm');
    [spm_directory,~,~]=fileparts(spm_directory);
    disp('++++ SPM directory exists in path.');
    disp(['> ',spm_directory]);
    
end
%% Check for TFL map
if isempty(MP2RAGE.tflB1map)==0
    %% Setup matlabbatch
    clear matlabbatch;
    matlabbatch{1}.spm.spatial.coreg.write.ref = {[MP2RAGE.filepathINV2,'/',MP2RAGE.filenameINV2,',1']};
    matlabbatch{1}.spm.spatial.coreg.write.source = {[MP2RAGE.filepathtflB1map,'/',MP2RAGE.filenametflB1map,MP2RAGE.exttflB1map,',1']};
    matlabbatch{1}.spm.spatial.coreg.write.roptions.interp = 7;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.coreg.write.roptions.mask = 0;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.prefix = 'rs_';
    %% Start SPM Job
    spm('defaults', 'FMRI');
    spm_jobman('run', matlabbatch);
    %% Rename registered B1 map
    copyfile([MP2RAGE.filepathtflB1map,'/rs_',MP2RAGE.filenametflB1map,MP2RAGE.exttflB1map],[MP2RAGE.filepathUNI,'/',MP2RAGE.filenametflB1map,'_resliced.nii']);
    delete([MP2RAGE.filepathtflB1map,'/rs_',MP2RAGE.filenametflB1map,MP2RAGE.exttflB1map]);
    MP2RAGE.TFLB1filename=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenametflB1map,'_resliced.nii'];
elseif isempty(MP2RAGE.filepathsa2rageB1map)==0
    %% Check for coregistration
    if isempty(MP2RAGE.Coregister)==1
        MP2RAGE.Coregister = 0;
    elseif MP2RAGE.Coregister == 1
        %% Setup matlabbatch
        clear matlabbatch;
        matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {[MP2RAGE.filenameINV2,',1']};
        matlabbatch{1}.spm.spatial.coreg.estwrite.source = {[MP2RAGE.filepathsa2rageINV2,'/',MP2RAGE.filenamesa2rageINV2,MP2RAGE.extsa2rageINV2,',1']};
        matlabbatch{1}.spm.spatial.coreg.estwrite.other = {[MP2RAGE.filepathsa2rageB1map,'/',MP2RAGE.filenamesa2rageB1map,MP2RAGE.extsa2rageB1map,',1']};
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2 1];
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [4 4];
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 7;
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'cr_';
        %% Start SPM Job
        spm('defaults', 'FMRI');
        spm_jobman('run', matlabbatch);
        %% Rename registered B1 map
        copyfile([MP2RAGE.filepathsa2rageB1map,'/cr_',MP2RAGE.filenamesa2rageB1map,MP2RAGE.extsa2rageB1map],[MP2RAGE.filepathUNI,'/',MP2RAGE.filenamesa2rageB1map,'_resliced.nii']);
        delete([MP2RAGE.filepathsa2rageB1map,'/cr_',MP2RAGE.filenamesa2rageB1map,MP2RAGE.extsa2rageB1map]);
        delete([MP2RAGE.filepathsa2rageINV2,'/cr_',MP2RAGE.filenamesa2rageINV2,MP2RAGE.extsa2rageINV2]);
        Sa2RAGE.B1filename=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenamesa2rageB1map,'_resliced.nii'];
    elseif MP2RAGE.Coregister == 0
        %% Setup matlabbatch
        clear matlabbatch;
        matlabbatch{1}.spm.spatial.coreg.write.ref = {[MP2RAGE.filenameINV2,',1']};
        matlabbatch{1}.spm.spatial.coreg.write.source = {[MP2RAGE.filepathsa2rageB1map,'/',MP2RAGE.filenamesa2rageB1map,MP2RAGE.extsa2rageB1map,',1']};
        matlabbatch{1}.spm.spatial.coreg.write.roptions.interp = 7;
        matlabbatch{1}.spm.spatial.coreg.write.roptions.wrap = [0 0 0];
        matlabbatch{1}.spm.spatial.coreg.write.roptions.mask = 0;
        matlabbatch{1}.spm.spatial.coreg.write.roptions.prefix = 'rs_';
        %% Start SPM Job
        spm('defaults', 'FMRI');
        spm_jobman('run', matlabbatch);
        %% Rename registered B1 map
        copyfile([MP2RAGE.filepathsa2rageB1map,'/rs_',MP2RAGE.filenamesa2rageB1map,MP2RAGE.extsa2rageB1map],[MP2RAGE.filepathUNI,'/',MP2RAGE.filenamesa2rageB1map,'_resliced.nii']);
        delete([MP2RAGE.filepathsa2rageB1map,'/rs_',MP2RAGE.filenamesa2rageB1map,MP2RAGE.extsa2rageB1map]);
        Sa2RAGE.B1filename=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenamesa2rageB1map,'_resliced.nii'];
    end
    
end

