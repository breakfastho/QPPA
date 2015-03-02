clear all
clf
clc

% AUTHOOR INFORMACTIONS
%        Date : 10-Feb-2015 14:40:39
%      Author : Wei-Chieh Chang
%   Education : M.Sc. of Aerospace Engineering, Tamkang University
%     Version : 2.0


quadparameters( 0 );
time2climb = quadceiling( 3000, 10000 )

FM = 0.98;
Nu = 3e-2;

[ OPTRC, PORRC, EXCRC, MAXRC ] = verticalflight( FM, Nu );
[ OPTFW, PORFW, EXCFW, MAXFW ] = forwardflight( FM, Nu, 1, 1, 0, 14 );

% Compute the forward parameters for quadrotor.
endurance = quadendurance( PORFW );
range = quadrange( OPTFW, endurance );
