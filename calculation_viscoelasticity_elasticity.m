%% calculation of viscoelasticity_elasticity

% this is for plotting elas part of viscoelasticity 
% the final values of the mean of the different speeds' mean

clear all; close all

%% RT4
 cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_elas_RT4'
 pa2 = 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_elas_RT4\';
 E_RT4 = zeros(23,3);
 Num_RT4 = 23;

for i = 1:Num_RT4
    st = ['elasticity_' num2str(i) '_**'];
    x = dir(st);
    for j = 1:3
        pfn = [pa2 x(j).name];
        load(pfn);
        E_RT4(i,j) = elasticity.E;
    end
end

 E_mean_RT4_30 = mean(E_RT4(:,1))
 E_mean_RT4_45 = mean(E_RT4(:,2))
 E_mean_RT4_60 = mean(E_RT4(:,3))
% E_devi_RT4 = std(E_elas(1:Num_RT4))/sqrt(Num_RT4);

%% RT4 nucleus
 cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_elas_RT4_nucleus'
 pa2 = 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_elas_RT4_nucleus\';
 E_RT4_n = zeros(20,3);
 Num_RT4_n = 20;

for i = 1:Num_RT4_n
    st = ['elasticity_' num2str(i) '_**'];
    x = dir(st);
    for j = 1:3
        pfn = [pa2 x(j).name];
        load(pfn);
        E_RT4_n(i,j) = elasticity.E;
    end
end

 E_mean_RT4_15_n = mean(E_RT4_n(:,1))
 E_mean_RT4_30_n = mean(E_RT4_n(:,2))
 E_mean_RT4_45_n = mean(E_RT4_n(:,3))
% E_devi_RT4 = std(E_elas(1:Num_RT4))/sqrt(Num_RT4);

%%
E_mean(1,1) =  E_mean_RT4_30;
E_mean(2,1) =  E_mean_RT4_45;
E_mean(3,1) =  E_mean_RT4_60;
devi(1,1) = std(E_RT4(:,1))/sqrt(Num_RT4);
devi(2,1) = std(E_RT4(:,2))/sqrt(Num_RT4);
devi(3,1) = std(E_RT4(:,3))/sqrt(Num_RT4);

E_mean(1,2) =  E_mean_RT4_15_n;
E_mean(2,2) =  E_mean_RT4_30_n;
E_mean(3,2) =  E_mean_RT4_45_n;
devi(1,2) = std(E_RT4_n(:,1))/sqrt(Num_RT4_n);
devi(2,2) = std(E_RT4_n(:,2))/sqrt(Num_RT4_n);
devi(3,2) = std(E_RT4_n(:,3))/sqrt(Num_RT4_n);

% plot nucleus with the original
E_mean_RT4 = mean(E_mean(:,1));
E_RT4_devi(1:Num_RT4) = E_RT4(:,1);
E_RT4_devi(Num_RT4+1:2*Num_RT4) = E_RT4(:,2);
E_RT4_devi(2*Num_RT4+1:3*Num_RT4) = E_RT4(:,3);
E_devi_RT4 = std(E_RT4_devi)/sqrt(3*Num_RT4);

E_mean_RT4_n = mean(E_mean(:,2));
E_RT4_n_devi(1:Num_RT4_n) = E_RT4_n(:,1);
E_RT4_n_devi(Num_RT4_n+1:2*Num_RT4_n) = E_RT4_n(:,2);
E_RT4_n_devi(2*Num_RT4_n+1:3*Num_RT4_n) = E_RT4_n(:,3);
E_devi_RT4_n = std(E_RT4_n_devi)/sqrt(3*Num_RT4_n);

figure(11)
F(1) = E_mean_RT4;
F(2) = E_mean_RT4_n;
Devi(1) = E_devi_RT4;
Devi(2) = E_devi_RT4_n;
bar(F, 0.5), hold on;
title('elas- Properties of RT4 and RT4n');
errorbar(F, Devi,'r','LineWidth',2);
hold off


%% T24
 cd 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_elas_T24'
 pa2 = 'C:\Users\amnl\Desktop\Xian\matlab_code\analyze_data_indent\matlab_elas_T24\';
E_T24 = zeros(29,3);
Num_T24 = 29;


for i = 1:Num_T24
    st = ['elasticity_' num2str(i) '_**'];
    x = dir(st);
    for j = 1:3
        pfn = [pa2 x(j).name];
        load(pfn);
        E_T24(i,j) = elasticity.E;
    end
end

 E_mean_T24_30 = mean(E_T24(:,1))
 E_mean_T24_45 = mean(E_T24(:,2))
 E_mean_T24_60 = mean(E_T24(:,3))



% E_mean_T24 = mean(E_elas(1:Num_T24));
% E_devi_T24 = std(E_elas(:))/sqrt(Num_T24);

%% make the figure

E_mean(1,1) =  E_mean_RT4_30;
E_mean(2,1) =  E_mean_RT4_45;
E_mean(3,1) =  E_mean_RT4_60;
devi(1,1) = std(E_RT4(:,1))/sqrt(Num_RT4);
devi(2,1) = std(E_RT4(:,2))/sqrt(Num_RT4);
devi(3,1) = std(E_RT4(:,3))/sqrt(Num_RT4);

E_mean(1,2) =  E_mean_T24_30;
E_mean(2,2) =  E_mean_T24_45;
E_mean(3,2) =  E_mean_T24_60;
devi(1,2) = std(E_T24(:,1))/sqrt(Num_T24);
devi(2,2) = std(E_T24(:,2))/sqrt(Num_T24);
devi(3,2) = std(E_T24(:,3))/sqrt(Num_T24);
% 
% figure(11)
% bar(E_mean, 0.5), hold on;
% title('verification of viscoelasticity');
% errorbar(E_mean, devi,'r','LineWidth',2);
% hold off
% 
% figure(11)
% ylabel('Youngs Modulus(KPa)');
% xlabel('Indentation Speed(um/s)');
%%
E_mean_RT4 = mean(E_mean(:,1));
E_RT4_devi(1:Num_RT4) = E_RT4(:,1);
E_RT4_devi(Num_RT4+1:2*Num_RT4) = E_RT4(:,2);
E_RT4_devi(2*Num_RT4+1:3*Num_RT4) = E_RT4(:,3);
E_devi_RT4 = std(E_RT4_devi)/sqrt(3*Num_RT4);

E_mean_T24 = mean(E_mean(:,2));
E_T24_devi(1:Num_T24) = E_T24(:,1);
E_T24_devi(Num_T24+1:2*Num_T24) = E_T24(:,2);
E_T24_devi(2*Num_T24+1:3*Num_T24) = E_T24(:,3);
E_devi_T24 = std(E_T24_devi)/sqrt(3*Num_T24);

figure(12)
F(1) = E_mean_RT4;
F(2) = E_mean_T24;
Devi(1) = E_devi_RT4;
Devi(2) = E_devi_T24;
bar(F, 0.5), hold on;
title('elas- Properties of RT4 and T24');
errorbar(F, Devi,'r','LineWidth',2);
hold off


figure(12)
ylabel('Youngs Modulus(KPa)');
xlabel('Cell Types');