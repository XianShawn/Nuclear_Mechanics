function [y_out,x_out]= filterdata_1D(distance,force,size);
%Create a 1-by-100 row vector of sinusoidal input data corrupted by random noise. Initialize the random number generator to make the output of rand repeatable.
t = distance;
rng default
x = force;

%Define the numerator coefficients of the rational transfer function. Use a window size of 5.

windowSize = size;

b = (1/windowSize)*ones(1,windowSize);
a = 1;

y = filter(b,a,x);

plot(t,x)
hold on
plot(t,y)
hold off

grid on
legend('Input Data','Filtered Data','Location','NorthWest')
title('Plot of Input and Filtered Data')

x_out = x;
y_out = y;
end
