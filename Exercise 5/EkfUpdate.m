function [xPosterior,PPosterior]= EkfUpdate(xPrior,PPrior,z,R,radarState)
% Task 5 - Complete this function

H = MeasurementMatrix(xPrior,radarState);

xr = radarState(1);
yr = radarState(2);
x1 = xPrior(1);
y1 = xPrior(2);
h = [((x1-xr)^2 + (y1-yr)^2)^0.5 ; atan2((y1-yr),(x1-xr))];

S = H * PPrior * transpose(H) + R ;
W = PPrior * transpose(H) / S;

xPosterior = xPrior + W*(z-h);
PPosterior = PPrior - W*S*transpose(W);

