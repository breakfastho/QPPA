function removal = quadrange( OptimalSpeed, PowerRequired )
% QUADRANGE 
%     quadrange( OptimalSpeed, Endurance ) is a function to seek the
%     maximum range for a quadrotor. The main algorithm is using optimal
%     forward speed, it also means the minimum power required speed speed. 
%     We using the speed and endurance to figure out the maximum range. The
%     unit of range in kilometer. 

% AUTHOOR INFORMACTIONS
%     Date : 10-Mar-2015 00:55:56
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 2.1
%     Copyright 2015 by Avionics And Flight Simulation Laboratory

global BatNumber BatCapity

hours = BatNumber * BatCapity / PowerRequired ;
removal = ( 3600 * OptimalSpeed *  hours ) / ( 2 * 1000 );
ranges = [ num2str( removal ) ' Meters ' ]