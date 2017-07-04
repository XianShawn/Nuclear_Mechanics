% non-linear curve fitting to calculate Viscoelasticity

function [ft,gofR2,figure_handle] = createFit_viscoelastic(x, y, N,show_figure_number);
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'a*x^1.5+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( ft );
opts.Algorithm = 'Levenberg-Marquardt';
opts.Display = 'Off';
opts.Lower = [-Inf -Inf];
opts.Robust = 'Bisquare';
opts.StartPoint = [0.27692298496089 0.0461713906311539];
opts.Upper = [Inf Inf];

% Fit model to data.
[ft, gof] = fit( xData, yData, ft, opts );
gofR2=gof.rsquare;


figure_handle=0;
if nargin>=4
% Plot fit with data.
figure_handle=figure(show_figure_number);
plot( ft, xData, yData,'.-' );
% legend( h, 'y vs. x')
% Label axes
xlabel( 'x' );
ylabel( 'y' );
grid on
end

