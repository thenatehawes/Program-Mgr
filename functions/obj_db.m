classdef obj_db<handle
    %OBJ_DB Summary of this class goes here
    %   Detailed explanation goes here
    % objects assumed to have an id field and a loc field
    
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
            
            for i=1:length(dbobj.list)
                % this is pretty ugly- probably want to change it later
                x=cell(length(fields),1); % pre-alloc
                for k=1:length(fields)
                    x{k}=dbobj.list(i).(fields{k});
                end
               
                if fh(x{:})
                    obj=[obj,dbobj.list(i)];
                end
                
            end
            
            if isempty(obj);
                flag=0;
            else
                flag=1;
            end
            
        end
        
        function attachobject(dbobj,obj)
        % attachobject function
        %
        % Inputs:
        % dbobj - 1x1 object database - database to attach object to
        % obj - 1x1 object handle - object to add to object database
        %
        % Example:
        % attachobject(database,object);
        %
        % This example will add the object to the database
        
        for i=1:length(dbobj.list)
            if isequal(dbobj.list(i),obj)
                error('This object is already in the database')
            end
        end
        
        dbobj.list=[dbobj.list,obj];
        obj.id=dbobj.nextid;
        obj.loc=length(dbobj.list);
        
        dbobj.activeids=[dbobj.activeids,dbobj.nextid];
        dbobj.nextid=dbobj.nextid+1;
        
            
        end
        
        function removeobject(dbobj,obj)
        % removeobject function
        %
        % Inputs:
        % dbobj - 1x1 object database - database to remove object from
        % obj - 1x1 object handle - object to remove from object database
        %
        % Example:
        % attachobject(database,object);
        %
        % This example will remove an object to the database
        
        ind=find(obj.id==dbobj.activeids,1,'first'); % find the matching activeid
        dbobj.activeids(ind)=[]; % remove the active id from the dbobj
        
        dbobj.list(obj.loc)=[]; % remove the object from the dbobj list
        
        obj.loc=[]; % remove the location & id from the object
        obj.id=[];
            
        end
        
        % Overrides
        function disp(dbobj,varargin)
        % disp function
        %
        % Inputs:
        % dbobj - 1x1 object database - database to display object from
        % field - 1x1 char - optional, char name
        %
        % Example:
        % disp(database);
        %
        % This example will display the active ids and # of object in db
        %
        % Example:
        % disp(database,'name');
        %
        % This example will display the "name" field of each object in the
        % database
           
           if  isempty(varargin)

               disp('%%%%%%%%%%%%%%%%%%%%%%')
               disp('# of objects in db')
               disp(num2str(length(dbobj.list)))   
               disp('Active IDs:')
               disp(num2str(dbobj.activeids))
               disp('%%%%%%%%%%%%%%%%%%%%%%')
               
           else
               
               field=varargin{1};
               disp('%%%%%%%%%%%%%%%%%%%%%%')
               disp(['Displaying List of ' field 's' ])
               for i=1:length(dbobj.list)
                   
                   switch class(dbobj.list(i).(field))
                   
                       case 'char'
                           disp(dbobj.list(i).(field));
                           
                       case 'double'
                           disp(num2str(dbobj.list(i).(field)));
                           
                       otherwise
                           error('Display only setup for char or double fields')
                           
                   end
           
               end
               disp('%%%%%%%%%%%%%%%%%%%%%%')
                
           end
           
        end
            
          
    end
    
    methods(Abstract)
        
        addobject
        
    end
    
end

