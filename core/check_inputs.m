function [MP2RAGE] = check_inputs(MP2RAGE)
%% Check required inputs and gunzip if necessary
if isfield(MP2RAGE,'INV1')==1
    if isempty(MP2RAGE.INV1)==1
        disp(' ');
        disp('++++ INV1 image must be specified.');
    else
        disp(' ');
        disp('++++ INV1 image specified.');
        [MP2RAGE.filepathINV1,MP2RAGE.filenameINV1,MP2RAGE.extINV1]=fileparts(MP2RAGE.INV1);
        if MP2RAGE.extINV1 == ".gz"
            disp(' ');
            disp('++++ Unzipping INV1 image');
            % T1
            gunzip([MP2RAGE.filepathINV1,'/',MP2RAGE.filenameINV1,MP2RAGE.extINV1]);
            delete([MP2RAGE.filepathINV1,'/',MP2RAGE.filenameINV1,MP2RAGE.extINV1]);
            MP2RAGE.INV1=[MP2RAGE.filepathINV1,MP2RAGE.filenameINV1];
            disp(['> ',MP2RAGE.filepathINV1,'/',MP2RAGE.filenameINV1,MP2RAGE.extINV1]);
            [MP2RAGE.filepathINV1,MP2RAGE.filenameINV1,MP2RAGE.extINV1]=fileparts(MP2RAGE.INV1);
        end
    end
end

if isfield(MP2RAGE,'INV2')==1
    if isempty(MP2RAGE.INV2)==1
        disp(' ');
        disp('++++ INV2 image must be specified.');
    else
        [MP2RAGE.filepathINV2,MP2RAGE.filenameINV2,MP2RAGE.extINV2]=fileparts(MP2RAGE.INV2);
        if MP2RAGE.extINV2 == ".gz"
            disp(' ');
            disp('++++ Unzipping INV2 image');
            % T1
            gunzip([MP2RAGE.filepathINV2,'/',MP2RAGE.filenameINV2,MP2RAGE.extINV2]);
            delete([MP2RAGE.filepathINV2,'/',MP2RAGE.filenameINV2,MP2RAGE.extINV2]);
            MP2RAGE.INV2=[MP2RAGE.filepathINV2,MP2RAGE.filenameINV2];
            disp(['> ',MP2RAGE.filepathINV2,'/',MP2RAGE.filenameINV2,MP2RAGE.extINV2]);
            [MP2RAGE.filepathINV2,MP2RAGE.filenameINV2,MP2RAGE.extINV2]=fileparts(MP2RAGE.INV2);
        end
    end
end

if isfield(MP2RAGE,'UNI')==1
    if isempty(MP2RAGE.UNI)==1
        disp(' ');
        disp('++++ UNI image must be specified.');
    else
        [MP2RAGE.filepathUNI,MP2RAGE.filenameUNI,MP2RAGE.extUNI]=fileparts(MP2RAGE.UNI);
        if MP2RAGE.extUNI == ".gz"
            disp(' ');
            disp('++++ Unzipping UNI image');
            % T1
            gunzip([MP2RAGE.filepathUNI,'/',MP2RAGE.filenameUNI,MP2RAGE.extUNI]);
            delete([MP2RAGE.filepathUNI,'/',MP2RAGE.filenameUNI,MP2RAGE.extUNI]);
            MP2RAGE.UNI=[MP2RAGE.filepathUNI,MP2RAGE.filenameUNI];
            disp(['> ',MP2RAGE.filepathUNI,'/',MP2RAGE.filenameUNI,MP2RAGE.extUNI]);
            [MP2RAGE.filepathUNI,MP2RAGE.filenameUNI,MP2RAGE.extUNI]=fileparts(MP2RAGE.UNI);
        end
    end
end

%% Check optional inputs and gunzip if necessary
if isfield(MP2RAGE,'T1map')==1
    if isempty(MP2RAGE.T1map)==1
        disp(' ');
        disp('++++ T1 map has not been specified.');
    else
        disp(' ');
        disp('++++ T1 map specified.');
        [MP2RAGE.filepathT1map,MP2RAGE.filenameT1map,MP2RAGE.extT1map]=fileparts(MP2RAGE.T1map);
        if MP2RAGE.extT1map == ".gz"
            disp(' ');
            disp('++++ Unzipping T1 map');
            % T1
            gunzip([MP2RAGE.filepathT1map,'/',MP2RAGE.filenameT1map,MP2RAGE.extT1map]);
            delete([MP2RAGE.filepathT1map,'/',MP2RAGE.filenameT1map,MP2RAGE.extT1map]);
            MP2RAGE.T1map=[MP2RAGE.filepathT1map,MP2RAGE.filenameT1map];
            disp(['> ',MP2RAGE.filepathT1map,'/',MP2RAGE.filenameT1map,MP2RAGE.extT1map]);
            [MP2RAGE.filepathT1map,MP2RAGE.filenameT1map,MP2RAGE.extT1map]=fileparts(MP2RAGE.T1map);
        end
    end
