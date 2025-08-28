function [cols, rows] = getSubplotGrid(numPlots)

% Inputs: n - Total number of subplots
% Outputs:[ cols - Number of columns, rows - Number of rows]

    cols = ceil(sqrt(numPlots));
    rows = ceil(numPlots / cols);
end