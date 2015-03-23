function quadceiling = ( MaxGeoHeight, MaxRC )

GeoHeight = linspace( 0, MaxGeoHeight, 20);
Vc = linspace( 0, MaxRC, 20 );

m = length( GeoHeight );
n = length( Vc );

Atomdata = stdatm( GeoHeight );
AirDensity = Atomdata( :, 6 )';
Gravity = Atomdata( :, 2 )';

global Power TotalMass  
global RoterArea RotorNumber RotorRadious Sref1 Sref2 CD1 CD2

FM = 0.75;

TotalMass = 1.8;
Weight = Gravity .* TotalMass;

Vcmax = zeros( 1, m );

for i = 1: m
    
    
    % The induced velocity in hoveing, deriving from momemtum method.
    V1h( 1, i ) = sqrt( Weight( 1, i ) ./ ( 2 * AirDensity( 1, i ) * RotorNumber * RoterArea ) );
    
    
    
    % Declare the vertical climb rate from Vc0 to Vc1 into 500 steps.
    V1c = ( -0.5 .* Vc ) + sqrt( ( 0.5 .* Vc ).^2 + V1h( 1, i )^2 );
    
    % Declare the thrust required from the forces act on the quadrotor.
    % The thrust have to elimiate drag, wake drag and weight. \
    DragParasi = 0.5 .* AirDensity( 1, i ) * Sref1 * CD1 .* ( Vc.^2 );
    DragParasi2 = 0.5 .* AirDensity( 1, i ) * Sref2 * CD2 .* ( ( 2 .* V1c ).^2 );
    
    ThrustReqC = DragParasi + DragParasi2 + Weight( 1, i );
    
    
    % Ther process to computing the power required for each term.
    PowerAva = Power * ones( size( Vc ) );
    PowerPro = ( ThrustReqC .* ( V1c + Vc ) ./ FM );
    PowerPra = DragParasi .* Vc + DragParasi .* ( 2 * V1c );
    PowerTot = PowerPro + PowerPra;
    PowerExc = PowerAva - PowerTot;
    
        if(PowerExc( 1 )<=0)
        Vcmax( 1, i ) = 0;
    else
        [ a b ] = min( abs( PowerExc ) );
        Vcmax( 1, i ) = Vc(b);
    end
    
end

plot( GeoHeight, Vcmax )

%
% plot( vfmax, GeoHeight  );
% axis( [ 0 16 0 7500 ] )
% title( ' Maximum Speed in Forward Flight  ' );
% xlabel( ' Forwrad Speed (m/s) ' );
% ylabel( ' Height (m) ' );
% grid on
% hold on
%
