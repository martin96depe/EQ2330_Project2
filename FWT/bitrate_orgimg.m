function bit_rate = bitrate_orgimg(img, stepq)
    %vectors of wavelet coefficients
    Im = reshape(img(:,:),[1,size(img(:,:),1)*size(img(:,:),2)]);
    % compute bins to estimate pdfs
    bins_Im = [min(Im):stepq:max(Im)];
    % histogram with bins to get pdfs
    pdfIm = hist(Im,bins_Im)/length(Im);
    % compute hentropy from pdfs
    bit_rate = -sum(pdfIm.*log2(pdfIm+eps));
end

