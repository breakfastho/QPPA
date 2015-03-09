function [ OPTFW, PORFW, EXCFW, MAXFW ] = forwardflight( FM, Nu, Methods, ProMethod, Vf0, Vf1 )
% FORWARDFLIGHT
%     forwardflight( FM, Nu, Vc0, Vc1 ) is a co-function with
%     QUADAnalyser. The main propose of this function is to fugure out the
%     minimum power, minimun power required R/C and maximun R/C in the
%     specified condition. In this functtion, you have to input the 


% AUTHOOR INFORMACTIONS
%     Date : 24-Feb-2015 16:34:45
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 4.0
%     Copyright 2015 by Avionics And Flight Simulation Laboratory


global AirDensity Power Gravity TotalMass Weight 
global RoterArea RotorNumber RotorRadious Sref1 Sref2 CD1 CD2

if nargin == 2
    Vf0 = 0;
    Vf1 = 20;
    Methods = 1;
    ProMethod = 1;
elseif nargin == 3
    Vf0 = 0;
    Vf1 = 10;
    ProMethod = 1;
elseif nargin == 4
    Vf0 = 0;
    Vf1 = 20;
end    
    

% 
RoterArea = pi * RotorRadious^2;

% The induced velocity in hoveing, deriving from momemtum method.
V1h = sqrt( Weight / ( 2 * AirDensity * RotorNumber * RoterArea ) );

% Declare a row data for forward speed. From Vf0 to Vf1, divid into 1000
% steps. 
Vf = linspace( Vf0, Vf1, 500 );

% The function quadpitch( Vf ) is a function to figure out the pitch
% angle of the quadrotor. Notice that, just for steady flight. The
% definition for steady flight is mean thoese forces act on quadrotor is
% elimiated by each other which at same axis.
theta = quadpitch( Vf );

% Here have three methods to figure out the induced velocity at propeller,
% first method is based on my theory, but it still need be approved by my
% thesis advisor. The second is to calculate the induced veloctity on
% helicopter. The equation is exact solution. The third is an approximation
% solution.
if Methods == 1
    V1f = sqrt( - ( Vf.^2 / 2 ) + sqrt( ( Vf.^2 / 2 ).^2 + V1h^4 ) );
elseif Methods == 2
    V1f = ( -0.5 .* Vf .* sin( theta ) ) + sqrt( ( 0.5 .* Vf .* sin( theta ) ).^2 + V1h^2 );
elseif Methods == 3
    V1f = ( V1h^2 ) ./ Vf;
end

% Calculate the nacessary thrust of the quadrotor which provided by
% propeller. The equation is derived from the force diagram. The Parasite
% drag is base on standard drag equation.
DragParasi = 0.5 * AirDensity .* ( Vf.^2 ) .* CD1 * Sref1 .* sin( theta );
DragParasi2 = 0.5 * AirDensity .* ( 2*V1f + Vf .* sin( theta ) ).^2  * CD2 * Sref2; 
ThrustReqX = DragParasi + DragParasi2 .* sin( theta );
ThrustReqY = Weight + DragParasi2 .* cos( theta ); 
ThrustReqF = sqrt( ThrustReqX.^2 + ThrustReqY.^2 );
       
% Ther process to computing the power required for each term. The power
% avaliable is derived from the momentum method. With the forward speed 
% increase, the thrust avaliable will decrease. The propeller power is the 
% power which dispat at propeller, the parasite is the power to elimiate the 
% drag. Thus, the total power is the summation of propeller and parasite
% power. Notice that, the power avaliable will be a constant. 
PowerAva = Power * ones( size( Vf ) );

% Here are algorithms with different view.
if ProMethod == 1 
    PowerPro = ( ThrustReqF .* ( V1f + Vf .* sin( theta ) ) ./ FM );
elseif ProMethod == 2
    PowerPro = ( ThrustReqF .* ( V1f + Vf ) ./ FM );
elseif ProMethod == 3
    PowerPro = ( ThrustReqF .* V1f ./ FM );
end

% The process to figure out parasite power, propeller power
%PowerPra = 0.5 * AirDensity * Sref1 * CD1 .*  Vf.^3  ; 
PowerPra = 0.5 * AirDensity * Sref1 * CD1 .* cos( theta ) .*  Vf.^3  ;  
PowerTot = PowerPro + PowerPra;
PowerExc = PowerAva - PowerTot;
PowerOpr = Vf ./ PowerTot; 

% Seek the value and the address of minimum power required, where the 
% PowerAmp is the value and PowerLoc is the address. Using the address to 
% compare where the corresponding velocity is.  
[ PowerAmp PowerLoc ] = min( PowerTot );

% Seek the valus and address for excess power. 
[ MaxrcAmp MaxrcLoc ] = min( abs( PowerExc ) );

% The final answer for quadrotor perforamce parameters while in forward
% flight. The detail shows as the following:
% OPTFW : Optimal forward speed.
% PORFW : The value power required.
% MAXFW : The maximun forward speed.
% EXCFW : The maximum excess power.  
OPTFW = Vf( PowerLoc );
PORFW = PowerAmp;
MAXFW = Vf( MaxrcLoc );
EXCFW = Power - PowerAmp;

% Figure polt
figure( 6 );
h3 = plot( Vf, PowerPra, '--g', Vf, PowerPro, '--b' , Vf, PowerTot, 'r', Vf, PowerAva, 'm');
title( ' Power Required in Forward Flight' );
legend( 'Parasite', 'Propeller', 'Required', 'Avaliable')
set( h3, 'linewidth', 1.5 );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

% Figure polt
figure( 7 );
h4 = plot( Vf, PowerExc );
title( ' Excess Power in Forward Flight' );
legend( 'Excess' )
set( h4, 'linewidth', 1.5 );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

% Figure polt
figure( 8 )
plot( Vf, rad2deg( theta ) );
title( ' Pitch Angle in Forward Flight  ' );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Pitch Angle (Deg.) ' );
grid on

% Figure polt
figure( 8 )
plot( Vf, ThrustReqF );
title( ' Pitch Angle in Forward Flight  ' );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Thrust Required (N) ' );
grid on

% Figure polt
figure( 9 )
plot( Vf, PowerOpr );
title( ' Test  ' );
xlabel( ' Forwrad Speed (m/s) ' );
ylabel( ' Power consuption (m/W)' );
grid on

%
{[ 'Opt. FW = ' num2str( round( OPTFW ) ) ' m/s ' ];
 [ 'Min. P.R = ' num2str( round( PORFW ) ) ' W   ' ];
 [ 'Max. FW = ' num2str( round( MAXFW ) ) ' m/s ' ]}

