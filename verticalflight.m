function [ OPTRC, PORRC, EXCRC, MAXRC ] = verticalflight( FM, Nu, Vc0, Vc1 )
% VERTICALFLIGHT
%     verticalflight( FM, Nu, Vc0, Vc1 ) is a co-function with
%     QUADAnalyser. The main propose of this function is to fugure out the
%     minimum power, minimun power required R/C and maximun R/C in the
%     specified condition. In this functtion, you have to input the 


% AUTHOOR INFORMACTIONS
%     Date : 10-Feb-2015 14:40:39
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 1
%     Copyright 2015 by Avionics And Flight Simulation Laboratory


global AirDensity Power Gravity TotalMass Weight RotorNumber RotorRadious Sref1 Sref2 CD1 CD2

if nargin == 2
    Vc0 = 0;
    Vc1 = 10;
elseif nargin == 3
    Vc1 = 10;
end    
    

% 
RoterArea = pi * RotorRadious^2;
V1h = sqrt( Weight / ( 2 * AirDensity * RotorNumber * RoterArea ) );

%
Vc = linspace( Vc0, Vc1, 1000 );
V1c = ( -0.5 .* Vc ) + sqrt( ( 0.5 .* Vc ).^2 + V1h^2 );

%
ThrustReqC = 0.5 * AirDensity * Sref1 * CD1 .* ( Vc.^2 )...
           + Weight * ( 1 + Nu  );

% Ther process to computing the power required for each term.
PowerAva = Power * FM .* ones( size( Vc ) );
PowerPro = ( ThrustReqC .* ( V1c + Vc ) ./ FM );
PowerPra = 0.5 * AirDensity * Sref1 * CD1 .* ( Vc.^3 ) ./ FM;  
PowerTot = PowerPro + PowerPra;
PowerExc = PowerAva - PowerTot;

%
ThrustAva = PowerAva .* FM ./ ( Vc + V1c);

% 
[ PowerAmp PowerLoc ] = min( PowerTot );
[ MaxrcAmp MaxrcLoc ] = min( abs( PowerTot - PowerAva ) );

OPTRC = Vc( PowerLoc );
PORRC = PowerAmp;
MAXRC = Vc( MaxrcLoc );
EXCRC = max( PowerExc );

figure( 1 );
h = plot( Vc, PowerPra, '--g', Vc, PowerPro, '--b' , Vc, PowerTot, 'r', Vc, PowerAva, 'm');
title( ' Power Required in Vertical Flight' );
legend( 'Parasite', 'Propeller', 'Required', 'Avaliable')
set( h, 'linewidth', 1.9 );
xlabel( ' Vertical Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

figure( 2 );
h2 = plot( Vc, PowerExc );
title( ' Excess Power in Vertical Flight' );
legend( ' Excess ' );
set( h, 'linewidth', 1.9 );
xlabel( ' Vertical Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

figure( 5 );
h5 = plot( Vc, ThrustReqC, Vc, ThrustAva );
xlabel( ' Vertical Speed (m/s) ' );
ylabel( ' Thrust Required (W) ' );
legend( ' Required ', ' Avaliable ' );
grid on;

{[ ' Opt. R/C = ' num2str( round( OPTRC ) ) ' m/s ' ];
 [ 'Min. P.R = ' num2str( round( PORRC ) ) ' W   ' ];
 [ 'Max. R/C = ' num2str( round( MAXRC ) ) ' m/s ' ]}

