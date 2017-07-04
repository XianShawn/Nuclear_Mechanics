% read data from txt file
% input: filepath
% output: Height in nm, Defl in pN

function [z_piezo_NM,prc_readout,z_tip_NM,paras]=read_indentation_file_brucker2(fn);
% z_piezo_NM       Height_Sensor_nm
% prc_readout      Defl_pN
% paras  

dat=importdata(fn);
if length(dat)==1
    data=dat.data;
    
    for k=1:length(dat.textdata)
        str=dat.textdata{k};
        ind=find(str=='%');
        paras{k}=str2num(str(1:ind-1));
        if isempty(paras{k})
            paras{k}=(str(1:ind-1));
        end
    end
    
else
    data=dat;% compatible with old version
    paras=[];
end

nm=data(:,1);
% data(nm==0,:)=[];
data(isnan(nm),:)=[];
% data=data(1:end-1,:);


z_tip_NM=[data(:,1); data(:,2)];
z_piezo_NM=[data(:,5); data(:,6)]; % Height_Sensor_nm_Ex and Height_Sensor_nm_Rt
% prc_readout=[data(:,1); data(:,2)];% the raw data is nm deflection already
prc_readout=[data(:,3); data(:,4)].*1e-3;% Defl_pN_Ex and Defl_pN_Rt
% z_piezo_NM=[data(:,5);  ];
% prc_readout=[data(:,1);  ];


if prc_readout(z_piezo_NM==max(z_piezo_NM))<mean(prc_readout)
    prc_readout=-prc_readout;
end

end

