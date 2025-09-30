function plotSpheroids(x, y, z, i, rows, cols, ratio)

% Inputs:
%   x, y, z     - Coordinates of the spheroid surface
%   i           - Index of the subplot
%   rows, cols  - Subplot grid dimensions
%   ratio       - Slenderness ratio (for title)
    
    subplot(rows, cols, i);
    surf(x, y, z, 'EdgeColor', 'none');
    axis equal;
    title(['Slenderness Ratio: ', num2str(ratio)]);
    xlabel('X'); ylabel('Y'); zlabel('Z');
    light; lighting gouraud; camlight headlight;
end