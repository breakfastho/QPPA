clear
clf
clc

% AUTHOOR INFORMACTIONS
%        Date : 10-Feb-2015 14:40:39
%      Author : Wei-Chieh Chang
%   Education : M.Sc. of Aerospace Engineering, Tamkang University
%     Version : 2.0


quadparameters( 0 );
% time2climb = quadceiling( 1000, 10000 )

FM = 0.78;
Nu = 5e-2;

[ OPTRC, PORRC, EXCRC, MAXRC ] = verticalflight( FM, Nu );
[ OPTFW, PORFW, EXCFW, MAXFW ] = forwardflight( FM, Nu, 2, 1, 0, 12 );
%endurance = quadendurance( PORFW ) 
%range = quadrange( OPTFW, endurance )
