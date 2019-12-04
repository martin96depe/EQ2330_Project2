function OUT = quan(IN, levels)
    OUT = zeros(size(IN));
    if(size(levels,2)>1)
        step = levels(2) - levels(1);

        for x = 1 : size(IN,1)
            for y = 1 : size(IN,2)
                indx = find(levels-step/2 <= IN(x,y),1,'last');
                OUT(x,y) = levels(indx);
            end
        end
    else
        OUT(:,:) = levels(1);
    end
end
