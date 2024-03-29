function [ imOut ] = denoise( image, kernel_type, varargin)

% convert images to double
image = double(image);

switch kernel_type
    case 'box'
       filtered_img = imboxfilt( image, varargin{1} );
       imOut = uint8(filtered_img);
    case 'median'
       filtered_img = medfilt2( image, [varargin{1} varargin{1}] );
       imOut = uint8(filtered_img);
    case 'gaussian'
       % sigma, h
       filter = gauss2D( varargin{1}, varargin{2} );
       filtered_img = imfilter(image, filter);
       imOut = uint8(filtered_img);
end


end
