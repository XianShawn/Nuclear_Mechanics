function P=auto_select_indent_ROI(ny);
%% start point, last point not less than 0
q=find(ny>=0);
dq=diff(q);

ndq=find(dq~=1);
q(ndq(end));
Pstart=q(ndq(end)+1);


%% end point, stop increase
dny=diff(ny);
q=find(dny>0);
Pend=q(end);
P=[Pstart Pend];
end