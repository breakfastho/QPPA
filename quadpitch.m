function Return = quadpitch( ForwardSpeed )


global AirDensity Power Gravity TotalMass Weight RotorNumber RotorRadious Sref1 Sref2 CD1 CD2

Drag = 0.5 * AirDensity .* ForwardSpeed.^2 .* CD1 * Sref1;
Return = asin( ( -( Weight ./ Drag ) + sqrt( ( Weight ./ Drag ).^2 + 4 ) ) ./ 2 );