end

if isfield(MP2RAGE,'sa2rageINV2')==1
    if isempty(MP2RAGE.sa2rageINV2)==1
        disp(' ');
        disp('++++ Sa2RAGE INV2 image has not been specified.');
        disp('++++ Coregistration will not be done.');
    else
        disp(' ');
        disp('++++ Sa2RAGE INV2 image specified.');
        [MP2RAGE.filepathsa2rageINV2,MP2RAGE.filenamesa2rageINV2,MP2RAGE.extsa2rageINV2]=fileparts(MP2RAGE.sa2rageINV2);
        if MP2RAGE.extsa2rageINV2 == ".gz"
            disp(' ');
            disp('++++ Unzipping Sa2RAGE INV2 image');
            % Sa2RAGE INV2
            gunzip([MP2RAGE.filepathsa2rageINV2,'/',MP2RAGE.filenamesa2rageINV2,MP2RAGE.extsa2rageINV2]);
            delete([MP2RAGE.filepathsa2rageINV2,'/',MP2RAGE.filenamesa2rageINV2,MP2RAGE.extsa2rageINV2]);
            MP2RAGE.sa2rageINV2=[MP2RAGE.filepathsa2rageINV2,'/',MP2RAGE.filenamesa2rageINV2];
            disp(['> ',MP2RAGE.filepathsa2rageINV2,'/',MP2RAGE.filenamesa2rageINV2,MP2RAGE.extsa2rageINV2]);
            [MP2RAGE.filepathsa2rageINV2,MP2RAGE.filenamesa2rageINV2,MP2RAGE.extsa2rageINV2]=fileparts(MP2RAGE.sa2rageINV2);
        end
    end
end

if isfield(MP2RAGE,'sa2rageB1map')==1
    if isempty(MP2RAGE.sa2rageB1map)==1
        disp(' ');
        disp('++++ Sa2RAGE B1+ map has not been specified.');
    else
        disp(' ');
        disp('++++ Sa2RAGE B1+ map specified.');
        [MP2RAGE.filepathsa2rageB1map,MP2RAGE.filenamesa2rageB1map,MP2RAGE.extsa2rageB1map]=fileparts(MP2RAGE.sa2rageB1map);
        if MP2RAGE.extsa2rageB1map == ".gz"
            disp(' ');
            disp('++++ Unzipping Sa2RAGE B1+ map');
            % Sa2RAGE B1map
            gunzip([MP2RAGE.filepathsa2rageB1map,'/',MP2RAGE.filenamesa2rageB1map,MP2RAGE.extsa2rageB1map]);
            delete([MP2RAGE.filepathsa2rageB1map,'/',MP2RAGE.filenamesa2rageB1map,MP2RAGE.extsa2rageB1map]);
            MP2RAGE.sa2rageB1map=[MP2RAGE.filepathsa2rageB1map,MP2RAGE.filenamesa2rageB1map];
            disp(['> ',MP2RAGE.filepathsa2rageB1map,'/',MP2RAGE.filenamesa2rageB1map,MP2RAGE.extsa2rageB1map]);
            [MP2RAGE.filepathsa2rageB1map,MP2RAGE.filenamesa2rageB1map,MP2RAGE.extsa2rageB1map]=fileparts(MP2RAGE.sa2rageB1map);
        end
    end
end

if isfield(MP2RAGE,'tflB1map')==1
    if isempty(MP2RAGE.tflB1map)==1
        disp(' ');
        disp('++++ TFL B1+ map has not been specified.');
    else
        disp(' ');
        disp('++++ TFL B1+ map specified.');
        [MP2RAGE.filepathtflB1map,MP2RAGE.filenametflB1map,MP2RAGE.exttflB1map]=fileparts(MP2RAGE.tflB1map);
        if MP2RAGE.exttflB1map == ".gz"
            disp(' ');
            disp('++++ Unzipping TFL B1+ map');
            % Sa2RAGE B1map
            gunzip([MP2RAGE.filepathtflB1map,'/',MP2RAGE.filenametflB1map,MP2RAGE.exttflB1map]);
            delete([MP2RAGE.filepathtflB1map,'/',MP2RAGE.filenametflB1map,MP2RAGE.exttflB1map]);
            MP2RAGE.tflB1map=[MP2RAGE.filepathtflB1map,MP2RAGE.filenametflB1map];
            disp(['> ',MP2RAGE.filepathtflB1map,'/',MP2RAGE.filenametflB1map,MP2RAGE.exttflB1map]);
            [MP2RAGE.filepathtflB1map,MP2RAGE.filenametflB1map,MP2RAGE.exttflB1map]=fileparts(MP2RAGE.tflB1map);
        end
    end
end

