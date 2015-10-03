function hog_patches = hogPatches(img, frames, patchSize, blockSize)

hog_patches = [];

if size(img, 1) <= patchSize || size(img, 2) <= patchSize
    img = imresize(img, [256 256]);
end

for f = frames
    x = round(f(1)); y = round(f(2));
    x = min(max(x, patchSize), size(img, 1) - patchSize);
    y = min(max(y, patchSize), size(img, 2) - patchSize);
    
    patch = img( x - patchSize/2 : x + patchSize/2, y - patchSize/2 : y + patchSize/2);
    hog = vl_hog(patch, blockSize);
    hog = reshape(hog, 1, []);
    hog_patches = [hog_patches ; hog];
end

end