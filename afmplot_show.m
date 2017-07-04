% This main function is used to calculate recorded young's modulus using
% linear curve fitting

%% clear
clear all;
close all
clearvars -global

% initialize
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
para.L_sample=0.000003;       % the thickness of the sample

para.v_tip=0.5;               % consider the conflict of both tip and sample
para.E_tip=135;%Gpa  
para.u = 0.00003;

%% load data

%pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\Helen\WT\';%664
pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\Helen\KO\'; %629
%pa = 'C:\Users\amnl\Desktop\minimage\'

filename='*.txt'
[filename,pa]=uigetfile([pa filename])
% load txt in column
 
%define a global pathway
global pfn   
FN=dir([pa filename])
pfn=[pa FN.name]

% z_piezo_NM:height in nm, prc_readout: force in pN 
[z_piezo_NM,prc_readout,z_tip_NM,paras]=read_indentation_file_brucker2(pfn);

% show data
show_indentation_data(z_piezo_NM,prc_readout);


%% level_indentation_data

% [z_piezo_NM_c,prc_readout_adjusted_c]=level_indentation_data(z_piezo_NM,prc_readout);

[z_piezo_NM_c,prc_readout_adjusted_c,z_tip_NM_c] = level_indentation_data2(z_piezo_NM,prc_readout,z_tip_NM);

% Displacement = z_piezo_NM_c{select_extend1_withdraw2}-z_tip_NM_c{select_extend1_withdraw2};      % convert and use extend data
% Force = prc_readout_adjusted_c{select_extend1_withdraw2};   % convert and use extend data
% Displacement_updated = Displacement - min(Displacement);

Displacement = z_piezo_NM_c{1}-z_tip_NM_c{1};      % convert and use extend data
Force_1 = prc_readout_adjusted_c{1};   % convert and use extend data
Displacement_indent = Displacement - min(Displacement);


Force_2 = prc_readout_adjusted_c{2};

force_indent_size = size(Force_1);
force_retract_size = size(Force_2);


if (force_indent_size(1) > force_retract_size(1))|| (force_indent_size(1) == force_retract_size(1))
    Displacement_retract = flipud(Displacement_indent);
    figure(6), plot(Displacement_indent,Force_1,'b','LineWidth',4 ), hold on
    plot(Displacement_retract(1:force_retract_size), Force_2,'r','LineWidth',4);
end;

if force_indent_size(1) < force_retract_size(1)
      Displacement_retract = flipud(Displacement_indent);
    figure(6), plot(Displacement_indent,Force_1,'b','LineWidth',4 ), hold on
    plot(Displacement_retract, Force_2(1:force_indent_size),'r','LineWidth',4);
end;  

 %% wild type
% Displacement_wt = Displacement_indent(207:681);
% Displacement_wt = Displacement_wt - min(Displacement_wt);
% Force_1_wt = Force_1(207:681);
% Force_1_wt = Force_1_wt - min(Force_1_wt);
% figure(7),plot(Displacement_wt,Force_1_wt,'b','LineWidth',4 )
% ylim([0,0.8]);
% xlim([0,2500]);
% 
 %% ko A+B
% Displacement_wt = Displacement_indent(137:721);
% Displacement_wt = Displacement_wt - min(Displacement_wt);
% Force_1_wt = Force_1(137:721);
% Force_1_wt = Force_1_wt - min(Force_1_wt);
% figure(8),plot(Displacement_wt,Force_1_wt,'b','LineWidth',4 )
% ylim([0,0.8]);
% xlim([0,2500]);

 %% wild type
Displacement_wt = Displacement_indent(207:570);
Displacement_wt = Displacement_wt - min(Displacement_wt);
Force_1_wt = Force_1(207:570);
Force_1_wt = Force_1_wt - min(Force_1_wt);
figure(7),plot(Displacement_wt,Force_1_wt,'b','LineWidth',4 )
ylim([0,0.6]);
xlim([0,2200]);

%% ko A+B
Displacement_wt = Displacement_indent(137:564);
Displacement_wt = Displacement_wt - min(Displacement_wt);
Force_1_wt = Force_1(137:564);
Force_1_wt = Force_1_wt - min(Force_1_wt);
figure(8),plot(Displacement_wt,Force_1_wt,'b','LineWidth',3 )
ylim([0,0.6]);
xlim([0,2200]);
%% select select indentation roi, this ROI will be used to calculate Young's modulus

%     [sDisplacement,sForce,ind]=manual_select_line_roi(Displacement,Force,'select indentation roi',para.indent_data_length,'brucker');

    
