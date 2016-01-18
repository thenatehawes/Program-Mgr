classdef program<tree
    %PROGRAM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess=public)        
        name % Name of the object database
        info % Info associated with object database
        id % Tree id
        children % These are the children of this program
        cost
        time
    end
    
    properties (Hidden)
        level
    end
    
    methods
        
        function obj=program(name,info,tasks)
            % program constructor method
            %
            % Inputs:
            % name - 1xn char - name of the resource database
            % info - 1xn char - some additional info
            %
            % Optional Inputs:
            % tasks - 1xn task - task objects to populate into the tree
            %
            % Example:
            
            
            if nargin<3 % if less than 3 
                tasks=[];
            end
            
            obj.name=name;
            obj.info=info;
            obj.id=[];
            
            for i=1:length(tasks)
                attachchild(obj,tasks(i));
            end
            
        end
        
    end
    
end

