function [alpha, A, EvalPow] = fit_to_power_function(Freq, Pow, EvalFreq, method)
%
% Fits the power function y = A*x^alpha to the data in Freq and Pow. The
% regression is done in the linear domain after log-transforming the data.
%
% SYNTAX:
%   [alpha A EvalPow] = fit_to_power_function(Freq, Pow, EvalFreq)
% INPUT:
%   Freq        - n-by-1 frequency vector.
%   Pow         - Corresponding n-by-1 power vector.
%   EvalFreq    - (optional) Frequencies that will be evaluated with the 
%                 fitted function.
%   Method      - (optional, default='linear') Sets the curve fitting
%                 method ('linear', 'nonlinear1' or 'nonlinear2').
% OUTPUT:
%   alpha       - Fitted exponent.
%   A           - Fitted scale factor.
%   EvalPow     - Powers corresponding to EvalFreq.

if nargin < 4
    method = 'linear';
end

EvalPow = [];
Freq = Freq(:);
Pow = Pow(:);

switch method
    case 'linear'
        P = polyfit(log(Freq), log(Pow), 1);
        alpha = P(1);
        A = exp(P(2));
        if nargin>2 && ~isempty(EvalFreq)
            EvalPow = A*EvalFreq.^(alpha);
        end
    case {'nonlinear' 'nonlinear1'}
        fo = fit(Freq(:),Pow(:),'power1');
        coeff = coeffvalues(fo);
        A = coeff(1);
        alpha = coeff(2);
        if nargin>2 && ~isempty(EvalFreq)
            EvalPow = A(1)*EvalFreq.^(alpha);
        end
    case 'nonlinear2'
        fo = fit(Freq(:),Pow(:),'power2');
        coeff = coeffvalues(fo);
        A = coeff([1 3]);
        alpha = coeff(2);
        if nargin>2 && ~isempty(EvalFreq)
            EvalPow = A(1)*EvalFreq.^(alpha) + A(2);
        end
    otherwise
        error('Unrecognized curve fitting method.')
end