function removal = quadpitch( ForwardSpeed )

% QUADPITCH
% quadpitch( ForwardSpeed ) is a function to compute the pitch angle for
% quadrotor while in steady forward flight. The formaula was developed in 
% my master thesis. 

global AirDensity Power Gravity TotalMass Weight RotorNumber RotorRadious Sref1 Sref2 CD1 CD2

% Determinate the drag by standard drag equation.
Drag = 0.5 * AirDensity .* ForwardSpeed.^2 .* CD1 * Sref1;

% Pitch angle estiamtion
pitch = asin( ( -( Weight ./ Drag ) + sqrt( ( Weight ./ Drag ).^2 + 4 ) ) ./ 2 );
removal = pitch;