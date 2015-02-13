function Return = quadendurance( MinimunPower, BatNumber, BatCapity)
% QUADENDURANCE
%     endurance( MinimunPower, BatNumber, BatCapity ) is a
%     function to figure out the maximun endurance for the quadrotor while
%     in pure forward flight. Notice that, the endurance is couple with the
%     number of batteries and capibility of batteries. The unit of
%     endurance is in hour.

% AUTHOOR INFORMACTIONS
%     Date : 10-Feb-2015 14:40:39
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 1
%     Copyright 2015 by Avionics And Flight Simulation Laboratory

Return = BatNumber * BatCapity / MinimunPower;