classdef resource < handle
    %RESOURCE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess=private)
       name
       lab
       band
       cost % cost per week
       alr % applied labor rate
    end
    
%    properties (Hidden,Access={?resource_db this should work but doesnt?
    properties (Hidden)
        id
        loc
    end
    
    methods
        
        function obj=resource(name,lab,band)
        
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
        
    end
    
end

