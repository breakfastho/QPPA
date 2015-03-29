function removal = verticalflight( Vc0, Vc1 )
% VERTICALFLIGHT
%     verticalflight( FM, Nu, ModeThrustC ,Vc0, Vc1 ) is a co-function with
%     QUADAnalyser. The main propose of this function is to fugure out the
%     minimum power, minimun power required R/C and maximun R/C in the
%     specified condition. In this functtion, you have to input the 


% AUTHOOR INFORMACTIONS
%     Date : 10-Feb-2015 14:40:39
%     Author : Wei-Chieh Chang
%     Degree : M. Eng. Dept. Of Aerospace Engineering Tamkang University
%     Version : 1
%     Copyright 2015 by Avionics And Flight Simulation Laboratory

global FM Nu SizeM LengM CounterFig CounterGeh
global GeoHeight AirDensity Power Gravity TotalMass Weight 
global RoterArea RotorNumber RotorRadious Sref1 Sref2 CD1 CD2

% This is a statement to judge the number of input data. If there without 
% any input augment, then the initial and final value of climb velocity will 
% be defult. Else if there have one input data, then we just define the final
% value of climb velocity.
if nargin == 0
    Vc0 = 0;
    Vc1 = 15;
elseif nargin == 1
    Vc1 = 15;
end  

% Declare the vertical climb rate as a column data from Vc0 to Vc1 which 
% devidinto 500 steps. Because the climb velocity is independent with variable 
% height. Thus, it doesn't needed in the for-loop 
Vc = linspace( Vc0, Vc1, 100 );

% Declare the power avaliable as a column data. The power avaliable is a 
% constant. But in this case, we have declare that as column data so that we 
% can operate it in the matlab function. 
PowerAva = Power .* ones( size( Vc ) );

% The for-loop to compute performance parameters in different hight. 
for i = 1: 1: LengM 
    
    % The induced velocity in hoveing, deriving from momemtum method.
    V1h( i, 1 ) = sqrt( Weight( i, 1 ) ./ ( 2 * AirDensity( i, 1 ) * RotorNumber * RoterArea ) );

    % The induced velocity in climb.
    V1c( i, : ) = ( -0.5 .* Vc ) + sqrt( ( 0.5 .* Vc ).^2 + V1h( i, 1 )^2 );
    
    % Declare the thrust required from the forces act on the quadrotor.
    % The thrust have to elimiate drag, wake drag and weight. \
    DragParasi( i, : ) = 0.5 * AirDensity( i, 1 ) * Sref1 * CD1 .* ( Vc.^2 );
    DragParasi2( i, : ) = 0.5 * AirDensity( i, 1 ) * Sref2 * CD2 .* ( ( 2 .* V1c( i, : ) ).^2 );
    
    % The thrust avaliable and thrust required, you can derive it from the momentum method.
    ThrustAva( i, : ) = PowerAva ./ ( Vc + V1c( i, : ) );
    ThrustReqC( i, : ) = DragParasi( i, : ) + DragParasi2( i, : ) + Weight( i, 1 );
    
    % Ther process to computing the power required for each term.    
    PowerPro( i, : ) = ThrustReqC( i, : ) .* ( V1c( i, : ) + Vc ) ./ FM ;
    PowerPra( i, : ) = DragParasi( i, : ) .* Vc ...
                        + DragParasi( i, : ) .* ( 2 * V1c( i, : ) );
    PowerReq( i, : ) = PowerPro( i, : ) + PowerPra( i, : );
    PowerExc( i, : ) = PowerAva - PowerReq( i, : );
    
    % Figure out the minimum value for power required in vertical flight. But,
    % the answer must be zero. There have another algorithm to prove there will
    % have a powerreqired drop during the low climb rate.
    if( PowerExc( i, 1 ) <= 0 )
        
        MAXRC( i, 1 ) = 0;
        
    else
        
        [ PowerAmp( i, 1 ) PowerLoc( i, 1 ) ] = min( PowerReq( i, : ) );
        [ MaxrcAmp( i, 1 ) MaxrcLoc( i, 1 ) ] = min( abs( PowerExc( i, : ) ) );
        
        % Base on the minimum power required to fine an optimal climb rate.
        OPTRC( i, 1 ) = Vc( PowerLoc( i, 1 ) );
        MAXRC( i, 1 ) = Vc( MaxrcLoc( i, 1 ) );
        PORRC( i, 1 ) = PowerAmp( i, 1 );
        EXCRC( i, 1 ) = max( PowerExc( i, 1 ) );
        
    end
    
end

% Plot the figure 
figure( CounterFig );
CounterFig = CounterFig +1;
h = plot( GeoHeight, MAXRC );
title( ' Maximun Climb Rate in Vertical Flight ' );
set( h, 'linewidth', 1.9 );
xlabel( ' Vertical Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

% Plot the figure 
figure( CounterFig );
CounterFig = CounterFig +1;
plot( Vc, PowerPra( CounterGeh, : ), 'g',...
      Vc, PowerPro( CounterGeh, : ), 'b',...
      Vc, PowerReq( CounterGeh, : ), 'r',...
      Vc, PowerAva, 'm' );
title( { [ ' Power Required in Vertical Flight ' ];
         [ ' At ' num2str( GeoHeight( CounterGeh, 1 ) ) ' m height ' ] } );
legend( 'Parasite', 'Propeller', 'Required', 'Avaliable')
xlabel( ' Vertical Speed (m/s) ' );
ylabel( ' Power Required (W) ' );
grid on;

parameter = ...
{[ 'Opt. R/C = ' num2str( round( OPTRC( CounterGeh, 1 ) ) ) ' m/s ' ];
 [ 'Min. P.R = ' num2str( round( PORRC( CounterGeh, 1 ) ) ) ' W   ' ];
 [ 'Max. R/C = ' num2str( round( MAXRC( CounterGeh, 1 ) ) ) ' m/s ' ]}

removal = 0;
% 
% figure( 4 )
% h2 = plot( Vc, PowerExc );
% title( ' Excess Power in Vertical Flight' );
% legend( ' Excess ' );
% set( h, 'linewidth', 1.9 );
% xlabel( ' Vertical Speed (m/s) ' );
% ylabel( ' Power Required (W) ' );
% grid on;
% 
% figure( 5 );
% h5 = plot( Vc, ThrustReqC, Vc, ThrustAva, Vc, DragParasi, '-.m',...
%     Vc, Weight .* ones( size( Vc ) ), '-.g' );
% title( ' Thrust Required and Avaliable ' );
% xlabel( ' Vertical Speed (m/s) ' );
% ylabel( ' Thrust Required (N) ' );
% legend( ' Required ', ' Avaliable ', 'Parasite Drag', ' Weight ' );
% grid on;
% 


