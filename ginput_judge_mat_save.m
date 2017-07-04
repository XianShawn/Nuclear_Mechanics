% 

function [a,b]=ginput_judge_mat_save(dfn,cy);
a=[];
b=[];
% dfn='.\data_manual_select_line_roi.mat';
global pfn
global re_select_roi_N0_L1_C2

% data_manual_select_roi_leveling.mat
% data_manual_select_roi_contact.mat
local_re_select_roi_N0_L1_C2=re_select_roi_N0_L1_C2;

if ~isempty(strfind(dfn,'leveling')) && local_re_select_roi_N0_L1_C2==2
    local_re_select_roi_N0_L1_C2==0;
end

name=[pfn '_' dfn];
sname=name;% to avoid path or name change
if exist(sname,'file')% && re_select_roi==0
    load(sname)
    hold on
    if nargin==2
        b=[cy,cy];
        plot(a,b,'*','MarkerSize',10)
    end
end
if exist(sname,'file')==0  || local_re_select_roi_N0_L1_C2>0
    set(gcf,'units','normalized')
%     set(gcf,'outerposition',[0 0 1 1]);
    [a,b]=ginput(2);
    a=round(a);
    b=round(b);
   % save(name,'a','b','name')
end
end