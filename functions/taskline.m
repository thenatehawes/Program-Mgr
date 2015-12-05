classdef taskline<handle
    % taskline Class
    % N.B. Hawes
    %
    % This class contains the info for a line of a task.
    
    properties(SetAccess=private)
        resource % 1x1 resource object - the resource assigned to the task line
        time % 1x1 double - time in man-wks
        cost % 1x1 double - cost of this taskline
    end
     
%     properties(Hidden) % uncomment if this will be used with an obj_db
%         id % 1x1 double - taskline id#
%         loc % 1x1 double - taskline location in task
%     end
    
    methods
        
        % Constructor
        function obj=taskline(resource,time,timeunit)
            
           if nargin<3,
               timeunit='wk';
           end
           
           obj.resource=resource;
           
           switch timeunit
               
               case 'wk'
                   mult=1;
               case 'mon'
                   mult=52/12;
               case 'hr'
                   mult=1/40;
               case 'yr'
                   mult=52;
               otherwise
                   error('unknown time unit')
           end
           
           obj.time=time*mult;
           obj.cost=obj.time*resource.cost;
           
        end
        
        % Override
        function [cost,time]=plus(obja,objb)
        % plus function
        %
        % Inputs:
        % obja - 1x1 taskline - first taskline for adding
        % objb - 1x1 taskline - second taskline for adding
        %
        % Example:
        % [cost,time]=plus(obja,objb)
        %
        % This example will add the cost of the tasks and the total time of
        % the tasks.
        
        cost=obja.cost+objb.cost;
        time=obja.time+objb.time;
            
        end
        
        function [cost,time]=sum(objs)
        % sum function
        %
        % Inputs:
        % objs - nx1 taskline - tasklines to sum together
        %
        % Example:
        % [cost,time]=sum([obja,objb,objc])
        %
        % This example will sum the cost and time of the three objects.
            
            cost=0;
            time=0;
            for i=1:length(objs)

                cost=cost+objs(i).cost;
                time=time+objs(i).time;

            end
            
        end
                        
        function out=isequal(obja,objb)
        % isequal function
        %
        % Inputs:
        % obja - 1x1 taskline - first taskline for comparison
        % objb - 1x1 taskline - second taskline for comparison
        %
        % Example:
        % out=isequal(obja,objb)
        %
        % This example will eval to 1 if obja & objb have the same resource
        % and time; otherwise it evaluates to 0.
            
           if isequal(obja.resource,objb.resource)&&(obja.time==objb.time)
               out=1;
           else
               out=0;
           end
            
        end
        
    end
    
end

