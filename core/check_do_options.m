function [MP2RAGE,Sa2RAGE] = check_do_options(MP2RAGE,Sa2RAGE)
%% Check for background removal options
if isempty(MP2RAGE.DenoiseWeight)==0
    disp(' ');
    disp('++++ Specified weighting will be used.');
    disp(['> ',num2str(MP2RAGE.DenoiseWeight)]);
else
    MP2RAGE.DenoiseWeight = 10;
    disp(' ');
    disp('++++ Default weighting will be used.');
    disp(['> ',num2str(MP2RAGE.DenoiseWeight)]);
end
if MP2RAGE.DenoiseUNI == 1
    disp(' ');
    disp('++++ Background denoised UNI will be produced.');
    MP2RAGE.filenameOUT=[MP2RAGE.filenameUNI(1:end-4),'_clean.nii'];
    MP2RAGE.filenameIMGOUT=[MP2RAGE.filenameUNI(1:end-4),'_robust.png'];
    % Denoise
    [MP2RAGEimgRobustPhaseSensitive]=RobustCombination(MP2RAGE.filenameUNI,MP2RAGE,MP2RAGE.DenoiseWeight,1);
else
    disp(' ');
    disp('++++ Background denoised UNI will not be produced.');
end

if isempty(MP2RAGE.T1map) == 1
    disp(' ');
    disp('++++ T1map file is not provided. Will calculate T1map first.');
    MP2RAGE.CalculateT1map = 1;
    
elseif isempty(MP2RAGE.T1map) == 0
    
    if MP2RAGE.DenoiseT1map == 1
        disp(' ');
        disp('++++ Background denoised T1map will be produced.');
        MP2RAGE.filenameOUT=[MP2RAGE.filenameT1map(1:end-4),'_clean.nii'];
        MP2RAGE.filenameIMGOUT=[MP2RAGE.filenameT1map(1:end-4),'_robust.png'];
        % Denoise
        [MP2RAGEimgRobustPhaseSensitive]=RobustCombination(MP2RAGE.filenameT1map,MP2RAGE,MP2RAGE.DenoiseWeight,1);
    else
        disp(' ');
        disp('++++ Background denoised T1map will not be produced.');
    end
end

%% Check for additional map calculation
if MP2RAGE.CalculateT1map == 1
    disp(' ');
    disp('++++ T1map will be calculated.');
    % Load data
    MP2RAGEimg=load_untouch_nii(MP2RAGE.filenameUNI);
    MP2RAGEINV2img=load_untouch_nii(MP2RAGE.filenameINV2);
    [ T1map , ~ , ~ ]=T1M0estimateMP2RAGE(MP2RAGEimg,MP2RAGEINV2img,MP2RAGE,0.96);
    
    % Fix filetype and save
    T1map.hdr.dime.datatype=16;
    T1map.hdr.dime.bitpix=32;
    T1map.img = 1000.*(T1map.img); % T1 in ms
    
    [~,fname,~] = fileparts(MP2RAGE.filenameUNI);
    
    if contains(fname,'UNI','IgnoreCase',true)==1
        MP2RAGE.filenameT1out=regexprep(fname,'UNI','calcT1map','ignorecase');
        MP2RAGE.filenameT1out=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenameT1out,'.nii'];
    elseif contains(MP2RAGE.filenameUNI,'T1w','IgnoreCase',true)==1
        MP2RAGE.filenameT1out=regexprep(fname,'T1w','calcT1map','ignorecase');
        MP2RAGE.filenameT1out=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenameT1out,'.nii'];
    else
        MP2RAGE.filenameT1out=[MP2RAGE.filepathUNI,'/','MP2RAGE_calcT1map.nii'];
        disp(['> Output file is called : ',MP2RAGE.filenameT1out]);
    end
    save_untouch_nii(T1map,MP2RAGE.filenameT1out);
    
    if MP2RAGE.DenoiseT1map == 1
        disp(' ');
        disp('++++ Background denoised T1map will be produced.');
        MP2RAGE.filenameOUT=[MP2RAGE.filenameT1out(1:end-4),'_clean.nii'];
        MP2RAGE.filenameIMGOUT=[MP2RAGE.filenameT1out(1:end-4),'_robust.png'];
        % Denoise
        [MP2RAGEimgRobustPhaseSensitive]=RobustCombination(MP2RAGE.filenameT1out,MP2RAGE,MP2RAGE.DenoiseWeight,1);
    else
        disp(' ');
        disp('++++ Background denoised T1map will not be produced.');
    end
    
