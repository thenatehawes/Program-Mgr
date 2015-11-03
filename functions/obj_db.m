classdef obj_db<handle
    %OBJ_DB Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Abstract)
        name
        info
        list
    end
    
    properties(Abstract,Hidden)
        
        activeids
        nextid
        
    end
    
    methods
        
%         function obj=obj_db(name,info,objs)
%             
%             if nargin<3
%                 objs=[];
%             end
%             
%             obj.name=name;
%             obj.info=info;
%             
%             for i=1:length(objs)
%                 objs(i).id=i;
%                 obj.list=objs(i);
%             end
%             
%         end
        
        function [flag,obj]=query_db(dbobj,fh,fields)
        % query_db function
        %
        % Inputs:
        % dbobj - 1x1 object database - database to query
        % fh - 1x1 function handle - function handle to use for querying
        % fields - nx1 cell array - fields to check each query against
        %
        % Example:
        % [flag,objects]=query_db(database,@(x1,x2,x3)
        % (strcmp(x1,'bob')&&strcmp(x2,'smith'))||x3==5,{'firstname','lastn
        % ame','id'});
        %
        % This example will return any objects that are named bob smith or
        % have an id # of 5.
        
            obj=[];
            
            j=1;
            for i=1:length(dbobj.objs)
                % this is pretty ugly- probably want to change it later
                x=cell(length(fields,1)); % pre-alloc
                for k=1:length(fields)
                    x{k}=dbobj.objs(j).(fields{k});
                end
               
                if fh(x{:})
                    obj(j)=dbojb.objs(j);
                    j=j+1;
                end
                
            end
            
            if isempty(obj);
                flag=0;
            else
                flag=1;
            end
            
        end
        
    end
    
    methods(Abstract)
        
        addobject
        attachobject
        removeobject
        
    end
    
end

