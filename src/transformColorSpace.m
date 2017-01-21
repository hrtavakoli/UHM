function img = transformColorSpace(img, color_space)

switch lower(color_space)
    case 'rgb'
        img = img;
    case 'lum'
        img = bsxfun(@times, img, reshape([0.299 0.587 0.114], [1 1 3]));
        img = sum(img,3);
    case 'grb'
        img = img(:,:,[2 1 3]);
    case 'ycbcr'
        img = rgb2ycbcr(img);
    case 'hsv'
        img = flipdim(rgb2hsv(img), 3);   %value-saturation-hue
        img(:,:,2) = img(:,:,2) .* exp(1i*2*pi*img(:,:,3));
        img(:,:,3) = img(:,:,2); % compying the previous channel here as well.
    case 'cielab'
        lab = makecform('srgb2lab');
        img = applycform(img, lab);
        img = bsxfun(@rdivide, img, reshape([100 128 128], [1 1 3]));
    case 'iz'
        img = rgb2iz(img, [0.3 0.6 0.1]);
    otherwise
        disp 'Unknown color space! Using RGB...\n';
end

end
