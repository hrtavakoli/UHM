function [img, orig_img] = loadImage(img, origFlag)
    global color_space 
    global image_canonical_size
    
    orig_img = [];
    
    if nargin < 2
        origFlag = 0;
    end
        
    [y, x, c] = size(img);
    
    if c == 1   % handle the grey images
        img = repmat(img, [1, 1, 3]);
    end
    
    if y > x
        img = imresize(img, [image_canonical_size NaN]);
    else
        img = imresize(img, [NaN image_canonical_size]);
    end
    
    img = im2double(img);
    if origFlag 
        orig_img = single(img);    
    end
    img = transformColorSpace(img, color_space);
    
    img = single(img);
    
end