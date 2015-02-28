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


global AirDensity Power Gravity TotalMass Weight 
global RoterArea RotorNumber RotorRadious Sref1 Sref2 CD1 CD2

% The induced velocity in hovering.
V1h = sqrt( Weight / ( 2 * AirDensity * RotorNumber * RoterArea ) );

% Declare the climb velocity form Vc0 to Vc1, using linspce to divid into
% 1000 steps. And the V1c, induced velocity in vertical climb, is derived 
% form momentum method. You may check the paper formar from my thesis.
if nargin == 2
    ModeThrustC = 1;
    Vc0 = 0;
    Vc1 = 15;
elseif nargin == 3
    Vc0 = 0
    Vc1 = 15;
end  

% Declare the vertical climb rate from Vc0 to Vc1 into 500 steps.
Vc = linspace( Vc0, Vc1, 500 );
V1c = ( -0.5 .* Vc ) + sqrt( ( 0.5 .* Vc ).^2 + V1h^2 );

% Declare the thrust required from the forces act on the quadrotor. 
% The thrust have to elimiate drag, wake drag and weight. \
DragParasi = 0.5 * AirDensity * Sref1 * CD1 .* ( Vc.^2 );
DragParasi2 = 0.5 * AirDensity * Sref2 * CD2 .* ( ( 2 .* V1c ).^2 );

% Choise the compute algorithm for the thrust required.
if ModeThrustC == 1
    ThrustReqC = DragParasi + DragParasi2 + Weight;
elseif ModeThrustC == 2
    ThrustReqC = DragParasi + Weight * ( 1 + Nu );  
end

% Ther process to computing the power required for each term.
PowerAva = Power * ones( size( Vc ) );
PowerPro = ( ThrustReqC .* ( V1c + Vc ) ./ FM );
PowerPra = DragParasi .* Vc + DragParasi .* ( 2 * V1c );
PowerTot = PowerPro + PowerPra;
PowerExc = PowerAva - PowerTot;

% The thrust avaliable, you can derive it from the momentum method.
ThrustAva = PowerAva .* FM ./ ( Vc + V1c);

% Figure out the minimum value for power required in vertical flight. But,
% the answer must be zero. There have another algorithm to prove there will 
% have a powerreqired drop during the low climb rate.    
[ PowerAmp PowerLoc ] = min( PowerTot );
[ MaxrcAmp MaxrcLoc ] = min( abs( PowerTot - PowerAva ) );

% Base on the minimum power required to fine an optimal climb rate.
OPTRC = Vc( PowerLoc );
PORRC = PowerAmp;
MAXRC = Vc( MaxrcLoc );
EXCRC = max( PowerExc );

% Plot the figure
figure( 3 );
h = plot( Vc, PowerPra, '--g', Vc, PowerPro, '--b' , Vc, PowerTot, 'r', Vc, PowerAva, 'm');
title( ' Power Required in Vertical Flight' );
legend( 'Parasite', 'Propeller', 'Required', 'Avaliable')
set( h, 'linewidth', 1.9 );
xlabel( ' Vertical Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

figure( 4 )
h2 = plot( Vc, PowerExc );
title( ' Excess Power in Vertical Flight' );
legend( ' Excess ' );
set( h, 'linewidth', 1.9 );
xlabel( ' Vertical Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

figure( 5 );
h5 = plot( Vc, ThrustReqC, Vc, ThrustAva, Vc, DragParasi, '-.m',...
    Vc, Weight .* ones( size( Vc ) ), '-.g' );
title( ' Thrust Required and Avaliable ' );
xlabel( ' Vertical Speed (m/s) ' );
ylabel( ' Thrust Required (N) ' );
legend( ' Required ', ' Avaliable ', 'Parasite Drag', ' Weight ' );
grid on;

{[ ' Opt. R/C = ' num2str( OPTRC ) ' m/s ' ];
 [ 'Min. P.R = ' num2str( round( PORRC ) ) ' W   ' ];
 [ 'Max. R/C = ' num2str( round( MAXRC ) ) ' m/s ' ]}

