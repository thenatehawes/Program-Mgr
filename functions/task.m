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
        
        function obj=addchild(parentobj,name,info,children)
        % addchild function
        %
        % Inputs:
        % parentobj - 1x1 tree - parent tree to which the child tree is attached
        % name - 1xn string - name of the child tree to be added
        % info - 1xn string - info of the child tree to be added
        % children - 1xn tree - tree objects which should be the children
        % of the child object
        %
        % Example:
        % childobj=addchild(parent_tree,'myChild','Child Tree Object',grandchild);
        %
        % This example will call the task constructor to create the child
        % and attach it to the parent object.
        
        obj=addchild@program(name,info,parentobj,children);
        %obj=task(name,info,parentobj,children);
            
        end        
        
%         function out=updatecost(treeobj)
%            
%             out=updatecost@program(treeobj);
%             
%         end


        function out=updatecost(treeobj)
           
            if isempty(treeobj.children)
                
                if isempty(treeobj.cost)
                    treeobj.cost=0;
                end
                
                if isempty(treeobj.time)
                    treeobj.time=0;
                end
                
                out=[treeobj.cost,treeobj.time];
                
            else
            
                out=[0,0];

                for i=1:length(treeobj.children)
                    
                    outtmp=updatecost(treeobj.children(i));
                    out=out+outtmp;

                end
                
                treeobj.cost=out(1);
                treeobj.time=out(2);
        
            end
        end
        

        function update(treeobj)
        % update function
        %
        % Inputs:
        % treeobj - 1x1 tree - tree object to be updated
        %
        % Example:
        % update(tree_obj);
        %
        % This example will update the tree object and all children,
        % grandchildren, etc. of the tree object. This will update the
        % cost&time fields, update the levels, and update the ids.
            
%             updatecost(treeobj);
            update@program(treeobj); % Call superclass update
            
        end
        
    end
    
end

