classdef resource < handle
    % resource Class
    % N.B. Hawes
    %
    % This class contains the info for specific objects. They are meant to
    % be stored and used in a object database (resource_db)
    
    properties (SetAccess=private)
       name % 1xn char - resource name
       lab % 1x1 double - lab number
       band % 1xn char - band name ('t','lp','sp','eb') are possibilities
       cost % cost per week
       alr % applied labor rate
    end
    
%    properties (Hidden,Access={?resource_db}) % this should work but doesnt?
    properties (Hidden)
        id % 1x1 double - resource id#
        loc % 1x1 double - resource location in resource_db
    end
    
    methods
        
        function obj=resource(name,lab,band)
        % resource constructor
        %
        % Inputs:
        % rname - 1xn char - resource name
        % rlab - 1x1 double - resource lab #
        % rband - 1xn char - resource band
        %
        % Example:
        % resource('asdf',5170,'lp');
        %
        % This example will create a resource object
        
           obj.name=name;
           obj.lab=lab;
           obj.band=band;
           
           switch band
              
               case 't'
                   obj.cost=4600;
                   obj.alr=0.8;
                   
               case 'lp'

                   obj.cost=6600;
                   obj.alr=0.84;
                   
               case 'sp'

                   obj.cost=9930;
                   obj.alr=0.78;
                   
               case 'eb'
                   
                   obj.cost=12000;
                   obj.alr=0.78;    
                   
               otherwise
                   
                   error('Unknown Band');
               
           end
            
        end
        
        % Overrides
        function out=isequal(obja,objb)
        % isequal function
        %
        % Inputs:
        % obja - 1x1 resource - first resource for comparison
        % objb - 1x1 resource - second resource for comparison
        %
        % Example:
        % out=isequal(obja,objb)
        %
        % This example will eval to 1 if obja & objb have the same name,
        % lab, and band; otherwise it evaluates to 0.
            
           if strcmp(obja.name,objb.name)&&(obja.lab==objb.lab)&&strcmp(obja.band,objb.band)
               out=1;
           else
               out=0;
           end
            
        end
        
        
    end
    
end

