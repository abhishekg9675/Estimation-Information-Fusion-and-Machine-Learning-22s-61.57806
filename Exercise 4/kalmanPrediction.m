function [priorMean,priorCovariance] = kalmanPrediction(posteriorMean,posteriorCovar,F,Q)
    %TASK 3 - Complete this function 
    %priorMean = [];
    %priorCovariance = [];
    priorMean = F * posteriorMean;
    priorCovariance = F*posteriorCovar*transpose(F) + Q;
end

