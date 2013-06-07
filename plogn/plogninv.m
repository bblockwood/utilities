function X = plogninv(P, alpha, nu, tau)

% Inverts the function plogncdf.

X0 = 100*ones(size(P));
opts = optimset('display','off','Jacobian','on');

try
[X,~,~,f] = lsqnonlin(@(x) obj(x,P,alpha,nu,tau),X0,zeros(size(P)),[],opts);
catch
    error('error from lsqnonlin in plogninv')
end

if (f <= 0)
    error('plogninv:noMin', ['lsqnonlin did not find a minimum, flag ' num2str(f)]);
end

end


function [f,J] = obj(x,P,alpha,nu,tau)
    [cdf,pdf] = plogncdf(x(:),alpha(:),nu(:),tau(:));
    f = cdf - P(:);
    J = diag(pdf);
end
