function [MP2RAGE,Sa2RAGE] = check_params(MP2RAGE)
%% Check MP2RAGE parameters
if isempty(MP2RAGE.B0)==1
    disp(' ');
    disp('++++ Missing MP2RAGE parameter.');
elseif isempty(MP2RAGE.TR)==1
    disp(' ');
    disp('++++ Missing MP2RAGE parameter.');
elseif isempty(MP2RAGE.TRFLASH)==1
    disp(' ');
    disp('++++ Missing MP2RAGE parameter.');
elseif isempty(MP2RAGE.FlipDegrees)==1
    disp(' ');
    disp('++++ Missing MP2RAGE parameter.');
elseif isempty(MP2RAGE.TIs)==1
    disp(' ');
    disp('++++ Missing MP2RAGE parameter.');
elseif isempty(MP2RAGE.SlicesPerSlab)==1
    disp(' ');
    disp('++++ Missing MP2RAGE parameter.');
elseif isempty(MP2RAGE.PartialFourierInSlice)==1
    disp(' ');
    disp('++++ Missing MP2RAGE parameter.');
else
    disp(' ');
    disp('++++ Using MP2RAGE parameters as specified.');
    % Update to MP2RAGE structure
    MP2RAGE.filenameINV1=[MP2RAGE.filepathINV1,'/',MP2RAGE.filenameINV1,MP2RAGE.extINV1];
    MP2RAGE.filenameINV2=[MP2RAGE.filepathINV2,'/',MP2RAGE.filenameINV2,MP2RAGE.extINV2];
    MP2RAGE.filenameUNI=[MP2RAGE.filepathUNI,'/',MP2RAGE.filenameUNI,MP2RAGE.extUNI];
    MP2RAGE.NZslices=round(MP2RAGE.SlicesPerSlab*[MP2RAGE.PartialFourierInSlice-0.5  0.5]);
end

%% Check Sa2RAGE parameters
if isempty(MP2RAGE.B1correct)==1
    disp(' ');
    disp('++++ B1 correction not specified.');
elseif MP2RAGE.B1correct == 0
    disp(' ');
    disp('++++ B1 correction not performed.');
else
    if isempty(MP2RAGE.sa2rageB1map)==0
        if isempty(MP2RAGE.sa2rageTR)==1
            disp(' ');
            disp('++++ Missing Sa2RAGE parameter.');
            Sa2RAGE=[];
        elseif isempty(MP2RAGE.sa2rageTRFLASH)==1
            disp(' ');
            disp('++++ Missing Sa2RAGE parameter.');
            Sa2RAGE=[];
        elseif isempty(MP2RAGE.sa2rageFlipDegrees)==1
            disp(' ');
            disp('++++ Missing Sa2RAGE parameter.');
            Sa2RAGE=[];
        elseif isempty(MP2RAGE.sa2rageTIs)==1
            disp(' ');
            disp('++++ Missing Sa2RAGE parameter.');
            Sa2RAGE=[];
        elseif isempty(MP2RAGE.sa2rageBaseResolution)==1
            disp(' ');
            disp('++++ Missing Sa2RAGE parameter.');
            Sa2RAGE=[];
        elseif isempty(MP2RAGE.sa2ragePartialFourierInPE)==1
            disp(' ');
            disp('++++ Missing Sa2RAGE parameter.');
            Sa2RAGE=[];
        elseif isempty(MP2RAGE.sa2rageiPATPhaseEncode)==1
            disp(' ');
            disp('++++ Missing Sa2RAGE parameter.');
            Sa2RAGE=[];
        elseif isempty(MP2RAGE.sa2rageRefLines)==1
            disp(' ');
            disp('++++ Missing Sa2RAGE parameter.');
            Sa2RAGE=[];
        elseif isempty(MP2RAGE.sa2rageAverageT1)==1
            disp(' ');
            disp('++++ Missing Sa2RAGE parameter.');
            Sa2RAGE=[];
        else
            disp(' ');
            disp('++++ Using Sa2RAGE parameters as specified.');
            % Create the Sa2RAGE structure
            Sa2RAGE.TR=MP2RAGE.sa2rageTR;
            Sa2RAGE.TRFLASH=MP2RAGE.sa2rageTRFLASH;
            Sa2RAGE.FlipDegrees=MP2RAGE.sa2rageFlipDegrees;
            Sa2RAGE.TIs=MP2RAGE.sa2rageTIs;
            Sa2RAGE.BaseResolution=MP2RAGE.sa2rageBaseResolution;
            Sa2RAGE.PartialFourierInPE=MP2RAGE.sa2ragePartialFourierInPE;
            Sa2RAGE.iPATPhaseEncode=MP2RAGE.sa2rageiPATPhaseEncode;
            Sa2RAGE.RefLines=MP2RAGE.sa2rageRefLines;
            Sa2RAGE.AverageT1=MP2RAGE.sa2rageAverageT1;
            Sa2RAGE.NZslices=Sa2RAGE.BaseResolution * [Sa2RAGE.PartialFourierInPE-0.5  0.5]/Sa2RAGE.iPATPhaseEncode + [Sa2RAGE.RefLines/2 Sa2RAGE.RefLines/2]*(1-1/Sa2RAGE.iPATPhaseEncode);
            % Add to Structure
            Sa2RAGE.filenameINV2=MP2RAGE.sa2rageINV2;
            Sa2RAGE.filenameB1map=MP2RAGE.sa2rageB1map;
        end
    else
        disp(' ');
        disp('++++ Sa2RAGE not specified.');
        Sa2RAGE=[];
    end
end

