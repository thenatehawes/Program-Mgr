classdef tree < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
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
        
        function removechild(parentobj,childobj)
            
            cont=1;
            if ~isempty(childobj.children)
                cont=input('Child object is not empty, do you want to continue? (1-yes, 0-no)');
            end
            
            if cont
                parentobj.children(parentobj.children==childobj)=[];
                delete(childobj)
            end
            
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
            
            if isempty(obj.level)
                lvl=0;
            else
                lvl=obj.level-1;
            end
            
            tmp=sprintf([repmat('\t',1,lvl) obj.id ' ' obj.name]);
            disp(tmp);
            
            if ~isempty(obj.children)

                for i=1:length(obj.children)
                   disp(obj.children(i)) 
                end

            end
            
        end
        
    end
    
end

