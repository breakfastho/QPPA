clc
clear all
clf

GeoHeight = linspace( 0, 12000, 6 );
Vf = linspace( 0.5, 25, 30 );

m = length( GeoHeight );
n = length( Vf );

Atomdata = stdatm( GeoHeight );  
AirDensity = Atomdata( :, 6 )';
Gravity = Atomdata( :, 2 )';

FM = 0.75;

TotalMass = 1.8;
Weight = Gravity .* TotalMass;
Power = 250;

% The properties for propeller.
RotorNumber = 4;
RotorRadious = 0.1547;
RoterArea = pi * RotorRadious^2;

Sref1 = 46e-3;
Sref2 = 60e-3;
CD1 = 0.98;
CD2 = 0.48;

BatNumber = 2;
BatCapity = 5.2;
BatVoltag = 3.1 * 4;

Vfmax = zeros( 1, m );

for i = 1: m
    
    
    % The induced velocity in hoveing, deriving from momemtum method.
    V1h( 1, i ) = sqrt( Weight( 1, i ) ./ ( 2 * AirDensity( 1, i ) * RotorNumber * RoterArea ) );
    
    % Determinate the drag by standard drag equation.
    Drag = 0.5 * AirDensity( 1, i ) .* Vf.^2 .* CD1 * Sref1;
    % Pitch angle estiamtion
    theta = asin( ( -( Weight( 1, m ) ./ Drag ) ...
        + sqrt( ( Weight( 1, i ) ./ Drag ).^2 + 4 ) ) ./ 2 );
    
    V1f = sqrt( - ( Vf.^2 / 2 ) + sqrt( ( Vf.^2 / 2 ).^2 + V1h( 1, i )^4 ) );
    
    DragParasi = 0.5 * AirDensity( 1, i ) .* ( Vf.^2 ) .* CD1 * Sref1 .* sin( theta )...
                + 0.5 * AirDensity( 1, i ) .* ( Vf.^2 ) .* CD1 * Sref1 .* cos( theta );
    DragParasi2 = 0.5 * AirDensity( 1, i ) .* ( 2.*V1f + Vf .* sin( theta ) ).^2  * CD2 * Sref2;
    ThrustReqX = DragParasi + DragParasi2 .* sin( theta );
    ThrustReqY = Weight( 1, m ) + DragParasi2 .* cos( theta );
    ThrustReqF = sqrt( ThrustReqX.^2 + ThrustReqY.^2 );

    PowerAva = Power .* ones( size( Vf ) );
    PowerPro = ( ThrustReqF .* ( V1f + Vf .* sin( theta ) ) ./ FM );
    PowerPra = 0.5 * AirDensity( 1, m ) * Sref1 * CD1 .* cos( theta ) .*  Vf.^3  ;
    PowerTot = PowerPro + PowerPra;
    PowerExc = PowerAva - PowerTot;
    
% %     plot( Vf, theta );
% %     hold on

    
    if(PowerExc( 1, 1 )<=0)
        Vfmax( 1, i ) = 0;
    else
        [ a b ] = min( abs( PowerExc ) );
        Vfmax( 1, i ) = Vf(b);
    end
end

% % figure(1)
% % plot(Vf,ThrustReqF)
% % 
% % figure(2)
% % plot(Vf,ThrustReqX, Vf,ThrustReqY,'-r')

% 
% plot( vfmax, GeoHeight  );
% axis( [ 0 16 0 7500 ] )
% title( ' Maximum Speed in Forward Flight  ' );
% xlabel( ' Forwrad Speed (m/s) ' );
% ylabel( ' Height (m) ' );
% grid on
% hold on
% 
