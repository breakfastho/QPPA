AirDensity = 1.125;
Gravity = 9.81;

TotalMass = 1.5;
Weight = Gravity .* TotalMass;
Power = 180;

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


x = linspace( 0, 25, 10 ) ;
y = linspace( 0.01, 0.5, 10 ) ;

[ Vf, theta ] = meshgrid( x, y );

V1h = 4.9;
V1f = sqrt( - ( Vf.^2 / 2 ) + sqrt( ( Vf.^2 / 2 ).^2 + V1h^4 ) );
DragParasi = 0.5 * AirDensity .* ( Vf.^2 ) .* CD1 * Sref1 .* cos( theta );
DragParasi2 = 0.5 * AirDensity .* ( 2*V1f + Vf .* sin( theta ) ).^2  * CD2 * Sref2; 

ThrustReqX = DragParasi + DragParasi2 .* sin( theta );
ThrustReqY = Weight + DragParasi2 .* cos( theta );
ThrustReqF = Weight./cos(theta) + DragParasi2;

mesh( Vf, theta, ThrustReqF )