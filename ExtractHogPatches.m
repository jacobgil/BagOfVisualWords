%Author: Jacob Gildenblat, 2014

function patches = ExtractHogPatches(img, patchSize, blockSize)
    if (size(img, 3) == 3)
    	img = single(double(rgb2gray(img)));
    else
    	img = single(double(img));
    end
    
   [frames] = vl_sift(img);
   patches = hogPatches(img, frames', patchSize, blockSize);
end
