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
weights.total_weight = zeros(numel(library.Envelope), ...
    numel(library.Tether), numel(library.LiftingGas));

for r = 1:1:length(spheroidInputs.slenderness_ratio)
    
    spheroids(r) = spheroid(surface_area(r),volume(r),spheroidInputs.slenderness_ratio(r));
   
    % --- Weight Calculations ---
    for e = 1:1:numel(library.Envelope)
        for t = 1:1:numel(library.Tether)
            for g = 1:1:numel(library.LiftingGas)

                % % Retrieve properties from the class objects
                % rho_gas = library.LiftingGas(g).Density; % kg/m^3
                % rho_tether = library.Tether(t).WeightperMeter; % kg/m^2
                % rho_env = library.Envelope(e).WeightperMeter; % kg/m^2

                % Compute individual weights
                weights.W_env = library.Envelope(e).WeightperMeter * surface_area(r);
                weights.W_tether = library.Tether(t).WeightperMeter * surface_area(r); 
                weights.W_gas = library.LiftingGas(g).Density * volume(r);
             
                % Total weight
                weights.total_weight(e,t,g) = weights.W_env +  weights.W_tether + weights.W_gas;
                
                spheroids(r).weight_envelope(e,t,g) = weights.W_env;
                spheroids(r).weight_tether(e,t,g) = weights.W_tether;
                spheroids(r).weight_gas(e,t,g) = weights.W_gas;
            end
        end
    end

    spheroids(r).weight = weights.total_weight;
    spheroids(r) = find_lowestWeight(spheroids(r));
end

minWeight = spheroids(1).lowest_total_weight;

for i = 2:1:length(spheroids)
   if spheroids(i).lowest_total_weight < minWeight
       minWeight = spheroids(i).lowest_total_weight;
       disp(i)
   end
end

%% Input desired parameters
