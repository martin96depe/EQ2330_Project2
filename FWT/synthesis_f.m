function out = synthesis_f(aprox_coef,detail_coef,filter)
    N = norm(filter);
    Lo_R = filter./N;
    Hi_R = qmf(filter./N);

    %synthesis filter
    aprox_coef_upsample = upsample(aprox_coef,2);
    detail_coef_upsample = upsample(detail_coef,2);
    %extension
    signal_length = length(aprox_coef_upsample);
    aprox_coef_upsample = wextend('1D','per',aprox_coef_upsample,length(aprox_coef_upsample));
    detail_coef_upsample = wextend('1D','per',detail_coef_upsample,length(detail_coef_upsample));
    
    out1 = conv(aprox_coef_upsample,Lo_R);
    out2 = conv(detail_coef_upsample,Hi_R);
    
    %out1 = circshift(out1,-8);
    out = out1 + out2;
    
    %truncat
    out = out(length(filter) - 1 + signal_length+1:length(filter) - 1 + 2*signal_length);
    out = circshift(out,length(filter));
end