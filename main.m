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


figure(2)
hold on 
for r = 1:1:length(spheroidInputs.slenderness_ratio)
   
    for g = 1:1:numel(library.LiftingGas)
        for e = 1:1:numel(library.Envelope)
            for t = 1:1:numel(library.Tether)
                scatter(total_SA(r,g,e,t),total_weight(r,g,e,t))
                
               
            end
        end
    end
end
hold off




% minWeight = spheroids(1).lowest_total_weight;
% 
% for i = 2:1:length(spheroids)
%    if spheroids(i).lowest_total_weight < minWeight
%        minWeight = spheroids(i).lowest_total_weight;
%    end
% end

%% Filter in order of priority criteria

% Filter to only spheroids with the smallest surface area
% candidates = filter_smallestSA(spheroids);
% candidates = filter_lowestTotalWeight





% % Find spheroid with smallest surface area
% 
% minSA = [spheroids(1).surfaceArea, 0]; % initialize with first value
% 
% i = 2;
% while i <= length(spheroids)
% 
%     if spheroids(i).surfaceArea < minSA
%         minSA = [spheroids(i).surfaceArea, i];
%     end
% 
%     i = i + 1;
% 
% end


        % % Find smallest SA
        % function obj = find_smallestSA(obj)
        % 
        %     obj.smallest_SA = [obj.surfaceArea(1,1,1)];
        % 
        %     e=1;
        %     while e <= length(obj.surfaceArea(:,1,1))
        %         t=1;
        %         while t <= length(obj.surfaceArea(1,:,1))
        %              g=1;
        %             while g <= length(obj.surfaceArea(1,1,:))
        %                 if obj.surfaceArea(e,t,g) < obj.smallest_SA
        %                     obj.smallest_SA = [obj.surfaceArea(e,t,g), e, t, g];
        %                 end
        %                 g = g+1;
        %             end
        %             t = t+1;
        %         end
        %         e = e+1;
        %     end








%% Input desired parameters
