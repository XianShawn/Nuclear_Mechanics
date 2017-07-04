% main_analyze_membrane


%% clear
clear all;
close all
clearvars -global
%
% initialize
global select_extend1_withdraw2     %
global re_select_roi_N0_L1_C2       % -1 auto, 2 manul 
global show_figure_on1_off1
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

para.speed = 45000;
%% load data

%T24
%pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\T24_updated\April12control\April12txtcontrolgroup\';
%pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\T24_updated\April13noc\April13noctxt\'
%pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\T24_updated\April14CD\April13CDtxt\'
%pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\T24_updated\Nov927intact\';

%RT4
%pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\RT4_updated\Feb17_isolated\';
%pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\RT4_updated\OctWildtype\4\';
pa = 'C:\Users\amnl\Desktop\Xian\data_insitu nuclear mechanics data\XianWang\RT4_updated\NovControl\4\';
%pa = '';
%pa = '';

filename='*.txt';
[filename,pa]=uigetfile([pa filename]);
% load txt in column
 
%define a global pathway
global pfn   ;
FN=dir([pa filename]);
pfn=[pa FN.name];

% z_piezo_NM:height in nm, prc_readout: force in pN 
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
    
%%
    % filter
    sDisplacement_updated = sDisplacement - min(sDisplacement);    
    [fitresult, gof] = createFit_expotential(sDisplacement_updated, sForce);
    a = fitresult.a; 
    b = fitresult.b; % f(x) = a*exp(bx)
    delta_F = a*exp(b*max(sDisplacement_updated)) - a*exp(b*min(sDisplacement_updated)) % nano newton
    delta_d = max(sDisplacement_updated) - min(sDisplacement_updated); % nano meter

    % fit
    sForce_updated = a*exp(b*sDisplacement_updated);
    % step one, calculate the retardation time t = E2/N
    % retardation_time = 0.63*delta_d/para.speed      % retardation time is 63% creep, t = E2/N;
    retardation_time = 0.01;
    % fitting
    % step two, convert data to hertz mode and get the initial value 1/E1
    compliance = 1.33*(para.R^0.5)*(sDisplacement_updated.^1.5)./sForce_updated;
    sD = sDisplacement_updated./retardation_time./para.speed;
       
    
    % step three, fit to get the value, fit 'a' and 'b'
    % compliance = -1/E1*exp(a*/indentation(retardation_time)) + b
    [fitresult_compliance, gof] = createFit_compliance(sD, compliance);
    E1 = 1/fitresult_compliance.b
%     E2 = 1/(fitresult_compliance.a+fitresult_compliance.b)
    E2 = 1/fitresult_compliance.a
    N1 = E2*retardation_time;
    retardation_time;

%     [E1, E2, viscosity_2] = fit_standard_ls(sDisplacement,sForce, para);

 %% save data calculate three values, E1 E2 N1

    membrane.E1 = E1;
    membrane.E2 = E2;
    membrane.sD = sD;
    membrane.compliance = compliance;
    membrane.gof = gof; 
    membrane.N1 = N1;
    membrane.ret = retardation_time;
    
    cd('C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_RT4_SLS\RT4_control');
    save( 'membrane_spot21.mat', 'membrane');
    cd('C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent')
%     
%% save data calculate three values, E1 E2 N1
% 
    nucleus.E1 = E1;
    nucleus.E2 = E2;
    nucleus.sD = sD;
    nucleus.compliance = compliance;
    nucleus.gof = gof; 
    nucleus.N1 = N1;
    nucleus.ret = retardation_time;
    
    cd('C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_RT4_SLS\RT4_control');
    save( 'nucleus_spot21.mat', 'nucleus');
    cd('C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent')

