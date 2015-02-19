function  removal = inflowangle( InducedVelocity, RotorRadious, RotorRevolution )
% INFLOWANGLE 
%     inflowangle( InducedVelocity, RotorRadious, RotorRevolution ) is a
% function to figure out the inflow angle of propeller. The main equation
% is come form the book which discuss about the blade elements method. 

% AUTHOOR INFORMACTIONS
%     Date : 14-Feb-2015 00:04:31
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 3
%     Copyright 2015 by Avionics And Flight Simulation Laboratory

removal = InducedVelocity ./ ( RotorRadious * RotorRevolution );