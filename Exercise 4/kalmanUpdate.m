function [posteriorMean,posteriorCovariance,gainX] = kalmanUpdate(priorMean,priorCovariance,z,H,R)
    % TASK 3 - Complete this function
    %posteriorMean = [];
    %posteriorCovariance = [];
    %gainX = [];
    S = H*priorCovariance*transpose(H) + R;
    W = priorCovariance*transpose(H)*inv(S);
    v = z - H *priorMean;
    posteriorMean = priorMean + W*v;
    posteriorCovariance = priorCovariance- W*S*transpose(W);
    gainX = W(1,1);
end

