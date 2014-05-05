function h = feature_histogram(codebook, features)

    h = zeros(1, size(codebook, 1));
    
%This can be used for hard value comparing.
%     for i = 1 : size(features, 1)
%         patch = features(i, :);
%         [m idx] = min(sum(((codebook - repmat(patch, size(codebook, 1), 1)).^2)')');
%         h(idx) = h(idx) + 1;
%     end
%     h = h / sum(sum(h));

%Soft values in the histogram:
    sigma = 0.2;
    for i = 1 : size(features, 1)
        for j = 1 : size(codebook, 1)
            feature = features(i, :);
            word = codebook(j, :);
            h(j) = h(j) + exp(-sum( (word - feature).^2 ) / (2*sigma^2));
        end
    end
    h = h / sum(sum(h));

    
end
