function removal = quadendurance( MinimunPower )
% QUADENDURANCE
%     endurance( MinimunPower, BatNumber, BatCapity ) is a
%     function to figure out the maximun endurance for the quadrotor while
%     in pure forward flight. Notice that, the endurance is couple with the
%     number of batteries and capibility of batteries. The unit of
%     endurance is in hour.

% AUTHOOR INFORMACTIONS
%     Date : 03-Mar-2015 02:12:24
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 2
%     Copyright 2015 by Avionics And Flight Simulation Laboratory

global BatNumber BatCapity

removal = BatNumber * BatCapity / MinimunPower;
endurances = [ num2str( round( removal * 60 ) ) ' Mins' ]