else
    disp(' ');
    disp('++++ T1map will not be calculated');
end

if MP2RAGE.CalculateR1map == 1
    disp(' ');
    disp('++++ R1map will be calculated.');
    % Load data
    MP2RAGEimg=load_untouch_nii(MP2RAGE.filenameUNI);
    MP2RAGEINV2img=load_untouch_nii(MP2RAGE.filenameINV2);
    [ ~ , ~ , R1map ]=T1M0estimateMP2RAGE(MP2RAGEimg,MP2RAGEINV2img,MP2RAGE,0.96);
    
    R1map.hdr.dime.datatype=16;
    R1map.hdr.dime.bitpix=32;
    R1map.img = 1000.*(R1map.img); % R1 in per milliseconds
    
    [~,fname,~] = fileparts(MP2RAGE.filenameUNI);
    
    if contains(fname,'UNI','IgnoreCase',true)==1
        MP2RAGE.filenameR1out=regexprep(fname,'UNI','calcR1map','ignorecase');
        MP2RAGE.filenameR1out=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenameR1out,'.nii'];
    elseif contains(fname,'T1w','IgnoreCase',true)==1
        MP2RAGE.filenameR1out=regexprep(fname,'T1w','calcR1map','ignorecase');
        MP2RAGE.filenameR1out=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenameR1out,'.nii'];
    else
        MP2RAGE.filenameR1out=[MP2RAGE.filepathUNI,'/','MP2RAGE_calcR1map.nii'];
        disp(['> Output file is called : ',MP2RAGE.filenameR1out]);
    end
    save_untouch_nii(R1map,MP2RAGE.filenameR1out);
    
    if MP2RAGE.DenoiseT1map == 1
        disp(' ');
        disp('++++ Background denoised R1map will be produced.');
        MP2RAGE.filenameOUT=[MP2RAGE.filenameR1out(1:end-4),'_clean.nii'];
        MP2RAGE.filenameIMGOUT=[MP2RAGE.filenameR1out(1:end-4),'_robust.png'];
        % Denoise
        [MP2RAGEimgRobustPhaseSensitive]=RobustCombination(MP2RAGE.filenameR1out,MP2RAGE,MP2RAGE.DenoiseWeight,1);
    else
        disp(' ');
        disp('++++ Background denoised R1map will not be produced.');
    end
    
else
    disp(' ');
    disp('++++ R1map will not be calculated');
end

if MP2RAGE.CalculateM0map == 1
    disp(' ');
    disp('++++ M0map will be calculated.');
    % Load data
    MP2RAGEimg=load_untouch_nii(MP2RAGE.filenameUNI);
    MP2RAGEINV2img=load_untouch_nii(MP2RAGE.filenameINV2);
    [ ~ , M0map , ~ ]=T1M0estimateMP2RAGE(MP2RAGEimg,MP2RAGEINV2img,MP2RAGE,0.96);
    
    M0map.hdr.dime.datatype=16;
    M0map.hdr.dime.bitpix=32;
    M0map.img = 1000.*(M0map.img); % M0
    
    [~,fname,~] = fileparts(MP2RAGE.filenameUNI);
    
    if contains(fname,'UNI','IgnoreCase',true)==1
        MP2RAGE.filenameM0out=regexprep(fname,'UNI','calcM0map','ignorecase');
        MP2RAGE.filenameM0out=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenameM0out,'.nii'];
    elseif contains(fname,'T1w','IgnoreCase',true)==1
        MP2RAGE.filenameM0out=regexprep(fname,'T1w','calcM0map','ignorecase');
        MP2RAGE.filenameM0out=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenameM0out,'.nii'];
    else
        MP2RAGE.filenameM0out=[MP2RAGE.filepathUNI,'/','MP2RAGE_calcM0map.nii'];
        disp(['> Output file is called : ',MP2RAGE.filenameM0out]);
    end
    save_untouch_nii(M0map,MP2RAGE.filenameM0out);
    
