function [aprox_coef,detail_coef] = analysis_f(f, filter)
    %filter preparation
    Lo_R = filter./norm(filter); %reconstruction LPF
    Lo_D = wrev(Lo_R); %decomposition LPF
    Hi_R = qmf(Lo_R);   %reconstruction HPF
    Hi_D = wrev(Hi_R); %decomposition HPF
    
    f = wextend('1D','sym',f,length(filter)-1);

    %analysis filter
    temp1 = conv(f,Hi_D,'same');
    temp2 = conv(f,Lo_D,'same');
    
    %temp1 = circshift(temp1,2);
    %temp2 = circshift(temp2,2);
    
    %truncat
    temp1 = temp1(length(filter) -1:end - length(filter));
    temp2 = temp2(length(filter) -1:end - length(filter));
    
    detail_coef = downsample(temp1,2);
    aprox_coef = downsample(temp2,2);
end