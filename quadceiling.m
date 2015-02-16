function T2C = quadceiling( DesirdHeight, HeightRange )
% QUADCEILING
%     quadceiling( GeoHeight ) is a function to figure out the maximun
%     climb rate at different geometry height. The concept of this function
%     is base on the thrust avaliable and required. The curve of required
%     will changed as the height. The main resson is caused by the change
%     of air density and humidity.

% AUTHOOR INFORMACTIONS
%     Date : 14-Feb-2015 00:04:31
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 3
%     Copyright 2015 by Avionics And Flight Simulation Laboratory


global Power TotalMass
global RoterArea RotorNumber RotorRadious Sref1 Sref2 CD1 CD2

if nargin == 0
    DesirdHeight = 1000;
    HeightRange = 5000;
elseif nargin == 1
    HeightRange = 5000;
end

Atomdata = stdatm( linspace( 0, HeightRange, 100 ) );
GeoHeight = Atomdata( :, 1 )';
AirDensity = Atomdata( :, 6 )';
Gravity = Atomdata( :, 2 )';
Weight = TotalMass .* Gravity;
RoterArea = pi * ( RotorRadious )^2;

FM = 0.7;
Nu = 3e-2;




%

V1h = sqrt( Weight ./ ( 2 .* AirDensity * RotorNumber * RoterArea ) );

Vc0 = 0;
Vc1 = 20;
Vc = linspace( Vc0, Vc1, 500 );

m = length( GeoHeight );
n = length( Vc );
%

for i = 1: 1: m
    
    
    V1c( i, : ) = ( -0.5 .* Vc ) + sqrt( ( 0.5 .* Vc ).^2 + V1h( 1, i )^2 );
    
    
    
    %
    ThrustReqC( i, : ) = 0.5 * AirDensity( 1, i ) * Sref1 * CD1 .* ( Vc.^2 )...
        + Weight( 1, i ) .* ( 1 + Nu  );
    
    % Ther process to computing the power required for each term.
    PowerAva( i, : ) = Power * FM .* ones( size( Vc ) );
    PowerPro( i, : ) = ( ThrustReqC( i, : ) .* ( V1c( i, : ) + Vc ) ./ FM );
    PowerPra( i, : ) = 0.5 * AirDensity( 1, i ) * Sref1 * CD1 .* ( Vc.^3 ) ./ FM;
    PowerTot( i, : ) = PowerPro( i, : ) + PowerPra( i, : );
    PowerExc( i, : ) = PowerAva( i, : ) - PowerTot( i, : );
    
    
    ThrustAva( i, : ) = PowerAva( i, : ) .* FM ./ ( Vc + V1c( i, : ) );
    ThrustExc( i, : ) = ThrustAva( i, : ) - ThrustReqC( i, : );
    
    [ Amp Loc ] = min( abs( ThrustExc( i, : ) ) );
    ceil( 1, i ) =  Vc( Loc );
    
end

figure( 1 );
plot( GeoHeight,  ceil );
grid on ;
xlabel( ' Height ' );
ylabel( ' Max. R/C ' );

figure( 2 );
plot( GeoHeight, 1./ceil );
grid on
xlabel( ' Height ' );
ylabel( ' Time to climb ' );

T2C = 0;
WidthHeight = GeoHeight( 1, 2 ) - GeoHeight( 1, 1 );

for j = 2: 1: round( DesirdHeight / WidthHeight )
    Increase = 0.5 * ( 1 / ceil( 1, j ) + 1 / ceil( 1, j - 1  ) ) * WidthHeight;
    T2C = Increase + T2C;
    j = j + 1;
end