function removal = quadrange( OptimalSpeed, Endurance )
% QUADRANGE 
%     quadrange( OptimalSpeed, Endurance ) is a function to seek the
%     maximum range for a quadrotor. The main algorithm is using optimal
%     forward speed, it also means the minimum power required speed speed. 
%     We using the speed and endurance to figure out the maximum range. The
%     unit of range in kilometer. 

% AUTHOOR INFORMACTIONS
%     Date : 03-Mar-2015 02:12:24
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 2
%     Copyright 2015 by Avionics And Flight Simulation Laboratory

removal = ( 3600 * OptimalSpeed * Endurance ) / ( 2 * 1000 );
ranges = [ num2str( 1e3 * removal ) ' Meters ' ]