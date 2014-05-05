%Author: Jacob Gildenblat, 2014
%Compares the learned Visual Vocabulary and the image training\cross
%calidation set, and computes histogram vectors.

function [D labels] = CalcHistograms(codebook, blockSize, patchSize, directories, TrainSet, trainSetPercentage)
    
    %Count the number of total .jpg images that will be used.
    %We need this to pre-allocate the histograms for speed.
    num = 0;
    for i = 1 : length(directories)
        directory = char(directories(i));
        num = num + length(dir([directory, '/', '*.jpg']));      
    end
    
    if TrainSet == 1
        num = round(num * trainSetPercentage);
    else
        num = round(num * (1-trainSetPercentage));
    end
    
    D = zeros(num, size(codebook, 1));
    labels = zeros(num, 1);
    
    index = 1;
    for i = 1 : length(directories)
        directory = char(directories(i));
        imagefiles = dir([directory, '/', '*.jpg']);      
        nfiles = length(imagefiles);    % Number of files found
        label = (i == 1) * -2 + 1;
        
        if (TrainSet == 1)
            files = 1 : round(nfiles*trainSetPercentage);
        else
            files = (round(nfiles*trainSetPercentage) + 1) : nfiles;
        end
        
        for ii = files
           img = imread([directory ,'/', imagefiles(ii).name]);
           if size(img , 1) < 128 || size(img, 2) < 128
                continue;
           end
           patches = ExtractHogPatches(img, patchSize, blockSize);
           D(index, : ) =  feature_histogram(codebook, patches);
           labels(index) = label;
           index = index + 1;
        end
    end
    D = D';
    labels = labels';
end
