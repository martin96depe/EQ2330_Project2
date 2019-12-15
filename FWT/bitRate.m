function entropy = bitRate(Lo_Loq, Lo_Hiq,Hi_Loq, Hi_Hiq, stepq)
%%%%%%%%%%
%
% Entropy = -SUM(pixel_probability*log2(pixel_probability))
% we use ideal VLC, so the bit rate is equal to the entroy
%
%%%%%%%%%%

    %vectors of wavelet coefficients
    LL = reshape(Lo_Loq(:,:),[1,size(Lo_Loq(:,:),1)*size(Lo_Loq(:,:),2)]);
    LH = reshape(Lo_Hiq(:,:),[1,size(Lo_Hiq(:,:),1)*size(Lo_Hiq(:,:),2)]);
    HL = reshape(Hi_Loq(:,:),[1,size(Hi_Loq(:,:),1)*size(Hi_Loq(:,:),2)]);
    HH = reshape(Hi_Hiq(:,:),[1,size(Hi_Hiq(:,:),1)*size(Hi_Hiq(:,:),2)]);
    % compute bins to estimate pdfs
    bins_LL = min(LL):stepq:max(LL);
    bins_LH = min(LH):stepq:max(LH);
    bins_HL = min(HL):stepq:max(HL);
    bins_HH = min(HH):stepq:max(HH);
    % histogram with bins to get pdfs
    pdfLL = hist(LL,bins_LL)/length(LL);
    pdfLH = hist(LH,bins_LH)/length(LH);
    pdfHL = hist(HL,bins_HL)/length(HL);
    pdfHH = hist(HH,bins_HH)/length(HH);
    % compute hentropy from pdfs
    enLL = -sum(pdfLL.*log2(pdfLL+eps));
    enLH = -sum(pdfLH.*log2(pdfLH+eps));
    enHL = -sum(pdfHL.*log2(pdfHL+eps));
    enHH = -sum(pdfHH.*log2(pdfHH+eps));
    % total hentropy / average
    entropy = 0.25*(enLL+enLH+enHL+enHH);%   Detailed explanation goes here
end