else
    disp(' ');
    disp('++++ M0map will not be calculated');
end

%% Check for B1 correction options
% # B1+ correction (1 = yes, 0 = no), coregister requires SPM
% B1correct: 1
% Coregister: 1 <- chcked internally
if isfield(MP2RAGE,'B1correct')==1
    if isempty(MP2RAGE.sa2rageB1map)==0
        % Register/Reslice Sa2RAGE B1 map in INV2 space
        [MP2RAGE,Sa2RAGE] = check_register(MP2RAGE,Sa2RAGE);
        B1=load_untouch_nii(Sa2RAGE.B1filename);
        MP2RAGEimg=load_untouch_nii(MP2RAGE.filenameUNI);
        [ B1corr T1corrected MP2RAGEcorr] = T1B1correctpackage( [],B1,Sa2RAGE,MP2RAGEimg,[],MP2RAGE,[],0.96);
    elseif isempty(MP2RAGE.sa2rageB1map)==1
        disp(' ');
        disp('++++ Sa2RAGE B1 map not specified. Will look for TFL B1 map.');
        if isempty(MP2RAGE.tflB1map)==0
            disp(' ');
            disp('++++ TFL B1 map is specified.');
            % Register/Reslice TFL B1 map in INV2 space
            [MP2RAGE,Sa2RAGE] = check_register(MP2RAGE,Sa2RAGE);
            B1=load_untouch_nii(MP2RAGE.TFLB1filename);
            B1.img=double(B1.img)/1000; % rescale
            MP2RAGEimg=load_untouch_nii([MP2RAGE.filepathUNI,'/',MP2RAGE.filenameUNI]);
            [ T1corrected MP2RAGEcorr] = T1B1correctpackageTFL(B1,MP2RAGEimg,[],MP2RAGE,[],0.96);
        else
            disp(' ');
            disp('++++ TFL B1 map is also not specified.');
            return;
        end
    end
    
    % saving the data
    [~,fname,~] = fileparts(MP2RAGE.filenameUNI);
    if contains(fname,'UNI','IgnoreCase',true)==1
        MP2RAGE.filenameUNIcorrout=regexprep(fname,'UNI','corrUNI','ignorecase');
        MP2RAGE.filenameUNIcorrout=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenameUNIcorrout,'.nii'];
    elseif contains(fname,'T1w','IgnoreCase',true)==1
        MP2RAGE.filenameUNIcorrout=regexprep(fname,'T1w','corrUNI','ignorecase');
        MP2RAGE.filenameUNIcorrout=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenameUNIcorrout,'.nii'];
    else
        MP2RAGE.filenameUNIcorrout=[MP2RAGE.filepathUNI,'/','MP2RAGE_corrUNI.nii'];
    end
    disp(['> Output file is called : ',MP2RAGE.filenameUNIcorrout]);
    save_untouch_nii(MP2RAGEcorr,MP2RAGE.filenameUNIcorrout);
    
    if contains(fname,'UNI','IgnoreCase',true)==1
        MP2RAGE.filenameT1corrout=regexprep(fname,'UNI','corrT1','ignorecase');
        MP2RAGE.filenameT1corrout=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenameT1corrout,'.nii'];
    elseif contains(fname,'T1w','IgnoreCase',true)==1
        MP2RAGE.filenameT1corrout=regexprep(fname,'T1w','corrT1','ignorecase');
        MP2RAGE.filenameT1corrout=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenameT1corrout,'.nii'];
    else
        MP2RAGE.filenameT1corrout=[MP2RAGE.filepathUNI,'/','MP2RAGE_corrT1.nii'];
    end
    disp(['> Output file is called : ',MP2RAGE.filenameT1corrout]);
    save_untouch_nii(T1corrected,MP2RAGE.filenameT1corrout);
else
    disp(' ');
    disp('++++ B1 correction requires a B1 map to be specified.');
end