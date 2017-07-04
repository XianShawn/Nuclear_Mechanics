% Using ROI to level the curve, eliminating the drift of sensor
% input: z_piezo_NM,prc_readout
% output: prc_readout_adjusated_c, the drift has already been eliminated

function [z_piezo_NM_c,prc_readout_adjusted_c,z_tip_NM_c]=level_indentation_data2(z_piezo_NM,prc_readout,z_tip_NM);
global select_extend1_withdraw2
if (select_extend1_withdraw2==2)
    select_extend1_withdraw2=1;
    z_piezo_NM=flipud(z_piezo_NM);
    prc_readout=flipud(prc_readout);
    z_tip_NM=flipud(z_tip_NM);
end
disp('select_extend1_withdraw2 = ')
disp(select_extend1_withdraw2 );
ind_peak=find(z_piezo_NM==max(z_piezo_NM));
ind_peak=ind_peak(1);
z_piezo_NM_c{1}=z_piezo_NM(1:ind_peak);
z_piezo_NM_c{2}=z_piezo_NM(ind_peak:end);
prc_readout_c{1}=prc_readout(1:ind_peak);
prc_readout_c{2}=prc_readout(ind_peak:end);
z_tip_NM_c{1}=z_tip_NM(1:ind_peak);
z_tip_NM_c{2}=z_tip_NM(ind_peak:end);


%% select flat roi for adjusting leveling
[sx,sy,ind]=manual_select_curve_roi(z_piezo_NM_c{select_extend1_withdraw2},...
    prc_readout_c{select_extend1_withdraw2},'select flat roi');


%% adjust leveling
cfL=createFit_line_poly_N(sx,sy,1);
clear sx sy
prc_readout_drift=feval(cfL,z_piezo_NM);
prc_readout_adjusted=prc_readout-prc_readout_drift;

prc_readout_adjusted_c{1}=prc_readout_adjusted(1:ind_peak);
prc_readout_adjusted_c{2}=prc_readout_adjusted(ind_peak:end);


end