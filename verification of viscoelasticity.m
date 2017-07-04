% varification the presence of viscoelasticity
% shows the elasticity values are different for different speeds, thus
% proving the material is viscoelastic

%%initialize 
 E_mean = zeros(3,2);
 devi = zeros(3,2);

%% RT4
cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_data_RT4';
%cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_data_T24'

pa2 = pwd;

% cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_data_T24';
D = dir([pa2 '\*.mat'])
Num = length(D(not([D.isdir])))

number_spot_RT4 = Num/3

E_sample = zeros(number_spot_RT4,3);

for i = 1:number_spot_RT4
    load(['spot' num2str(i) '_v30.mat']);
    E_sample(i,1) = youngs.Esample;
    load(['spot' num2str(i) '_v45.mat']);
    E_sample(i,2) = youngs.Esample;
    load(['spot' num2str(i) '_v60.mat']);
    E_sample(i,3) = youngs.Esample;
end

for i = 1:3
    E_mean(i,1) = mean(E_sample(:,i));
    devi(i,1) = std(E_sample(:,i))/sqrt(number_spot_RT4);
    %devi(i) = std(E_sample(:,i));
end
%% T24

%cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_data_RT4';
cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_data_T24'

pa2 = pwd;

D = dir([pa2 '\*.mat'])
Num_T24 = length(D(not([D.isdir])))

number_spot_T24 = Num_T24/3
E_sample = zeros(number_spot_T24,3);

for i = 1:number_spot_T24
    load(['spot' num2str(i) '_v30.mat']);
    E_sample(i,1) = youngs.Esample;
    load(['spot' num2str(i) '_v45.mat']);
    E_sample(i,2) = youngs.Esample;
    load(['spot' num2str(i) '_v60.mat']);
    E_sample(i,3) = youngs.Esample;
end

for i = 1:3
    E_mean(i,2) = mean(E_sample(:,i));
    devi(i,2) = std(E_sample(:,i))/sqrt(number_spot_T24);
end
%% make the figure

figure(2)
bar(E_mean, 0.5), hold on;
title('verification of viscoelasticity');
errorbar(E_mean, devi,'r','LineWidth',2);
hold off
