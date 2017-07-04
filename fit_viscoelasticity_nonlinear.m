% calculate Young's modulus and nv (the viscosity component)
% input:  distance, force, para(both sample and tip)
% output: E_sample, Y(nv, n represents viscosity and v represents speed)

function [E_sample,EL,EH,N,cfL,gofR2]=fit_youngs_modulus_linear(distance, force,para,rangeL,rangeH);
R=para.R;
v_sample=para.v_sample;
v_tip=para.v_tip;
E_tip=para.E_tip;
L = para.L_sample;

L=length(force);
% ind=round([0.1 0.9].*L);
ind=round([rangeL rangeH].*L);
if ind(1)==0
    ind(1)=1;
end
ind=ind(1):ind(2);
distance=distance(ind);
force=force(ind);

% distance=distance-distance(1);
% cftool(distance, force)
%% linearized hertz model
force=force-min(force);
distance=distance-min(distance);
L_force=force;

% createFit_viscoelastic(distance, force)

global show_figure_on1_off0
if show_figure_on1_off0==1
    [cfL,gofR2,fh]=createFit_viscoelastic2D(distance, L_force,1,54);
%     [cfL,gofR2,fh]=createFit_viscoelastic(distance, L_force,1,54);
else
    [cfL,gofR2]=createFit_viscoelastic2D(distance, L_force,1);
end
K=cfL.a;
Y=cfL.c;
%% hertz model
% cf= createFit_HertzModel(distance, force);
% K=cf.K
% K=K./(mag)^1.5
Ex=K/4*3/sqrt(R)
E_sample=(1-v_sample^2)./(1./Ex-(1-v_tip^2)./E_tip);
% viscoelastic model
N = Y*L/(3.14*R*para.u);
%%
Kc=confint(cfL).^(3/2);;
Kc=Kc(:,1);
Ec=Kc./4.*3./sqrt(R);
E_conf=(1-v_sample^2)./(1./Ec-(1-v_tip^2)./E_tip);
EL=E_conf(1);
EH=E_conf(2);
% E_sample=(1-v_sample^2).*Ex;
% E_out(k)=abs(E_sample)

global show_figure_on1_off0
if show_figure_on1_off0==1
    title(['Young''s modulus (Gpa):' num2str(E_sample) ', R^2=' num2str(gofR2) ', N=' num2str(N)])
    grid on
    legend('experimental data','curve fit')
    % title(title_name,'Interpreter','non')
    xlabel( 'indent depth (nm)' );
    ylabel( 'force (nN)' );    
%     saveas(gcf,[para.pfn '_linear_fit_modulus.tiff'])
end
end