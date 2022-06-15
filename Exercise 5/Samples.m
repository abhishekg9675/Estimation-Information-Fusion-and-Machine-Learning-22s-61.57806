%xPrior = [1,1,1,1]
%PPrior = [1 1 1 1; 2 2 2 2; 3 3 3 3; 4 4 4 4]

%samples=normrnd(transpose(xPrior), PPrior)

samples=mvnrnd([0 0], [1, 1; 1, 1], 2)