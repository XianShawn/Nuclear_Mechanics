%% calculation of viscoelasticity_viscosity

% this is for plotting visco part of viscoelasticity 
% only one value for each group of cells

clear all; close all

%% RT4
cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_viscoelas_RT4'

pa2 = 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_viscoelas_RT4';

D = dir([pa2 '\*.mat']);
list = dir('*.mat');
Num_RT4 = length(list);


for i = 1:Num_RT4
    load(list(i).name);
    E_elas(i) = viscosity.elas;
    N_visc(i) = viscosity.N;
end

E_mean_RT4 = mean(E_elas(1:Num_RT4));
E_devi_RT4 = std(E_elas(1:Num_RT4))/sqrt(Num_RT4);
N_mean_RT4 = mean(N_visc(1:Num_RT4));
N_devi_RT4 = std(N_visc(1:Num_RT4))/sqrt(Num_RT4);

%% RT4 nucleus
cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_viscoelas_RT4_nucleus'

pa2 = 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_viscoelas_RT4_nucleus';

D = dir([pa2 '\*.mat']);
list = dir('*.mat');
Num_RT4_n = length(list);


for i = 1:Num_RT4_n
    load(list(i).name);
    E_elas(i) = viscosity.elas;
    N_visc(i) = viscosity.N;
end

E_mean_RT4_n = mean(E_elas(1:Num_RT4_n));
E_devi_RT4_n = std(E_elas(1:Num_RT4_n))/sqrt(Num_RT4_n);
N_mean_RT4_n = mean(N_visc(1:Num_RT4_n));
N_devi_RT4_n = std(N_visc(1:Num_RT4_n))/sqrt(Num_RT4_n);

figure(21)
F(1) = N_mean_RT4;
F(2) = N_mean_RT4_n;
Devi(1) = N_devi_RT4;
Devi(2) = N_devi_RT4_n;
bar(F, 0.5), hold on;
title('Visco- Properties of RT4 and RT4 nucleus');
errorbar(F, Devi,'r','LineWidth',2);
hold off
% bar(E_mean, 0.5), hold on;
% title('verification of viscoelasticity');
% errorbar(E_mean, devi,'r','LineWidth',2);
% hold off
figure(21)
ylabel('Viscoelastic Properties (KPa.s)');
xlabel('Cell Types');






%% T24
cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_viscoelas_T24'
pa2 = 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_viscoelas_T24';

D = dir([pa2 '\*.mat']);
list = dir('*.mat');
Num_T24 = length(list);
%Num_T24 = length(D(not([D.isdir])))

% E_elas = zeros(1:Num_T24);
% N_visc = zeros(1:Num_T24);

for i = 1:Num_T24
    load(list(i).name);
    E_elas(i) = viscosity.elas;
    N_visc(i) = viscosity.N;
end

E_mean_T24 = mean(E_elas(1:Num_T24));
E_devi_T24 = std(E_elas(:))/sqrt(Num_T24);
N_mean_T24 = mean(N_visc(1:Num_T24));
N_devi_T24 = std(N_visc(1:Num_T24))/sqrt(Num_T24);


%% make the figure
figure(22)
F(1) = N_mean_RT4;
F(2) = N_mean_T24;
Devi(1) = N_devi_RT4;
Devi(2) = N_devi_T24;
bar(F, 0.5), hold on;
title('Visco- Properties of RT4 and T24');
errorbar(F, Devi,'r','LineWidth',2);
hold off
% bar(E_mean, 0.5), hold on;
% title('verification of viscoelasticity');
% errorbar(E_mean, devi,'r','LineWidth',2);
% hold off
figure(22)
ylabel('Viscoelastic Properties (KPa.s)');
xlabel('Cell Types');


%%
% figure(3)
% F(1,1) = E_mean_RT4; F(2,1) = N_mean_RT4;
% F(1,2) = E_mean_T24; F(2,2) = N_mean_T24;
% Devi(1,1) = E_devi_RT4;    Devi(2,1) = N_devi_RT4;
% Devi(1,2) = E_devi_T24;    Devi(2,2) = N_devi_T24;
% bar(F, 0.5), hold on;
% title('Viscoelastic Properties of RT4 and T24');
% errorbar(F, Devi,'r','LineWidth',2);
% hold off
