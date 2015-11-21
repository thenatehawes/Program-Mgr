classdef resource_db<obj_db
    % resource_db Class
    % N.B. Hawes
    %
    % This class is a child class of the obj_db class. It is used to store
    % many "resource" objects.
    %
    % objects that are stored in this database are assumed to have an id
    % field and a loc field. This limitation may be removed in a later
    % version.
    
    properties (SetAccess=public)        
        name % Name of the object database
        info % Info associated with object database
        list % This is the actual list of objects (where the info is stored)
    end
    
    properties(Hidden)
       
        activeids=[]; % A 1xn list of doubles which are the ids of the objects in the list
        nextid=1;% The next id which is to be assigned.
        
    end
    
    methods
        
        function obj=resource_db(name,info,objs)
            % resource_db constructor method
            %
            % Inputs:
            % name - 1xn char - name of the resource database
            % info - 1xn char - some additional info
            %
            % Optional Inputs:
            % objs - 1xn resource - resource objects to populate into the database
            %
            % Example:
            %
            % r(1)=resource('asdf',5170,'lp');
            % r(2)=resource('qwer',8093,'sp');
            % res_db=resource_db('myDatabase','someinfo',r);
            %
            % This code will make 2 resources, then build a resource
            % database with both resources attached.
            
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
        % addobject function
        %
        % This method creates a resource and attaches it to the object
        % database.
        %
        % Inputs:
        % dbobj - 1x1 object database - database to attach object to
        % rname - 1xn char - resource name
        % rlab - 1x1 double - resource lab #
        % rband - 1xn char - resource band
        %
        % Example:
        % addobject(database,'asdf',5170,'lp');
        %
        % This example will create a resource and add it to the database
            
            obj=resource(rname,rlab,rband);
            attachobject(dbobj,obj);
            
        end
        
        
    end
    
end

