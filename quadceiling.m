function T2C = quadceiling( DesirdHeight, GeoHeight )
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


global AirDensity Power Gravity TotalMass Weight 
global RoterArea RotorNumber RotorRadious Sref1 Sref2 CD1 CD2

% if nargin == 0
%     DesirdHeight = 1000;
%     GeoHeight = 5000;
% elseif nargin == 1
%     GeoHeight = 5000;
% end   


Atomdata = stdatm( GeoHeight );
AirDensity = Atomdata( :, 6 )';
Gravity = Atomdata( :, 2 )';
TotalMass = 1.5;
Weight = Gravity * TotalMass;
Power = 180;
RotorNumber = 4;
RotorRadious = 0.1547;
RoterArea = pi * RotorRadious^2;
Sref1 = 46e-3;
Sref2 = 60e-4;
CD1 = 0.98;
CD2 = 0.48;

FM = 0.7;
Nu = 3e-2;




%

V1h = sqrt( Weight ./ ( 2 .* AirDensity * RotorNumber * RoterArea ) );

Vc0 = 0;
Vc1 = 20;
Vc = linspace( Vc0, Vc1, 500 );

m = length( AirDensity );
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
    
    %     figure(1)
    %     plot( Vc, V1c( i, : ) );
    %     grid on
    %     hold on
    %
    %     figure(2)
    %     plot( Vc, ThrustExc( i, : ) );
    %     grid on
    %     hold on
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

% T2C = 0;
% j = 2;
% WidthHeight = GeoHeight( 1, j ) - GeoHeight( 1, j - 1 )
% 
% while( GeoHeight( 1, j  )  DesirdHeight )
%     Increase = 0.5 * ( 1 / ceil( 1, j ) + 1 / ceil( 1, j - 1  ) ) * WidthHeight
%     T2C = Increase + T2C;
%     j = j + 1;
% end
%  
% T2C 
