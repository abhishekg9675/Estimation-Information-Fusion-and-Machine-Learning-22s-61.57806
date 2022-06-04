close all

input = load('data.mat');
data = input.data;
% TIP: Use figure handles and fmin, example:
%funcHandle = @(x)-sin(x);
%max = fminbnd(funcHandle,0,pi);
% Maximum comes out at pi/2 as expected
%% 

% Plot the likelihood as a function of range
% Task 3
range = 1:1:10;

output_snr = [];
for r = 1:1:10;
    output_snr = [ output_snr, likelihood(data, r)];
end
surf(output_snr);
xlabel('Range (1-10m)'), ylabel('No. of Measurements'), zlabel('Likelihood');
%% 

figure;
ll = zeros(10,1);
for r=1:1:10
    out = likelihood(data, r);
    ll(r) = prod(out, 'all');
end

plot(1:10, ll);
ylabel('Likelihood');
xlabel('Range');

%% 

% Find maximum likelihood estimate
% Task 4

fhandle = @(r) -prod(likelihood(data, r), 'all');
mleEstimate = fminbnd(fhandle, 1, 10)
%% 
% Plot the posterior as a function of range
%figure
% Task 5
prior_mean = 5
prior_std = 1
N = numel(data)

likelihood_mean = mean(ll)
likelihood_std = std(ll)

posterior_mean = prior_mean + ()*(std(data))^-1 * (z - likelihood_mean)
posterior_std = ((priorStd^2)/(priorStd^2 + likelihood_std^2 /N)) + ((likelihood_std^2 /N)/(priorStd^2 + likelihood_std^2 /N))*priorMean
%% 


% Find maximum as posteriori estimate
priorMean = 5;
priorStd = 1;
mean = measurementFunction(range)
%std = 
N = numel(snrSamples)

% Task 6
mapEstimate = 0
mapEstimate = ((priorStd^2)/(priorStd^2 + std^2 /n))*mean(Samples) + ((std^2 /n)/(priorStd^2 + std^2 /N))*priorMean
%% 

% Find least squares estimate
% Task 8
%snrPost = measurementFunction(mapEstimate);
%lse = (Samples-snrPost);
lsEstimate = mean(data)

%% 

% Find the MMSE estimate
% Task 9
priorMean = 5;
priorStd = 1;
mean = measurementFunction(5)
%std = 
N = numel(snrSamples)

mmseEstimate = 0
mmseEstimate = ((priorStd^2)/(priorStd^2 + std^2 /n))*mean(Samples) + ((std^2 /n)/(priorStd^2 + std^2 /N))*priorMean
