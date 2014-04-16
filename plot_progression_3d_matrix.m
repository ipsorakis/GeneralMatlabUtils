function prog = plot_progression_3d_matrix(Wframes,x,y,color)

if ~exist('color','var')
    color = 'b';
end

if ~iscell(Wframes)
    
    
    N = size(Wframes,1);
    frames = size(Wframes,3);
    
    prog = zeros(frames,1);
    
    for t=1:frames
        prog(t) = Wframes(x,y,t);
    end
    
else
    frames = length(Wframes);
    
    prog = zeros(frames,1);
    
    for t=1:frames
        W = decompress_adjacency_matrix(Wframes{t});
        if ~isempty(W)
            elem = W(x,y);
            if ~isempty(elem)
                prog(t) = elem;
            else
                prog(t) = 0;
            end
        else
            prog(t) = 0;
        end
    end
    
end

plot(prog,color)
end