function [measMatrix]= MeasurementMatrix(state,radarState)
% Task 4 - Complete this function
%measMatrix = [];
syms x1 y1 x2 y2;
xr = radarState(1);
yr = radarState(2);

h = [((x1-xr)^2 + (y1-yr)^2)^0.5 , atan2((y1-yr),(x1-xr))];

sym_measMatrix = jacobian(h,[x1,y1,x2,y2]);

measMatrix = double(subs(sym_measMatrix, [x1,y1,x2,y2], [state(1), state(2), 0, 0]));