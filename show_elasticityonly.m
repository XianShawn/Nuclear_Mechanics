% shows the elasticity values 
%%initialize 
close all ; clear all;
E_mean = zeros(4,1);
devi = zeros(4,1);

 %% KO
cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\helendata\ko2';

pa2 = pwd;

D = dir([pa2 '\*.mat'])
Num = length(D(not([D.isdir])))

number_spot_KO = Num;

E_sample_KO = zeros(Num,1);

for i = 1:number_spot_KO
    load(['ko_spot' num2str(i) '.mat']);
    E_sample_KO(i) = youngs.Esample;

end


E_mean(4) = mean(E_sample_KO)
devi(4) = std(E_sample_KO)/sqrt(Num)

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
