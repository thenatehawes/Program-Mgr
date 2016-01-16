classdef tree < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess=public,Abstract)        
        name % Name of the object database
        info % Info associated with object database
        children % These are the children of this program
        cost
        time
    end
    
    methods
        
        function attachchild(treeobj,childobj)
            
            if strcmp(class(treeobj),'program')
                error('Cannot attach a program object to anything')
            end
            
            treeobj.children=[progobj.children childobj];
            
        end
        
        function addchild(treeobj,name,info)
            
            obj=task(name,info);
            attachchild(treeobj,obj);
            
        end
        
    end
    
end

