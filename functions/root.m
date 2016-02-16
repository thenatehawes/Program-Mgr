classdef root < handle
    %ROOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetAccess=public,Abstract)
        name % Name of the object database
        info % Info associated with object database
        id % tree id
        children % These are the children of this program
    end
    
    properties(Hidden,Abstract)
        level % Level of tree object within a tree
    end
    
    methods(Abstract)
        
        addchild
        
    end
    
    methods
        
        function attachchild(parentobj,childobj)
        % attachchild function
        %
        % Inputs:
        % parentobj - 1x1 tree - parent tree to which the child tree is attached
        % childobj - 1x1 tree - child tree to attach
        %
        % Example:
        % attachchild(parent_tree,child_tree);
        %
        % This example will attach the child_tree to the parent_tree and
        % automatically update the child_tree's parent field
            
            if ~isa(childobj,'tree')
                error('Child must be a tree object')
            elseif any(parentobj.children==childobj)
                error('That child is already attached to this task')
            elseif ~isempty(childobj.parent)
                error('Child already has a parent')
            end
            
            parentobj.children=[parentobj.children childobj];
            childobj.parent=parentobj;
            
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
            
            updateid(treeobj);
            updatelvl(treeobj);
            %updatecost(treeobj);
            
        end
        
        function updatelvl(treeobj)
           
           if strcmp(class(treeobj),'program')
               treeobj.level=1;
           else
               
               parentobj=treeobj.parent;
               
               if isempty(parentobj.level)
                   parentobj.level=0;
               end
               
               treeobj.level=parentobj.level+1;
               
           end
           
           for i=1:length(treeobj.children)
               updatelvl(treeobj.children(i))
           end
            
        end
          
        function updateid(treeobj,ind)
            
            if nargin==1,
                ind=1;
            end
            
            if strcmp(class(treeobj),'program')
                treeobj.id='1.';
            else
                parentobj=treeobj.parent;
                treeobj.id=[parentobj.id num2str(ind) '.'];
            end
            
            for i=1:length(treeobj.children)
                updateid(treeobj.children(i),i);
            end
                
            
        end
        
        function [flag,out]=findchild(treeobj,fh,fields)
        % findchild function
        %
        % Inputs:
        % treeobj - 1x1 tree - tree to query
        % fh - 1x1 function handle - function handle to use for querying
        % fields - nx1 cell array - fields to check each query against
        %
        % Example:
        % [flag,objects]=findchild(treeobj,@(x1,x2,x3)
        % (x1==3&&x2>1000)||x3>50,{'level','cost','time'});
        %
        % This example will return any objects are on level 3 with a cost
        % greater than 1000 or has a time greater than 50. Note that if any
        % levels, cost, or time are empty vectors the above will error. If
        % there's any chance that the tree fields may be empty then use the
        % below version.
        %
        % [flag,objects]=findchild(treeobj,@(x1,x2,x3)
        % (x1==3&x2>1000)|x3>50,{'level','cost','time'});
        %
        % The only difference is using & and | instead of && and ||. Empty
        % fields will effectively evaluate to false.
        
            out=[];
            x=cell(length(fields),1); % pre-alloc
            for k=1:length(fields)
                x{k}=treeobj.(fields{k});
            end
            % If this tree obj matches, the fh & fields, then add it to the
            % output vector
            if fh(x{:})
                out=[out,treeobj];
            end
            % Then run it recursively for all children too
            for i=1:length(treeobj.children)
                [flagtmp,outtmp]=findchild(treeobj.children(i),fh,fields);
                out=[out,outtmp];
            end
            
            if isempty(out)
                flag=0;
            else
                flag=1;
            end
            
        end
        
        % Overrides
        
        function disp(obj)
            
            for i=1:length(obj)
            
            if isempty(obj(i).level)
                lvl=0;
            else
                lvl=obj(i).level-1;
            end
            
            tmp=sprintf([repmat('\t',1,lvl) obj(i).id ' ' obj(i).name]);
            disp(tmp);
            
            if ~isempty(obj(i).children)

                for j=1:length(obj(i).children)
                   disp(obj(i).children(j)) 
                end

            end
            
            end
            
        end
        
        function out=ismember(objs1,objs2)
            
            out=zeros(1,length(objs1));
            
            for i=1:length(objs1)
                
                yes=0;
                for j=1:length(objs2)
                   
                    if isequal(objs1(i),objs2(j))
                        yes=1;
                    end
                    
                end
                
                out(i)=yes;
                
            end
            
        end
        
    end
    
end

