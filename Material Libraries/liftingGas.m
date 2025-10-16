classdef liftingGas
    properties
        Name                   % Name of material
        WeightperCubicMeter    % In kgs/m^3
        Link                   % String to link with material
    end

    methods
        function obj = liftingGas(name, WeightperCubicMeter, Link)
            obj.Name = name;
            obj.WeightperCubicMeter = WeightperCubicMeter;
            obj.Link = Link;
        end

        function openLink(obj)
            if ~isempty(obj.Link)
                web(obj.Link, '-browser');
            else
                disp('No link specified.');
            end
        end
    end
end