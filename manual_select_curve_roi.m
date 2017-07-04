% manually select roi to help level the curve

function [sx,sy,index]=manual_select_curve_roi(x,y,str);

global re_select_roi_N0_L1_C2

% x = z_piezo_NM_c{select_extend1_withdraw2};
% y = prc_readout_c{select_extend1_withdraw2};
% str = 'select flat roi';

h=figure(500);
clf
plot(x,y,'k.-')
grid on
title(str)
% [a,b]=ginput(2);
%  a=round(a);



if re_select_roi_N0_L1_C2==-1
    P=auto_select_indent_ROI(y-y(1));
    a=[x(1) x(P(1))];
    a(2)=a(1)+0.8*(a(2)-a(1));
else
    dfn='data_manual_select_roi_leveling.mat';
    cy=mean(y);
    [a,b]=ginput_judge_mat_save(dfn,cy);
end

ind=x>a(1)&x<a(2);
sx=x(ind);
sy=y(ind);
inds=find(ind==1);
index=[inds(1) inds(end)];
close(h)
end