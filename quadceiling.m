function T2C = quadceiling( DesirdHeight, HeightRange )
% QUADCEILING
%     quadceiling( GeoHeight ) is a function to figure out the maximun
%     climb rate at different geometry height. The concept of this function
%     is base on the thrust avaliable and required. The curve of required
%     will changed as the height. The main resson is caused by the change
%     of air density and humidity.

% AUTHOOR INFORMACTIONS
%     Date : 03-Mar-2015 01:52:13
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 4
%     Copyright 2015 by Avionics And Flight Simulation Laboratory


global Power TotalMass 
global RoterArea RotorNumber RotorRadious Sref1 Sref2 CD1 CD2

if nargin == 0
    DesirdHeight = 500;
    HeightRange = 3000;
elseif nargin == 1
    HeightRange = 3000;
end

% Call the function "stdatm"
Atomdata = stdatm( 0: 1500: HeightRange );
GeoHeight = Atomdata( :, 1 )';
Gravity = Atomdata( :, 2 )';
AirDensity = Atomdata( :, 6 )';

Weight = TotalMass .* Gravity;

FM = 0.75;
Nu = 3e-2;




%

V1h = sqrt( Weight ./ ( 2 .* AirDensity * RotorNumber * RoterArea ) );

Vc0 = 0;
Vc1 = 10;
Vc = linspace( Vc0, Vc1, 50 );

m = length( GeoHeight );
n = length( Vc );
%

% Declare a zero row vector to store ceiling.
ceiling = zeros( 1, m );

for i = 1: 1: m
    
    V1c( i, : ) = ( -0.5 .* Vc ) + sqrt( ( 0.5 .* Vc ).^2 + V1h( 1, i )^2 );    
    
    % Declare the thrust required from the forces act on the quadrotor.
    % The thrust have to elimiate drag, wake drag and weight. \
    DragParasi( i, : ) = 0.5 * AirDensity( 1, i ) * Sref1 * CD1 .* ( Vc.^2 );
    DragParasi2( i, : ) = 0.5 * AirDensity( 1, i ) * Sref2 * CD2 ...
                          .* ( ( 2 .* V1c( i, : ) ).^2 );
    % During the vertical climb, the thrust must to eliminate three forces
    % at vertical axis.
    ThrustReqC( i, : ) = DragParasi( i, : ) + DragParasi2( i, : ) ...
                         + Weight( 1, i );
    
    % Ther process to computing the power required for each term. There
    % incuding propeller and parasite.
    PowerAva( i, : ) = Power .* ones( size( Vc ) );
    PowerPro( i, : ) = ( ThrustReqC( i, : ) .* ( V1c( i, : ) + Vc ) ./ FM );
    PowerPra( i, : ) = DragParasi( i, : ) .* Vc ...
                       + DragParasi2 ( i, : ) .* V1c( i, : );
    PowerTot( i, : ) = PowerPro( i, : ) + PowerPra( i, : );
    PowerExc( i, : ) = PowerAva( i, : ) - PowerTot( i, : );
    
    
%     ThrustAva( i, : ) = PowerAva( i, : ) .* FM ./ ( Vc + V1c( i, : ) );
%     ThrustExc( i, : ) = ThrustAva( i, : ) - ThrustReqC( i, : );
    
    [ Amp Loc ] = min( abs( PowerExc( i, : ) ) );
    ceiling( 1, i ) =  Vc( Loc );
    
end

figure( 1 );
plot( GeoHeight, ceiling );
grid on ;
title( ' Maximum Climb Rate with Takeoff Power ' )
xlabel( ' Height (m) ' );
ylabel( ' R/C (m/s) ' );

figure( 2 );
plot( GeoHeight, 1./ceiling );
grid on
title( ' Time to Climb with Takeoff Power ' )
xlabel( ' Height (m) ' );
ylabel( ' Time to climb (s/m) ' );


T2C = 0;
WidthHeight = GeoHeight( 1, 2 ) - GeoHeight( 1, 1 );

for j = 2: 1: round( DesirdHeight / WidthHeight )
    Increase = 0.5 * ( 1 / ceiling( 1, j ) + 1 / ceiling( 1, j - 1  ) ) * WidthHeight;
    T2C = Increase + T2C;
    j = j + 1;
end