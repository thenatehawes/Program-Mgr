classdef program<root
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
            obj=task(name,info,parentobj,children);
            
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
            
            updatecost(treeobj);
            update@root(treeobj); % Call superclass update
            
        end
        
    end
    
end

