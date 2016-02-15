classdef program<tree
    % program Class
    % N.B. Hawes
    %
    % This class has been written to make use of the tree class. This class
    % is the implementation of a "root" of a tree. Programs cannot be be
    % made children and they have no parent field.
    
    properties (SetAccess=public)        
        name % Name of the object database
        info % Info associated with object database
        id='1.' % Tree id, all programs have a default id of '1.'
        children % These are the children of this program
        cost % Total program cost
        time % Total program time
    end
    
    properties (Hidden)
        level=0; % All programs are by default level 0
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
            % Example: prgm=program('myProgram','Prog Info',childtasks);
            % This will createa a program object and populate the
            % childtasks as the program's children.
            
            
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

