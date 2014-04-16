classdef stack <handle
    
    properties
       capacity;
    end
    
    properties (GetAccess = private)
       pointer;
       s;
    end
    
    methods
        function obj = stack(N)
            obj.capacity = N;
            obj.s = zeros(N,1);
            obj.pointer=0;
        end
        
        function push(obj,elem)
           if obj.pointer<obj.capacity
               obj.pointer = obj.pointer+1;
               obj.s(obj.pointer)=elem;
           end
        end
        
        function elem = pop(obj)
           if obj.pointer>0
               obj.pointer = obj.pointer-1;
               elem = obj.s(obj.pointer+1);
           else
               elem=NaN;
           end
        end
        
        function elements = get(obj)
            if obj.pointer>0
                elements = obj.s(1:1:obj.pointer);
            else
                elements = NaN;
            end
        end
        
        function obj = empty(obj)
            obj.pointer=0;      
        end
        
        function population = size(obj)
            population = obj.pointer;
        end
        
        function elem = current(obj)
            elem = obj.s(obj.pointer);
        end
    end 
end