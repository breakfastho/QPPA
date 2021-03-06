function removal = quadparameters( InputHeight )
% QUADPARAMETERS
%     quadparameters( GeoHeight ) is a function to declare the necessary
%     parameters for the quadrotor.

% AUTHOOR INFORMACTIONS
%        Date : 23-Mar-2015 23:56:33
%      Author : Wei-Chieh Chang
%   Education : M.Sc. of Aerospace Engineering, Tamkang University
%     Version : 3.0

% Copyright 2015 by Avionics And Flight Simulation Laboratory

% DECLARE VARIABLES OF STANDARD ATMOSPHERE
%          Power : The total power which provided by motor.
%         Weight : The columnn data about weight which in SI
%        Gravity : The columnn data about gravity which in SI
%      GeoHeight : The columnn data about height which in SI
%     AirDensity : The columnn data about air density which in SI
%      TotalMass : The gross mass of the quadrotor.
%    RotorNumber : The number of motor
%   RotorRadious : The radious of propellers which in SI
%          Sref1 : Reference area of frame.
%          Sref2 : Reference area of frame which under the propeller plane.
%            CD1 : Drag coefficient of Sref1 
%            CD2 : Drag coefficient of Sref2

global FM Nu SizeM LengM CounterFig CounterGeh
global GeoHeight AirDensity Power Gravity TotalMass Weight 
global RoterArea RotorNumber RotorRadious Sref1 Sref2 CD1 CD2
global BatNumber BatCapity BatVoltag

FM = 0.8;
Nu = 0.03;

CounterFig = 1;
% CounterGeh = 1;

SizeM = size( InputHeight );
LengM = length( InputHeight );

Atomdata = stdatm( InputHeight );  
GeoHeight = Atomdata( :, 1);
Gravity = Atomdata( :, 2 );
AirDensity = Atomdata( :, 6 );

TotalMass = 1.9;
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

parameter = ...
[ 'At         ' num2str( GeoHeight( CounterGeh, 1 ) ) ' m height ' ]


removal = [ GeoHeight Gravity AirDensity ];
