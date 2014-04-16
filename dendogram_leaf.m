classdef dendogram_leaf < handle
    
    properties
        parent;
        group;
    end
    
    methods
        function obj = dendogram_leaf(parent,group)
            obj.parent = parent;
            obj.group = group; 
        end
    end
end