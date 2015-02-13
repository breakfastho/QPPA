function Return = quadrange( OptimalSpeed, Endurance )
% QUADRANGE 
%     quadrange( OptimalSpeed, Endurance ) is a function to seek the
%     maximum range for a quadrotor. The main algorithm is using optimal
%     forward speed, it also means the minimum power required speed speed. 
%     We using the speed and endurance to figure out the maximum range. The
%     unit of range in kilometer. 

% AUTHOOR INFORMACTIONS
%     Date : 10-Feb-2015 14:40:39
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 1
%     Copyright 2015 by Avionics And Flight Simulation Laboratory

Return = ( 3600 * OptimalSpeed * Endurance ) / ( 2 * 1000 );