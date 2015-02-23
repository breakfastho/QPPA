function output = quadparameters( GeoHeight )
% QUADPARAMETERS
%     quadparameters( GeoHeight ) is a function to declare the necessary
%     parameters for the quadrotor.

% AUTHOOR INFORMACTIONS
%        Date : 10-Feb-2015 14:40:39
%      Author : Wei-Chieh Chang
%   Education : M.Sc. of Aerospace Engineering, Tamkang University
%     Version : 2.0

% Copyright 2015 by Avionics And Flight Simulation Laboratory

% DECLARE VARIABLES OF STANDARD ATMOSPHERE
%        Gravity : The gravity. Ususlly treat it as a constant. 
% PowerAvaliable : The totoal power which provided by motor.
%      TotalMass : The gross mass of the quadrotor.
%    RotorNumber : The number of motor
%   RotorRadious : The radious of propellers, in SI.
%          Sref1 : Reference area of frame.
%          Sref2 : Reference area of frame which under the propeller plane.
%            CD1 : Drag coefficient of Sref1 
%            CD2 : Drag coefficient of Sref2


global AirDensity Power Gravity TotalMass Weight 
global RoterArea RotorNumber RotorRadious Sref1 Sref2 CD1 CD2
global BatNumber BatCapity BatVoltag


Atomdata = stdatm( GeoHeight );  
AirDensity = Atomdata( :, 6 );
Gravity = Atomdata( :, 2 );

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


FigureCounter = 0;