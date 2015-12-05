classdef task < obj_db
    %TASK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess=public)        
        name % Name of the object database
        info % Info associated with object database
        list % This is the actual list of objects (where the info is stored)
        parent
        cost
        time
    end
    
    properties(Hidden)
       
        activeids=[]; % A 1xn list of doubles which are the ids of the objects in the list
        nextid=1;% The next id which is to be assigned.
        id % 1x1 double - resource id#
        loc % 1x1 double - resource location in resource_db
        
    end
    
    methods
        
        function obj=task(name,info,objs)
            % task constructor method
            %
            % Inputs:
            % name - 1xn char - name of the task
            % info - 1xn char - some additional info
            %
            % Optional Inputs:
            % objs - 1xn ?? - ?? objects to populate into the database
            %
           
            
            if nargin<3 % if less than 3 
                objs=[];
            end
            
            obj.name=name;
            obj.info=info;
            
            for i=1:length(objs)
                attachobject(obj,objs(i));
            end
            
        end
        
        function addobject(a)
            
            b=1;
            
        end
        
        
    end
    
end

