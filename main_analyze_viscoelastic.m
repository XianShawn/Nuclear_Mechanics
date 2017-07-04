% This main function is used to calculate Real Young's modulus and
% Viscosity using non linear fitting

%% clear
clear all;
close all
clearvars -global

%% initialize

global select_extend1_withdraw2     %
global re_select_roi_N0_L1_C2       % -1 auto, 2 manul 
global show_figure_on1_off0
show_figure_on1_off0=1

re_select_roi_N0_L1_C2=2            % set everything manul
InMain_select_extend1_withdraw2=2   

select_extend1_withdraw2=InMain_select_extend1_withdraw2

% set parameters for both tip and sample
para.indent_data_length=1024;  % length of indent length
para.R=50                    % tip radius of the probe, in nanoNewton
para.v_sample=0.5;            % posion ratio of the sample

para.v_tip=0.5;               % consider the conflict of both tip and sample
para.E_tip=135;%Gpa  
%% load data

%T24
%pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\T24\TxtNov9\TxtNov9\';
% pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\T24\Txtnov27\Txtnov27\';
% pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\T24\Txtnov27_updated\Txtnov27_updated\';

%RT4
%pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\RT4\TxtOct27\';
%pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\RT4\TxtNov24\'
%pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\RT4\TxtOct31_updated\';

%RT4 Nucleus

pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\RT4\Feb17txt\';

filename='*.txt'
[filename,pa]=uigetfile([pa filename])
%filename = 'indent_RT4_Oct27.Spot7.V45.235M.txt';
% load txt in column

%define a global pathway
global pfn   
FN=dir([pa filename])
pfn=[pa FN.name]


% z_piezo_NM:height in nm, prc_readout: force in pN 
%[z_piezo_NM,prc_readout,paras]=read_indentation_file_brucker(pfn);
[z_piezo_NM,prc_readout,z_tip_NM,paras]=read_indentation_file_brucker2(pfn);

% show data

show_indentation_data(z_piezo_NM,prc_readout);


%% level_indentation_data

% [z_piezo_NM_c,prc_readout_adjusted_c]=level_indentation_data(z_piezo_NM,prc_readout);
% 
% Displacement=z_piezo_NM_c{select_extend1_withdraw2};      % convert and use extend data
% Force=prc_readout_adjusted_c{select_extend1_withdraw2};   % convert and use extend data

[z_piezo_NM_c,prc_readout_adjusted_c,z_tip_NM_c]=level_indentation_data2(z_piezo_NM,prc_readout,z_tip_NM);

Displacement=z_piezo_NM_c{select_extend1_withdraw2}-z_tip_NM_c{select_extend1_withdraw2};      % convert and use extend data
Force=prc_readout_adjusted_c{select_extend1_withdraw2};   % convert and use extend data


%% select select indentation roi, this ROI will be used to calculate Young's modulus

    [sDisplacement,sForce,ind]=manual_select_line_roi(Displacement,Force,'select indentation roi',para.indent_data_length,'brucker');
    
    
%% load matlab data file
% for v = 30:15:60
%i = 1; % difine the spot to load

% if v == 30
%     disp('v = 30');
%     load([pa 'spot' num2str(i) '_v30.mat']);
% end
% if v == 45
%     disp('v = 45');
%     load([pa 'spot' num2str(i) '_v45.mat']);
% end
% if v == 60
%     disp('v = 60');
%     load([pa 'spot' num2str(i) '_v60.mat']);
% end
% 
%     sDisplacement = youngs.sDisplacement;
%     sForce = youngs.sForce;

% calculate viscoelasticity 
%% calculate Young's Modulus and Viscosity
% use linearization method to calculate the viscosity
% v = 30;
% [E_sample2,EL,EH,Y,cfL,gofR2] = fit_viscoelasticity_nonlinear(sDisplacement, sForce, para, 0,1);

%% save file

%maybe save mat file saperately and then load to calculate elasticity and
%viscosity then save two parameters again.

    elasvisco.Esample = E_sample2;
    elasvisco.cfL = cfL;
    elasvisco.gofR2 = gofR2;
    elasvisco.sDisplacement = sDisplacement;
    elasvisco.sForce =sForce;
    elasvisco.Y = Y;
    
    index_filename1 = findstr(filename,'Spot');
    if(isempty(index_filename1))
        index_filename1 = findstr(filename,'spot');
    end
    
    index_filename2 = findstr(filename,'V');    
    if(isempty(index_filename2))
        index_filename2 = findstr(filename,'v');
    end
    
    % index_filename2 = index_filename2(2)% this is for November
    filename(index_filename1:(index_filename2+2))
    
    % save to RT4
%     disp('saving to RT4');
%     save([ pwd '\matlab_viscoelas_RT4\' filename(index_filename1:(index_filename2+2)) '.mat'], 'elasvisco');
    % save to T24
    disp('saving to T24');
    save([ pwd '\matlab_viscoelas_T24\' filename(index_filename1:(index_filename2+2)) '.mat'], 'elasvisco');
    

%%
if v == 30
    Y_30 = Y;
end
if v == 45
    Y_45 = Y;
end
if v == 60
    Y_60 = Y;
end

N1 = (Y_60-Y_45)/15e-6;
N2 = (Y_60-Y_30)/30e-6;
N3 = (Y_45-Y_30)/15e-6;



