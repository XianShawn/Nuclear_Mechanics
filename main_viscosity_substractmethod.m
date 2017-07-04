%uing substract method to calculate the viscosity and then elasticity
%this method could calculate the viscosity value using AFM data in three
%different speeds

% v = 30 45 60 for wild type whole cells
% v = 15 30 45 for drug treated cells or isolated nucleus

%% clear
clear all;
close all
clearvars -global

% intialization

pa = 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\';

global select_extend1_withdraw2     %
global re_select_roi_N0_L1_C2       % -1 auto, 2 manul 
global show_figure_on1_off0
show_figure_on1_off0=1

re_select_roi_N0_L1_C2=2            % set everything manul
InMain_select_extend1_withdraw2=2   

select_extend1_withdraw2=InMain_select_extend1_withdraw2

% set parameters for both tip and sample
para.indent_data_length=1024;  % length of indent length
para.R = 50                    % tip radius of the probe, in nanoNewton
para.v_sample=0.5;            % posion ratio of the sample
para.L_sample=0.000003;       % the thickness of the sample

para.v_tip=0.5;               % consider the conflict of both tip and sample
para.E_tip=135;%Gpa  
para.u = 0.000030;


%% plot previous result

%cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_data_T24\'
%cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_data_RT4'
%cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_data_nucleus_RT4'
cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_T24_SLS\T24_control\Youngs_membrane'

i = 1; % difine the spot to load
% load the file separately and save Esmaple to matrix E
load(['spot' num2str(i) '_v15.mat']);
E_single(1) = youngs.Esample;
distance_1 = youngs.sDisplacement - min(youngs.sDisplacement);
force_1 = youngs.sForce - min(youngs.sForce); 
cfL_youngs1 = youngs.cfL;

load(['spot' num2str(i) '_v30.mat']);
E_single(2) = youngs.Esample;
distance_2 = youngs.sDisplacement - min(youngs.sDisplacement);
force_2 = youngs.sForce - min(youngs.sForce); 
cfL_youngs2 = youngs.cfL;

load(['spot' num2str(i) '_v45.mat']);
E_single(3) = youngs.Esample;
distance_3 = youngs.sDisplacement - min(youngs.sDisplacement);
force_3 = youngs.sForce - min(youngs.sForce); 
cfL_youngs3 = youngs.cfL;

figure(1)
bar(E_single, 0.5);
title(i);

cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent'

%% 
i_case_1 = 2;
% figure(2)
% plot(distance_1,force_1), hold on;
% plot(distance_2,force_2), hold on;
% plot(distance_3,force_3), hold on;

len = min(max(distance_1),max(distance_2))
len = min(len, max(distance_3))
mid = 0:0.1:len;

[cfL_1, gof_1] = createFit_spline(distance_1,force_1)
for_1=feval(cfL_1,mid);
[cfL_2, gof_2] = createFit_spline(distance_2,force_2)
for_2=feval(cfL_2,mid);
[cfL_3, gof_3] = createFit_spline(distance_3,force_3)
for_3=feval(cfL_3,mid);

figure(3),plot(mid,for_1), hold on;
figure(3),plot(mid,for_2), hold on;
figure(3),plot(mid,for_3), hold on;


if i_case_1 == 1 % 30 45
    force_mid = 2*(for_2 - for_1);
end

if i_case_1 == 2 % 45 60
    force_mid = 2*(for_3 - for_2);
end

if i_case_1 ==3  % 30 60
    force_mid = (for_3 - for_1);
end

figure(3), plot(mid,force_mid);
%% select select indentation roi, this ROI will be used to calculate Young's modulus

[sDis,sFor,ind]=manual_select_line_roi(mid,force_mid,'select indentation roi');
[cfL_viscosity,gofR2] = createFit_line_poly_N(sDis, sFor, 1);

Y = cfL_viscosity.p1;
N = (para.L_sample*Y)/(3.14* para.u * para.R )

%% calculate the elasticity based on previous viscosity

% i_case_2 = 1; % 1 use 30, 2 use 45, 3 use 60
% 
% R=para.R;
% v_sample=para.v_sample;
% v_tip=para.v_tip;
% E_tip=para.E_tip;
% 
% if i_case_2 == 1
% %     for_elas = for_1 - force_mid;
%     K = cfL_youngs1.p1^(3/2) - cfL_viscosity.p1; 
% end
% if i_case_2 == 2
% %     for_elas = for_2 - 1.5*force_mid;
%     K = cfL_youngs2.p1^(3/2) - 1.5*cfL_viscosity.p1;
% end
% if i_case_2 == 3
% %     for_elas = for_1 - 2*force_mid;
%     K = cfL_youngs3.p1^(3/2) - 2*cfL_viscosity.p1;
% end
% 
% % L_force_elas=for_elas.^(2/3);
% %[sDis_elas,sFor_elas,ind]=manual_select_line_roi(mid,for_elas,'select indentation roi');
% %[cfL_elas,gofR2] = createFit_line_poly_N(sDis_elas, sFor_elas, 1);
% 
% % [cfL_elas,gofR2] = createFit_line_poly_N(mid, L_force_elas, 1);
% % K = cfL_elas.p1;
% % Ex=K / (1.333 * sqrt(R));
% % E_sample=(1-v_sample^2)./(1./Ex-(1-v_tip^2)./E_tip)
% 
% % K = cfL_1.p1^(3/2) - cfL_viscosity.p1;
% Ex=K / (1.333 * sqrt(R));
% E_sample=(1-v_sample^2)./(1./Ex-(1-v_tip^2)./E_tip)

i_case_2 = 3; % 1 use 30, 2 use 45, 3 use 60

if i_case_2 == 1 % 30  45
%     for_elas = for_1 - force_mid;
    E_v = E_single(1) - 1*(E_single(2) - E_single(1)); 
end
if i_case_2 == 2 % 45  60
%     for_elas = for_2 - 1.5*force_mid;
    E_v = E_single(2) - 2*(E_single(3) - E_single(2)); 
end
if i_case_2 == 3 % 30  60
%     for_elas = for_1 - 2*force_mid;
    E_v = E_single(3) - 3*(E_single(2) - E_single(1)); 
end

%     E_v = 0.5*(E_single(1)+E_single(3)) - 3*(E_single(2) - E_single(1))
%     E_v = E_single(2) - 3*(E_single(3) - E_single(2))
%     E_v = E_single(1) - (E_single(3) - E_single(1))
%     E_v = E_single(3) - 4*(E_single(3) - E_single(2))
%% save viscosity 
viscosity.N = N;
viscosity.cfL= cfL_viscosity;
viscosity.distance = sDis;
viscosity.distance = sFor;
viscosity.force_mid = force_mid;
viscosity.mid = mid;
viscosity.E_v = E_v
    % save to RT4
    disp('saving to RT4');
    save([ pwd '\matlab_viscoelas_RT4\' 'viscosity_'  num2str(i)   '.mat'], 'viscosity');
    % save to T24
%     disp('saving to T24');
%     save([ pwd '\matlab_viscoelas_T24\' 'viscosity_'  num2str(i)   '.mat'], 'viscosity');