classdef beta_distribution_manager < handle
    
    properties
        B;
        A;
        
        RECENT;
        
        N;
        
        number_of_frames;
        max_frames;
    end
    
    methods
        function obj = beta_distribution_manager(N,max_frames)
            obj.N = N;
            obj.max_frames = max_frames;
            
            obj.B = cell(max_frames,1);
            obj.B{1} = sparse(triu(10*ones(N),1));
            
            obj.A = cell(max_frames,1);
            obj.A{1} = sparse(triu(10*ones(N),1));
            
            obj.RECENT = ones(N);
            
            obj.number_of_frames = 1;
        end
        
        function update_coefficients(obj,newA,newB,active_nodes)
            if ~exist('active_nodes','var')
                active_nodes = 1:obj.N;
            end
            
            obj.number_of_frames = obj.number_of_frames + 1;
            
            obj.RECENT(active_nodes,active_nodes) = obj.number_of_frames * ones(length(active_nodes));
            
            newA(~active_nodes,~active_nodes) = 0;
            newB(~active_nodes,~active_nodes) = 0;
            
            newA = sparse(triu(newA,1));
            newB = sparse(triu(newB,1));
            
            obj.A{obj.number_of_frames} = newA;
            obj.B{obj.number_of_frames} = newB;
        end
        
        
        %% 
        function A = get_full_A(obj)
            A = zeros(obj.N);
            
            for i=1:obj.N-1
                for j=i+1:obj.N
                    step = obj.RECENT(i,j);
                    entry = obj.A{step}(i,j);
                    A(i,j) = entry;
                end
            end
            
            A = A + A';
        end
        
        function B = get_full_B(obj)
            B = zeros(obj.N);
            
            for i=1:obj.N-1
                for j=i+1:obj.N
                    step = obj.RECENT(i,j);
                    B(i,j) = obj.B{step}(i,j);
                end
            end
            
            B = B + B';
        end
        
        function [a b] = get_a_b_vectors(obj,i,j)
            a = zeros(obj.number_of_frames,1);
            b = zeros(obj.number_of_frames,1);
            
            for t=1:obj.number_of_frames
                %a
                if ~isempty(obj.A{t}(i,j))
                    a(t) = obj.A{t}(i,j);
                else
                    a(t) = 1;
                end
                %b
                if ~isempty(obj.B{t}(i,j))
                    b(t) = obj.B{t}(i,j);
                else
                    b(t) = 1;
                end
            end
        end       
        
        %% P
        function Pexp = get_P_exp_progression(obj,i,j)
            Pexp = zeros(obj.max_frames,1);
            [a, b] = obj.get_a_b_vectors(i,j);
            
            for t=1:obj.max_frames
                Pexp(t) = obj.get_P_exp(a(t),b(t));
            end
        end
        
        function Pmode = get_P_mode_progression(obj,i,j)
            Pmode = zeros(obj.max_frames,1);
            [a, b] = obj.get_a_b_vectors(i,j);
            
            for t=1:obj.max_frames
                Pmode(t) = obj.get_P_mode(a(t),b(t));
            end
        end
        
        function Pvar = get_P_var_progression(obj,i,j)
            Pvar = zeros(obj.max_frames,1);
            [a, b] = obj.get_a_b_vectors(i,j);
            
            for t=1:obj.max_frames
                Pvar(t) = obj.get_P_var(a(t),b(t));
            end
        end
        
        function px = plot_beta(obj,i,j,t)
            [a, b] = obj.get_a_b_vectors(i,j);
            
            x = 0:.01:1;
            px = betapdf(x,a(t),b(t));
            
            plot(x,px);
        end
        
        %% W
        
        function Wexp = get_W_exp_progression(obj,i,j,Bframes)
            Wexp = zeros(obj.max_frames,1);
            [a, b] = obj.get_a_b_vectors(i,j);
            
            for t=1:obj.max_frames
                B = Bframes{t};
                x = sum(1*or(B(:,i),B(:,j)));
                Wexp(t) = obj.get_W_exp(a(t),b(t),x);
            end
        end
        %% 
        function H = get_entropy_progression(obj,i,j)
            H = zeros(obj.max_frames,1);
            [a, b] = obj.get_a_b_vectors(i,j);
            
            for t=1:obj.max_frames
                H(t) = obj.get_beta_entropy(a(t),b(t));
            end
        end
        
        function KL_step = get_KL_step_progression(obj,i,j)
            KL_step = zeros(obj.max_frames-1,1);
            [a, b] = obj.get_a_b_vectors(i,j);
            
            for t=2:obj.max_frames
                KL_step(t-1) = obj.get_KL(a(t),b(t),a(t-1),b(t-1));
            end
        end
    end
    
    methods(Static)
        function H = get_beta_entropy(a,b)
            H = log(beta(a,b)) - (a-1)*digamma(a) - (b-1)*digamma(b) + (a+b-2)*digamma(a+b);
        end
        
        function Pexp = get_P_exp(a,b)
            Pexp = a/(a+b);
        end
        
        function Pmode = get_P_mode(a,b)
            Pmode = (a-1)/(a+b-2);
        end
        
        function Wexp = get_W_exp(a,b,x)
           Wexp =  x* a/(a+b);
        end
        
        function KL = get_KL(a2,b2,a1,b1)
            KL = log(beta(a1,b1)/beta(a2,b2)) - (a1-a2)*digamma(a2) - (b1-b2)*digamma(b2) + (a1 - a2 + b1 - b2)*digamma(a2+b2);
        end
        
        function Var = get_P_var(a,b)
            Var = a*b / ( (a+b)^2 * (a+b+1));
        end
    end
end