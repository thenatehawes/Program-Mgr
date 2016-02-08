classdef tree < handle
    % OBJ_DB Class
    % N.B. Hawes
    %
    % This abstract class has been written to be a superclass for several
    % different classes which utilize trees. This class provides many
    % different methods which allow attaching or adding another tree object
    % to this object, 
    
    properties (SetAccess=public,Abstract)        
        name % Name of the object database
        info % Info associated with object database
        id % tree id
        children % These are the children of this program
        cost
        time
    end
    
    properties(Hidden,Abstract)
        level
    end
    
    methods
        
        function attachchild(parentobj,childobj)
            
            if strcmp(class(childobj),'program')
                error('Cannot attach a program object to anything')
            elseif any(parentobj.children==childobj)
                error('That child is already attached to this task')
            end
            
            parentobj.children=[parentobj.children childobj];
            childobj.parent=parentobj;
            
        end
        
        function obj=addchild(parentobj,name,info,children)
            
            obj=task(name,info,parentobj,children);
            
        end
        
        function update(treeobj)
            
            updateid(treeobj);
            updatelvl(treeobj);
            updatecost(treeobj);
            
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
        
        function out=findleaves(treeobj,varargin)
            
            if ~isempty(varargin)
                verbose=1;
            else
                verbose=0;
            end
            
            if isempty(treeobj.children)
                out=treeobj;
                if verbose
                    disp(['I am ' treeobj.name ' and I am a leaf'])
                end
            else
                out=[];
                
                for i=1:length(treeobj.children)
                    
                    if isempty(varargin)
                        outtmp=findleaves(treeobj.children(i));
                    else
                        outtmp=findleaves(treeobj.children(i),varargin);
                    end
                        out=[out outtmp];
                        
                end
                
            end
            
        end
        
        function out=findchild(info)
            
            out=info;
            
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

