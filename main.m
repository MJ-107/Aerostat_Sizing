% Macie Orrell
% Aerostat sizing tool
% =========================================================================

%% Initialization

close all
clear all
clf
clc

%% Create + plot different balloon shapes for desired size

% == Run inputs file for spheroid plotting parameters ==
run('spheroidInitializationInputs.m'); 

% == Create mesh ==
mesh = computeMesh(spheroidInputs.phi_points, ...
    spheroidInputs.theta_points);

% == Create Plot ==
plotSpheroids(spheroidInputs, mesh, ...
    'Prolate Spheroids with Different Slenderness Ratios');

%% Calculate Volume and Surface Area

% == Calculate Volume and SA == 
[volume, surface_area] = computeSAandV(spheroidInputs);

% == Create material library == 
library = createMaterialLibrary();

% == Run mission inputs from input file == 
run('missionInputs.m') % Run inputs file for mission parameters

%% 

% Preallocate arrays

total_weight = zeros(numel(spheroidInputs.slenderness_ratio),numel(library.Envelope), ...
    numel(library.Tether), numel(library.LiftingGas));

total_SA = zeros(numel(spheroidInputs.slenderness_ratio),numel(library.Envelope), ...
    numel(library.Tether), numel(library.LiftingGas));

for r = 1:1:length(spheroidInputs.slenderness_ratio)
   
    % --- Weight Calculations ---
    for g = 1:1:numel(library.LiftingGas)
        for e = 1:1:numel(library.Envelope)
            for t = 1:1:numel(library.Tether)

                % Compute individual weights
                W_gas = library.LiftingGas(g).Density * volume(r);
                W_env = library.Envelope(e).WeightperMeter * surface_area(r);
                W_tether = library.Tether(t).WeightperMeter * surface_area(r); 
              
                % Total weight
                total_weight(r,g,e,t) = W_gas + W_env + W_tether;

                % SA calculation
                total_SA(r,g,e,t) = surface_area(r);
               
            end
        end
    end

end

% switch analysisDimension
%     case 1 % 1D search
%     case 2 % 2D search
%     %case 3
% end

colors = lines(numel(library.LiftingGas)); 
markers = {'*','+','x','^','h','o'}; 

figure(2)
hold on 
for r = 1:1:length(spheroidInputs.slenderness_ratio)
   
    for g = 1:1:numel(library.LiftingGas)
        for e = 1:1:numel(library.Envelope)
            for t = 1:1:numel(library.Tether)
                scatter(total_SA(r,g,e,t),total_weight(r,g,e,t), 20, colors(g,:), markers{e});
               
            end
        end
    end
end
hold off


% isPareto = paretofront([total_SA(:), total_weight(:)]);
% 
% SA_pareto = total_SA(isPareto);
% W_pareto  = total_weight(isPareto);