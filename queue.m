classdef queue < handle
    
    properties
        capacity;
        s;
        e;
    end
    
    properties (GetAccess = private)
        q;
    end
    
    methods
        function obj = queue(N)
            obj.capacity = N;
            obj.s=2;
            obj.e=1;
            obj.q=zeros(1,N);
        end
        
        function empty_criterion = isEmpty(obj)
            empty_criterion = (obj.s==(obj.e+1));
        end
        
        function empty(obj)
            obj.s = obj.e+1;
        end
        
        function full_criterion = isFull(obj)
            full_criterion = (getSize(obj)==obj.capacity);
        end
        
        function size = getSize(obj)
            if isEmpty(obj)
                size=0;
            else
                size = (obj.e-obj.s+1);
            end
        end
        
        function defragment(obj)
            tmp = zeros(1,obj.capacity);
            tmp(1:1:getSize(obj)) = obj.q(obj.s:1:obj.e);
            obj.e = obj.e-obj.s + 1;
            obj.s=1;
            obj.q = tmp;
        end
        
        function add(obj,elem)
            if isEmpty(obj)
                obj.s=1;
                obj.e=1;
                obj.q(obj.e)=elem;
            elseif ~isFull(obj)
                if obj.e==obj.capacity
                    defragment(obj);
                end
                obj.q(obj.e+1)=elem;
                obj.e=obj.e+1;
            end
        end
        
        function elem = remove(obj,elem)
            if ~isEmpty(obj)
                output = obj.q(obj.s);
                obj.s=obj.s+1;
                elem=output;
            end
        end
        
        function decision = exists(obj,elem)
           if ~isEmpty(obj)
              decision = sum(ismember(obj.q(obj.s:obj.e),elem));
           else
               decision=0;
           end
        end
        
        function output = get(obj)
            if ~isEmpty(obj)
                output = obj.q(obj.s:   obj.e);
            else
                output = NaN;
            end
        end
        
        function output = history(obj)
           if ~isEmpty(obj)
               output = obj.q(obj.e:-1:1);
           else
               output = NaN;
           end
        end
    end
end