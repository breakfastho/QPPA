function [ OPTRC, PORRC, EXCRC, MAXRC ] = verticalflight( FM, Nu, ModeThrustC ,Vc0, Vc1 )
% VERTICALFLIGHT
%     verticalflight( FM, Nu, ModeThrustC ,Vc0, Vc1 ) is a co-function with
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
    ModeThrustC = 1;
    Vc0 = 0;
    Vc1 = 12;
elseif nargin == 3
    Vc0 = 0
    Vc1 = 12;
end    
    
% 
RoterArea = pi * RotorRadious^2;
V1h = sqrt( Weight / ( 2 * AirDensity * RotorNumber * RoterArea ) );


% Declare the climb velocity form Vc0 to Vc1, using linspce to divid into
% 1000 steps. And the V1c, induced velocity in vertical climb, is derived 
% form momentum method. You may check the paper formar from my thesis.
Vc = linspace( Vc0, Vc1, 1000 );
V1c = ( -0.5 .* Vc ) + sqrt( ( 0.5 .* Vc ).^2 + V1h^2 );

% Declare the thrust required from the forces act on the quadrotor. 
% The thrust have to elimiate drag, wake drag and weight. \
DragParasi = 0.5 * AirDensity * Sref1 * CD1 .* ( Vc.^2 );
DragParasi2 = 0.5 * AirDensity * Sref2 * CD2 .* ( ( 2 .* V1c ).^2 );

if ModeThrustC == 1
    ThrustReqC = DragParasi + Weight * ( 1 + Nu );
elseif ModeThrustC == 2
    ThrustReqC = DragParasi + DragParasi2 + Weight;
end

% Ther process to computing the power required for each term.
PowerAva = Power * FM .* ones( size( Vc ) );
PowerPro = ( ThrustReqC .* ( V1c + Vc ) ./ FM );
PowerPra = DragParasi .* Vc;
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

figure( 3 );
h = plot( Vc, PowerPra, '--g', Vc, PowerPro, '--b' , Vc, PowerTot, 'r', Vc, PowerAva, 'm');
title( ' Power Required in Vertical Flight' );
legend( 'Parasite', 'Propeller', 'Required', 'Avaliable')
set( h, 'linewidth', 1.9 );
xlabel( ' Vertical Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

figure( 4 );
h2 = plot( Vc, PowerExc );
title( ' Excess Power in Vertical Flight' );
legend( ' Excess ' );
set( h, 'linewidth', 1.9 );
xlabel( ' Vertical Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

figure( 5 );
h5 = plot( Vc, ThrustReqC, Vc, ThrustAva );
title( ' Thrust Required and Avaliable ' );
xlabel( ' Vertical Speed (m/s) ' );
ylabel( ' Thrust Required (W) ' );
legend( ' Required ', ' Avaliable ' );
grid on;

{[ ' Opt. R/C = ' num2str( round( OPTRC ) ) ' m/s ' ];
 [ 'Min. P.R = ' num2str( round( PORRC ) ) ' W   ' ];
 [ 'Max. R/C = ' num2str( round( MAXRC ) ) ' m/s ' ]}

