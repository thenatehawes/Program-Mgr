classdef tree < root
    % tree Class
    % N.B. Hawes
    %
    % This abstract class has been written to be a superclass for several
    % different classes which utilize trees. This class provides many
    % different methods which allow attaching or adding another tree object
    % to this tree, automatically labeling the level of tree objects under
    % this tree object, and find tree objects by property values.
    %
    % 2016-02-14 Note: In hindsight, there should probably be 2 abstract
    % classes, "root" and "tree". Tree should be a subclass of root.
    % Program would inherit from root and task from tree. I'm not going to
    % implement this now, but I may at some point in the future.
    
    properties (SetAccess=public,Abstract)        
        parent % This task's immediate parent
    end
    
    methods               
        
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

