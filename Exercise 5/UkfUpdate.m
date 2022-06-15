function [xPosterior,PPosterior]= UkfUpdate(xPrior,PPrior,z,R,radarState)
% Task 6 - Complete this function

na = length(xPrior);
sample_size = 2*length(xPrior) + 1;
K = 0;
xr = radarState(1);
yr = radarState(2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a_ = xPrior;

samples = [];
sample_weight = [];

mat_sqrt = real(sqrtm((na+K)*PPrior))';
hk = zeros(2,sample_size);

%for i = 0
samples = [samples, a_];
sample_weight = [sample_weight, K/(na+K)];
hk(:,1) = [((samples(1,1)-radarState(1))^2 + (samples(2,1)-radarState(2))^2)^0.5 ; atan2( samples(2,1)-radarState(2) , samples(1,1)-radarState(1) ) ];

for i = 1:na
    samples = [samples, a_ + mat_sqrt(:,i)];
    sample_weight = [sample_weight, 1/(2*(na+K))];
    hk(:,i+1) = [((samples(1,i+1)-radarState(1))^2 + (samples(2,i+1)-radarState(2))^2)^0.5 ; atan2( samples(2,i+1)-radarState(2) , samples(1,i+1)-radarState(1) ) ];
end
for i = (na+1):(2*na)
   samples = [samples, a_ - mat_sqrt(:,i-na)];
   sample_weight = [sample_weight, 1/(2*(na+K))];
   hk(:,i+1) = [((samples(1,i+1)-radarState(1))^2 + (samples(2,i+1)-radarState(2))^2)^0.5 ; atan2( samples(2,i+1)-radarState(2) , samples(1,i+1)-radarState(1) ) ];
end

sample_weight = sample_weight/sum(sample_weight);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
z_k = sum(sample_weight .* hk ,2);
Pxz = (sample_weight.*(samples - xPrior))*(hk-z_k)';
Pzz = (sample_weight.*(hk - z_k))*(hk - z_k)';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S = R + Pzz;
K = Pxz / S;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xPosterior = xPrior + K * (z-z_k);
PPosterior = PPrior - K * S * transpose(K);