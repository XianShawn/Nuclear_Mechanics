% shows the elasticity values 
%%initialize 
close all ; clear all;
E_sample = zeros(26,4);

 %% KO
cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_elas_T24';

pa2 = pwd;

D = dir([pa2 '\*.mat'])
Num = length(D(not([D.isdir])))

number_spot = Num/3;

for i = 1:number_spot
    load(['elasticity_' num2str(i) '_30.mat']);
    E_sample(i,1) = elasticity.E;
    load(['elasticity_' num2str(i) '_45.mat']);
    E_sample(i,2) = elasticity.E;
    load(['elasticity_' num2str(i) '_60.mat']);
    E_sample(i,3) = elasticity.E;

    E_sample(i,4) = mean(E_sample(i,1:3));
end
%%
N = zeros(30,1);
cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_viscoelas_T24'

pa2 = pwd;

D = dir([pa2 '\*.mat'])
Num = length(D(not([D.isdir])))

number_spot = Num;

for i = 29
    load(['viscosity_' num2str(i) '.mat']);
    N(i,1) = viscosity.N;
end




%% WT
cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\helendata\wt2';

pa2 = pwd;

D = dir([pa2 '\*.mat'])
Num = length(D(not([D.isdir])))

number_spot_WT = Num;

E_sample_WT = zeros(Num,1);

for i = 1:number_spot_WT
    load(['wt_spot' num2str(i) '.mat']);
    E_sample_WT(i) = youngs.Esample;
end

E_mean(3) = mean(E_sample_WT)
devi(3) = std(E_sample_WT)/sqrt(Num)

%% plot

figure(2)
bar(E_mean, 0.5), hold on;
title('verification of viscoelasticity');
errorbar(E_mean, devi,'r','LineWidth',2);
hold off
