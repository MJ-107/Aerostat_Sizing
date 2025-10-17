classdef liftingGas
    properties
        Name       % Name of material
        Density    % In kgs/m^3
        Link       % String to link with material
    end

    methods
        function obj = liftingGas(Name, Density, Link)
            obj.Name = Name;
            obj.Density = Density;
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