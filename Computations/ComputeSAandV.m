function [volume, surface_area] = ComputeSAandV(spheroidInputs)

for r = 1:1:length(spheroidInputs.slenderness_ratio)

    % c is major semi-axis (axis of symmetry, alinged w/ z)
    % a is minor semi-axis (equatorial plane, x/y constant)
    % a is constant, specified in initialization script

    spheroidInputs.c = spheroidInputs.slenderness_ratio(r) * ...
    spheroidInputs.a; 

    % Get volume in m^3
    volume(r) = (4/3) * pi * spheroidInputs.c * spheroidInputs.a^2;
    
    % Get eccentricity of prolate shperoid
    e = sqrt(1 - (spheroidInputs.a^2 / spheroidInputs.c^2));
        
    if e == 0
            % This is a sphere
            % Use formula for SA of a sphere
            surface_area(r) = 4 * pi * spheroidInputs.a^2; 
        
    else
            % Use formula for SA of an ellipsoid
            surface_area(r) = 2 * pi * spheroidInputs.a^2 * (1 + ...
                (spheroidInputs.c / (spheroidInputs.a * e)) * asin(e));
    end

end

end

