classdef spheroid
    %SPHEROID Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        surfaceArea double
        volume double
        slendernessRatio double 
        weight double
        
        % Individual weights
        weight_envelope double
        weight_tether double
        weight_gas double

        % Processed data 
            % Col 1: value
            % Col 2-4: index
        lowest_total_weight double = [0];
        lowest_total_weight_idx double = [0 0 0];


    end
    
    methods
        function obj = spheroid(SA, vol, SR)
            obj.surfaceArea = SA;
            obj.volume = vol;
            obj.slendernessRatio = SR;
        end
        
        function obj = find_lowestWeight(obj)
            obj.lowest_total_weight = [obj.weight(1,1,1)];
            
            e=1;
            while e <= length(obj.weight(:,1,1))
                t=1;
                while t <= length(obj.weight(1,:,1))
                     g=1;
                    while g <= length(obj.weight(1,1,:))
                        if obj.weight(e,t,g) < obj.lowest_total_weight
                            obj.lowest_total_weight = obj.weight(e,t,g);
                            obj.lowest_total_weight_idx = [e,t,g];
                        end
                        g = g+1;
                    end
                    t = t+1;
                end
                e = e+1;
            end

        end
    end
end

