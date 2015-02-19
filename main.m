clear
clf
clc

% AUTHOOR INFORMACTIONS
%        Date : 10-Feb-2015 14:40:39
%      Author : Wei-Chieh Chang
%   Education : M.Sc. of Aerospace Engineering, Tamkang University
%     Version : 2.0
%     Copyright 2015 by Avionics And Flight Simulation Laboratory

quadparameters( 0 );
time2climb = quadceiling( 1000, 10000 )

FM = 0.7;
Nu = 3e-2;

[ OPTRC, PORRC, EXCRC, MAXRC ] = verticalflight( FM, Nu );
[ OPTFW, PORFW, EXCFW, MAXFW ] = forwardflight( FM, Nu );

endurance = quadendurance( PORFW) 
range = quadrange( OPTFW, endurance )



