% This is the alternative form to estimate power required for quadrotor  

clc
clear
clf

% Paraneters for rotorcraft
m = 1.98;
g = 9.81;
w = m*g;
rho = 1.125;

sref1 = 46e-3;
sref2 = 60e-4;
cd1 = 0.98;
cd2 = 0.48; 

% Paraneters for propeller
r_p = 0.1547;
A = pi * r_p^2;
v1h = sqrt( w / ( 2 * rho * 4 * A ) );
sigma = ( 2 * r_p * 0.04 ) / A;
kof = 0.0000151;

x = linspace( 0, 15, 100 );
y = linspace( 0, 45*2*pi/180, 100 );

[ vf, theta ] = meshgrid( x, y );

v1f = sqrt( - ( vf.^2 / 4 ) + sqrt( ( vf.^2 / 4 ).^2 + v1h^4 ) );
D2 = 0.5 * rho .* ( ( 2.*v1f ).^2 ) .* cd2 * sref2;

TRx = 0.5*rho.*vf.^2.*cd1*sref1.*sin( theta ) + D2 .* sin( theta );
TRy = m * g + D2 .* cos( theta );
TRF = sqrt( abs( TRx.^2 + TRy.^2 ) );

surfc( vf, theta, TRF )
% DDV = vf + v1f;
% 
% 
% FM = 0.6805; 
% nu = 0.03;
% 
% power_propeller = TRF .* ( v1f + vf.*sin(theta) ) ./ FM;
% power_parasite = 0.5 * rho .* ( vf.^3 ) .* cd1*sref1.*cos( theta );
% power_total = power_propeller + power_parasite;

% mesh( vf, theta, TRF)