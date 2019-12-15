function out = synthesis_f(aprox_coef,detail_coef,filter)
    N = norm(filter);
    Lo_R = filter./N;
    Hi_R = qmf(filter./N);
    
    % Check that approximation and detail vectors have same sizes
    % and remove one sample if needed
    if length(aprox_coef) > length(detail_coef)
        aprox_coef = aprox_coef(1:end-1);   
    elseif length(aprox_coef) < length(detail_coef)
        detail_coef = detail_coef(1:end-1);     
    end

    %synthesis filter
    aprox_coef_upsample = upsample(aprox_coef,2);
    detail_coef_upsample = upsample(detail_coef,2);
    %extension
    aprox_coef_upsample = wextend('1D','sym',aprox_coef_upsample,length(filter)-1);
    detail_coef_upsample = wextend('1D','sym',detail_coef_upsample,length(filter)-1);
    
    out1 = conv(aprox_coef_upsample,Lo_R,'same');
    out2 = conv(detail_coef_upsample,Hi_R,'same');
    
    %out1 = circshift(out1,-8);
    out = out1 + out2;
    
    %truncat
    out = out(length(filter):end-length(filter)+1);
end