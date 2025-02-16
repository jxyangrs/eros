function saterr_set_nonlinear
% setting receiver nonlinearity
%
% Input:
%       Rad.nonlinear.onoff,       turn on/off nonlinearity,               0/1
%       T_nl,                      peak nonlinearity of each channel (K),  [1,channel]
% 
% Output:
%       Rad.nonlinear.onoff,       turn on/off nonlinearity,               0/1
%       Rad.nonlinear.T_nl,        peak nonlinearity of each channel(K),   [1,channel]
%
% Description:
%       The receiver nonlinearity is written as
%               Tas  = Tc + X(Tw-Tc) + 4*T_nl*X*(1-X),          (1)
%       where Tas is the scene antenna temperature w/ nonlinearity (K), Tc is cold-space TB (K), Tw is warm-load TB (K), T_nl is the peak nonlinearity (K)
%       and X=(Cs-Cc)/(Cw-Cc) with Cs,Cc,Cw for scene count, cold count, and warm count respectively.
%       The first term, Tc + X(Tw-Tc), is the linear part, and 4*T_nl*X*(1-X) is the nonlinear part.
%       The maximum nonlinearity appears with X=0.5
%       Equation 1 is rewritten as
%               4*T_nl*X^2 - (Tw-Tc+4*T_nl)*X + Tas-Tc = 0         
%               a*X^2+b*X+c = 0,                                 (2)
%       where a=4*T_nl, b=-(Tw-Tc+4*T_nl), c=Tas-Tc
%               X = 1/(2*a)*(-b-sqrt(b^2-4*a*c))
%       This is one of the two solutions, but a second solution is not physical
%               Cs = X*(Cw-Cc) + Cc,                             (3)
%       Tas often have more cross-track scans, and Tc,Tw,Cc,Cw have less scans and are averaged along cross-track and applied to Tas
% 
% written by John Xun Yang, University of Maryland, jxyang@umd.edu, or johnxun@umich.edu, 01/31/2019: original code

global Rad

% -----------------------------
% setting
% -----------------------------
Rad.nonlinear.onoff = 0; % 0=off,1=on

if Rad.nonlinear.onoff ==1
    
    % -----------------------------
    % setting
    % channel-dependent peak nonlinearity (K), [1,channel]
    % -----------------------------
    T_nl = 5*ones(1,Rad.num_chan); 
    
    % -----------------------------
    % parse
    % -----------------------------
    saterr_parse_nonlinear
    
end
