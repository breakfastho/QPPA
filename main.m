clear all
clc

% AUTHOOR INFORMACTIONS
%        Date : 23-Mar-2015 23:56:33
%      Author : Wei-Chieh Chang
%   Education : M.Sc. of Aerospace Engineering, Tamkang University
%     Version : 2.0

global CounterGeh DividorGeh;
CounterGeh = 1;
DividorGeh = 3;
k1 = quadparameters( linspace( 0, 5000, DividorGeh ) );
%k2 = verticalflight( 0, 10 );
[ PORFW OPRFW POPRFW ] = forwardflight( 3, 23 );  

% Compute the forward parameters for quadrotor.
%endurance = quadendurance( PORFW );
%range = quadrange( OPRFW, POPRFW );
