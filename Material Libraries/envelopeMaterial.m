classdef envelopeMaterial
    properties
        Name              % Name of material
        WeightperMeter    % In kgs/m
        Link              % String to link with material
    end

    methods
        function obj = envelopeMaterial(name, WeightperMeter, Link)
            obj.Name = name;
            obj.WeightperMeter = WeightperMeter;
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
