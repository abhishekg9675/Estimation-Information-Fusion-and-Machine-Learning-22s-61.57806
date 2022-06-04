function [outputArg] = likelihood(snrSamples,range)
    % Task 2
    outputArg = 0;
    meanSNR = measurementFunction(range)
    outputArg = 1/(meanSNR) * exp(-snrSamples/meanSNR) 
end