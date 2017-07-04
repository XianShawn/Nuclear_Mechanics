% fitting the curve for level the data
% linear fitting (used to calculate recorded Young's modulus)

function [ft,gofR2,figure_handle]= createFit_line_poly_N(x, y,N,show_figure_number);
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( ['poly' num2str(N)  ]);
opts = fitoptions( ft );
opts.Lower = [-Inf -Inf -Inf];
opts.Upper = [Inf Inf Inf];

opts.Robust = 'Bisquare';%'off';%
% Fit model to data.
[ft,gof]= fit( xData, yData, ft, opts );

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