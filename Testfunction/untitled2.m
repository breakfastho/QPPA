clc
clear all
clf

GeoHeight = linspace( 0, 9000, 6 );
Vf = linspace( 0, 20, 100 );

m = length( GeoHeight );
n = length( Vf );

Atomdata = stdatm( GeoHeight );  
AirDensity = Atomdata( :, 6 )';
Gravity = Atomdata( :, 2 )';

FM = 0.75;

TotalMass = 1.5;
Weight = Gravity .* TotalMass;
Power = 180;

% The properties for propeller.
RotorNumber = 4;
RotorRadious = 0.1547;
RoterArea = pi * RotorRadious^2;

Sref1 = 46e-3;
Sref2 = Sref1 - 60e-4;
CD1 = 0.98;
CD2 = 0.48;

BatNumber = 2;
BatCapity = 5.2;
BatVoltag = 3.1 * 4;

vfmax = zeros( 1, m );

for i = 1: m
    
    
    % The induced velocity in hoveing, deriving from momemtum method.
    V1h = sqrt( Weight( 1, i ) ./ ( 2 * AirDensity( 1, i ) * RotorNumber * RoterArea ) );
    
    % Determinate the drag by standard drag equation.
    Drag = 0.5 * AirDensity( 1, i ) .* Vf.^2 .* CD1 * Sref1;
    % Pitch angle estiamtion
    theta = asin( ( -( Weight( 1, m ) ./ Drag ) ...
        + sqrt( ( Weight( 1, i ) ./ Drag ).^2 + 4 ) ) ./ 2 );
    
    V1f = sqrt( - ( Vf.^2 / 2 ) + sqrt( ( Vf.^2 / 2 ).^2 + V1h^4 ) );
    
    DragParasi = 0.5 * AirDensity( 1, i ) .* ( Vf.^2 ) .* CD1 * Sref1 .* sin( theta );
    DragParasi2 = 0.5 * AirDensity( 1, i ) .* ( 2*V1f + Vf .* sin( theta ) ).^2  * CD2 * Sref2;
    ThrustReqX = DragParasi + DragParasi2 .* sin( theta );
    ThrustReqY = Weight( 1, m ) + DragParasi2 .* cos( theta );
    ThrustReqF = sqrt( ThrustReqX.^2 + ThrustReqY.^2 );

    PowerAva = Power .* ones( size( Vf ) );
    PowerPro = ( ThrustReqF .* ( V1f + Vf .* sin( theta ) ) ./ FM );
    PowerPra = 0.5 * AirDensity( 1, m ) * Sref1 * CD1 .* cos( theta ) .*  Vf.^3  ;
    PowerTot = PowerPro + PowerPra;
    PowerExc = PowerAva - PowerTot;
    
    [ Amp Loc ] = min( abs( PowerExc ) );
    
    vfmax( 1, i ) = Vf( Loc );
    
    plot( Vf, PowerExc, '--r' );
    
    grid on
    hold on
    
end
