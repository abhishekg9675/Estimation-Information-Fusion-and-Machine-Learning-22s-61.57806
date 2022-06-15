function [measMatrix]= MeasurementMatrix(state,radarState)

% Task 4 - Complete this function


xr = radarState(1);
yr = radarState(2);
x1 = state(1);
y1 = state(2);

jacob_matrix = [(x1 - xr)/((x1 - xr)^2 + (y1 - yr)^2)^(1/2) , (y1 - yr)/((x1 - xr)^2 + (y1 - yr)^2)^(1/2), 0, 0 ; (-(y1-yr)/((x1-xr)^2+(y1-yr)^2)), ((x1-xr)/((x1-xr)^2+(y1-yr)^2)), 0, 0];


measMatrix = jacob_matrix;