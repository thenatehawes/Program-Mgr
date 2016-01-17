classdef task<tree
    %TASK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess=public)        
        name % Name of the object database
        info % Info associated with object database
        parent
        children % This is the actual list of objects (where the info is stored)
        cost
        time
    end
    
    methods
        
        function obj=task(name,info,parent,tasks)
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
            
            for i=1:length(tasks)
                attachchild(obj,tasks(i));
            end
            
            attachobject(parent,child)
            
        end
        
        function promote(childobj)
            
            % Check if childobj has a parent or grandparent
            if ~isempty(childobj.parent)
                error('This object has no parents!')
            elseif strcmp(class(childobj.parent),'program')
                error('The parent object is of class program (and hence this object has no grandparent)')
            end
            
            % Find child object's parent object and grandparent object
            parentobj=childobj.parent;
            grandparentobj=parentobj.parent;
            
            % Remove the childobj from the parentobj's list of children
            parentobj.children(parentobj.children==childobj)=[];
            % Add the childobj to the grandparentobj's list of children
            grandparent.children=[grandparent.children taskobj];
            
        end
        
        function move(childobj,newparentobj)
            
            % Find the childobj's former parent
            formerparentobj=childobj.parent;
            
            % Remove the child obj from the formerparent
            formerparentobj.children(formerparentobj.children==childobj)=[];
            
            % Add the childobj to the newparentobj
            newparentobj.children=[newparentobj.children childobj];
            
            % Set the childobj's parent field to it's new parent
            childobj.parent=newparentobj;
            
        end
        
        
    end
    
end

