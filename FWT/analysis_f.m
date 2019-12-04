function [aprox_coef,detail_coef] = analysis_f(f, filter)
    %filter preparation
    N = norm(filter);
    Lo_D = wrev(filter./N);
    Hi_D = wrev(qmf(filter./N));

    
    signal_length = length(f);
    f = wextend('1D','per',f,length(f));

    %analysis filter
    temp1 = conv(f,Hi_D);
    temp2 = conv(f,Lo_D);
    
    %temp1 = circshift(temp1,2);
    %temp2 = circshift(temp2,2);
    
    %truncat
    temp1 = temp1(length(filter) -1 + signal_length+1:length(filter) - 1 + 2*signal_length);
    temp2 = temp2(length(filter) - 1 + signal_length+1:length(filter) - 1 +2*signal_length);
    
    detail_coef = temp1(2:2:end);
    aprox_coef = temp2(2:2:end);
end