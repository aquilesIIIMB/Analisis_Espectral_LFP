function [pow_dBpink, fitStats, pow_pinknoise] = convert_to_dBpink(faxis, pow, pinkBand)
%
% Expresses a power spectrum in "pink" decibels, i.e. normalized to the
% pink noise background. The pink background is estimated by fitting the
% power function y = A*x^alpha to the data within the bands defined by
% pinkBand.
%
% SYNTAX:
%   [pow_dBpink, fitStats] = convert_to_dBpink(faxis, pow, pinkBand)
% INPUT:
%   faxis         - vector with frequencies corresponding to pow argument.
%   pow           - vector or 2-d matrix with power spectral densities. If
%                   a matrix, each colomn will be treated as a separate
%                   power spectrum. The number of rows has to be equal to
%                   numel(faxis).
%   pinkBand      - an n-by-2 matrix defining the n frequency bands to
%                   include in the fitting procedure. For example, 
%                   [2 7;15 90] will include all frequencies between 2 and
%                   90, except those between 7 and 15.
% OUTPUT:
%   pow_dBpink    - pow expressed in "pink" decibels.
%   fitStats      - structure with fields 'alpha' (fitted exponent) and 'A'
%                   (fitted scale factor).
%   pow_pinknoise - values of fitted function at faxis.


% Frequencies with pink-noise character:
bPink = false(size(faxis));
for iBand = 1:size(pinkBand,1)
    bPink = bPink | (faxis>=pinkBand(iBand,1)&faxis<=pinkBand(iBand,2));
end
% Fit power function:
pow_pinknoise = NaN(size(pow));
dummy = cell(size(pow,2));
fitStats = struct('alpha', dummy, 'A', dummy);
for iSpectra = 1:size(pow,2)
    [fitStats(iSpectra).alpha, fitStats(iSpectra).A, pow_pinknoise(:,iSpectra)] = ...
        fit_to_power_function(faxis(bPink), pow(bPink,iSpectra), faxis);
end
% Convert to dBpink:
pow_dBpink = 10*log10(pow./pow_pinknoise);
