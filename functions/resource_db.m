classdef resource_db<obj_db
    %RESOURCE_DB Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        info
        list
    end
    
    properties(Hidden)
       
        activeids=[];
        nextid=1;
        
    end
    
    methods
        
        function obj=resource_db(name,info,objs)
            
            if nargin<3 % if less than 3 
                objs=[];
            end
            
            obj.name=name;
            obj.info=info;
            
            for i=1:length(objs)
                attachobject(obj,objs(i));
            end
            
        end
        
        function addobject(dbobj,rname,rlab,rband)
            
            obj=resource(rname,rlab,rband);
            attachobject(dbobj,obj);
            
        end
        
        
    end
    
end

