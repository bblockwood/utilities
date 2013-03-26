function taxdue = tax(y,g)

% For a vector of incomes y, calculate the associated vector of taxes
% resulting from a bracketed income tax; g is the demogrant. 

t = [0.1 0.2 0.3 0.4 0.5];  % vector of marginal tax rates
b = [0 5 10 20 30 Inf];     % vector of tax bracket thresholds (inclusive)

I = length(y);
M = length(t);

bMat = repmat(b,I,1);
yMat = repmat(y,1,M+1);

% Calculate income exposure in each tax bracket
eMat = max(min(bMat(:,2:end),yMat(:,2:end)) - bMat(:,1:end-1),zeros(I,M));

% Calculate tax due
taxdue = eMat*t' - g;