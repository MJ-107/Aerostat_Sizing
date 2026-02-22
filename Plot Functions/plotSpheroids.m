function plotSpheroids(spheroidInputs, mesh, figureTitle)

% Initialize plot tiles
[tile_cols, tile_rows] = ...
getSubplotGrid(length(spheroidInputs.slenderness_ratio));

figure(1); % Initialize figure
colormap turbo % Specify color map

% Loop through slenderness ratios and plot every spheroid
for r = 1:1:length(spheroidInputs.slenderness_ratio)
    spheroidInputs.c = spheroidInputs.slenderness_ratio(r) * ...
    spheroidInputs.a; 

    % Parametric equations for prolate spheroid
    x = spheroidInputs.a * sin(mesh.phi) .* cos(mesh.theta);
    y = spheroidInputs.a * sin(mesh.phi) .* sin(mesh.theta);
    z = spheroidInputs.c * cos(mesh.phi);
   
    % Create Plot
    subplot(tile_rows, tile_cols, r);
    surf(x, y, z, 'EdgeColor', 'none');
    axis equal;
    title(['Slenderness Ratio: ', num2str(spheroidInputs.slenderness_ratio(r))])
    light; 
    lighting gouraud; 
    camlight headlight;
end
    % Add figure title
    sgtitle(figureTitle);

end
