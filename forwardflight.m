function [ OPTFW, PORFW, EXCFW, MAXFW ] = forwardflight( FM, Nu, Methods, Vf0, Vf1 )
% FORWARDFLIGHT
%     forwardflight( FM, Nu, Vc0, Vc1 ) is a co-function with
%     QUADAnalyser. The main propose of this function is to fugure out the
%     minimum power, minimun power required R/C and maximun R/C in the
%     specified condition. In this functtion, you have to input the 


% AUTHOOR INFORMACTIONS
%     Date : 10-Feb-2015 17:21:33
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 3.0
%     Copyright 2015 by Avionics And Flight Simulation Laboratory


global AirDensity Power Gravity TotalMass Weight RotorNumber RotorRadious Sref1 Sref2 CD1 CD2


if nargin == 2
    Vf0 = 0;
    Vf1 = 20;
    Methods = 1;
elseif nargin == 3
    Vf0 = 1;
    Vf1 = 10;
end    
    

% 
RoterArea = pi * RotorRadious^2;

% The induced velocity in hoveing, deriving from momemtum method.
V1h = sqrt( Weight / ( 2 * AirDensity * RotorNumber * RoterArea ) );

% Declare a row data for forward speed. From Vf0 to Vf1, divid into 1000
% steps. 
Vf = linspace( Vf0, Vf1, 1000 );

% The function quadpitch( Vf ) is a function to figure out the pitch
% angle of the quadrotor. Notice that, just for steady flight. The
% definition for steady flight is mean thoese forces act on quadrotor is
% elimiated by each other which at same axis.
theta = quadpitch( Vf );

% Here have three methods to figure out the induced velocity at propeller,
% first method is based on my theory, but it still need be approved by my
% thesis advisor. The second is to calculate the induced veloctity on
% helicopter. The equation is exact solution. The third is an approximation
% solution.
if Methods == 1
    V1f = ( -0.5 .* Vf .* sin( theta ) ) + sqrt( ( 0.5 .* Vf .* sin( theta ) ).^2 + V1h^2 );   
elseif Methods == 2
    V1f = sqrt( - ( Vf.^2 / 4 ) + sqrt( ( Vf.^2 / 4 ).^2 + V1h^4 ) );
elseif Methods == 3
    V1f = ( V1h^2 ) ./ Vf;
end
% 

%
DragParasi = 0.5* AirDensity .* Vf.^2 .* CD1 * Sref1 .* cos( theta ) .* sin(theta)
ThrustReqF = DragParasi + ( 1 + Nu ) * Weight .* cos( theta ) ;
       

% Ther process to computing the power required for each term.
PowerAva = Power * FM .* ones( size( Vf ) );
PowerPro = ( ThrustReqF .* ( V1f + Vf .* sin( theta ) ) ./ FM ) ./ ( 1 - Nu );
PowerPra = 0.5 * AirDensity * Sref1 * CD1 .* cos( theta ) .*  Vf.^3  ;  
PowerTot = PowerPro + PowerPra;
PowerExc = PowerAva - PowerTot;
% 
[ PowerAmp PowerLoc ] = min( PowerTot );
[ MaxrcAmp MaxrcLoc ] = min( abs( PowerTot - PowerAva ) );

OPTFW = Vf( PowerLoc );
PORFW = PowerAmp;
MAXFW = Vf( MaxrcLoc );
EXCFW = max( PowerExc )

figure( 3 );
h3 = plot( Vf, PowerPra, '--g', Vf, PowerPro, '--b' , Vf, PowerTot, 'r', Vf, PowerAva, 'm');
title( ' Power Required in Forward Flight' );
legend( 'Parasite', 'Propeller', 'Required', 'Avaliable')
set( h3, 'linewidth', 1.5 );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

figure( 4 );
h4 = plot( Vf, PowerExc );
title( ' Excess Power in Forward Flight' );
legend( 'Excess' )
set( h4, 'linewidth', 1.5 );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

{[ 'Opt. FW = ' num2str( round( OPTFW ) ) ' m/s ' ];
 [ 'Min. P.R = ' num2str( round( PORFW ) ) ' W   ' ];
 [ 'Max. FW = ' num2str( round( MAXFW ) ) ' m/s ' ]}

