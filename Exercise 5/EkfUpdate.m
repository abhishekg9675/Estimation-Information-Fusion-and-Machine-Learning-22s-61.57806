function [xPosterior,PPosterior]= EkfUpdate(xPrior,PPrior,z,R,radarState)
% Task 5 - Complete this function

%xPosterior = [];
%PPosterior = [];

H = MeasurementMatrix(z,radarState);

S = H * PPrior * transpose(H) + R ;
W = PPrior * transpose(H) * inv(S);

xPosterior = xPrior + W*(z-H*xPrior);
PPosterior = PPrior - W*S*transpose(W);