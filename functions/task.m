classdef task<tree
    % task Class
    % N.B. Hawes
    %
    % This class has been written to instantiate the tree class. Each task
    % is a branch of a tree. Tasks may have other tasks as children OR
    % tasklines, but not both. Tasks which contain tasklines are referred
    % to as "leaves" (i.e. a terminal node of a tree). Updating a task (or
    % the program which is it's parent) will flow up the cost & time
    % associated with every leaf to the higher task levels.
    
    properties (SetAccess=public)        
        name % Name of the object database
        info % Info associated with object database
        id % Tree id
        parent % This task's immediate parent
        children % This is the actual list of objects (where the info is stored)
        cost % Task cost
        time % Task time
    end
    
    properties (Hidden)
        level % Task level
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
            % parent - this task's parent object
            % tasks - 1xn tasks or tasklines - tasks or taskline objects to add to the task
            %
            % Example: taskobj=task('myTask','Task info goes here',parentobj,childtasks)
            % This example will make a task, attach it to the parent task
            % and add the childtasks to the object.
            
            if nargin<3 % if less than 3 
                tasks=[];
                parent=[];
            end
            
            obj.name=name;
            obj.info=info;
            obj.id=[];
            
            for i=1:length(tasks)
                attachchild(obj,tasks(i));
            end
            
            if ~isempty(parent)
                attachchild(parent,obj)
            end
            
        end
        
        function removechild(childobj,varargin)
            % removechild method
            %
            % Inputs:
            % childobj - 1x1 task object - child object to remove from it's parents
            %
            % Optional Inputs:
            % 'skip' - This varargin will skip checking if the child object is empty
            %
            % Example: removechild(childobj)
            % This example will remove the child object from it's parent
            %
            % removechild(childobj,'skip')
            % This example will not ask if you're sure you want to remove a
            % child that itself has children.
            
            skip=0;
            for i=1:length(varargin)
               
                if strcmpi(varargin{i},'skip')
                    skip=1;
                end
                
            end
            
            cont=1;
            if ~isempty(childobj.children)&&~skip
                cont=input('Child object is not empty, do you want to continue? (1-yes, 0-no)');
            end
            
            if cont
                parentobj=childobj.parent;
                childobj.parent=[];
                parentobj.children(parentobj.children==childobj)=[];
                
            end
        end
        
        function destroychild(childobj,varargin)
            % destroychild method
            %
            % Inputs:
            % childobj - 1x1 task object - child object to destroy
            %
            % Optional Inputs:
            % 'skip' - This varargin will skip checking if the child object is empty
            %
            % Example: destroychild(childobj)
            % This example will delete a childobject
            %
            % removechild(childobj,'skip')
            % This example will not ask if you're sure you want to destroy a
            % child that itself has children.

            skip=0;
            for i=1:length(varargin)
               
                if strcmpi(varargin{i},'skip')
                    skip=1;
                end
                
            end
            
            cont=1;
            if ~isempty(childobj.children)&&~skip
                cont=input('Child object is not empty, do you want to continue? (1-yes, 0-no)');
            end
            
            if cont
                removechild(childobj);
                delete(childobj)
            end
            
        end
        
        function promote(childobj)
            % promote method
            %
            % Inputs:
            % childobj - 1x1 task object - child object to promote
            %
            % Example: promote(childobj)
            % This example will promote the childobj to be a child of it's
            % grandparent
            
            % Check if childobj has a parent or grandparent
            if isempty(childobj.parent)
                error('This object has no parents!')
            elseif strcmp(class(childobj.parent),'program')
                error('The parent object is of class program (and hence this object has no grandparent)')
            end
            
            % Find child object's parent object and grandparent object
            parentobj=childobj.parent;
            grandparentobj=parentobj.parent;
            
            % Remove the childobj from the parentobj's list of children
            removechild(childobj,'skip');
            % Add the childobj to the grandparentobj's list of children
            attachchild(grandparentobj,childobj);
            
        end
        
        function move(childobj,newparentobj)
            % move method
            %
            % Inputs:
            % childobj - 1x1 task object - child object to move
            % newparentobj - 1x1 task object - new parent object to attach the child object to
            %
            % Example: move(childobj,newparentobj)
            % This example will remove a child object from it's parents and
            % attach it to the new parent object.
            
            % Remove the child obj from the formerparent
            removechild(childobj,'skip');
            
            % Add the childobj to the newparentobj
            attachchild(newparentobj,childobj);
            
        end
        
        
    end
    
end

