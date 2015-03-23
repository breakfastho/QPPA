clear
clf
clc

% AUTHOOR INFORMACTIONS
%        Date : 23-Mar-2015 23:56:33
%      Author : Wei-Chieh Chang
%   Education : M.Sc. of Aerospace Engineering, Tamkang University
%     Version : 2.0

global CounterGeh;
CounterGeh = 10;

ksh = quadparameters( linspace( 0, 7000, 15 ) );

hffh = verticalflight( 0, 10 );
hggh = forwardflight( 0.25, 18 );  
% % 
% % 
% % 
% % % % Compute the forward parameters for quadrotor.
% % endurance = quadendurance( PORFW );
% % range = quadrange( OPRFW, POPRFW );
