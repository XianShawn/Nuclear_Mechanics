function volume = load_tiff_stack(tif_file, varargin)
% loads a stack of tiff images into the matlab workspace
% if a folder is specified instead of a stack of images, the individual
% images in that folder must be labelled by time in the format 
% 'T_00034.tif'

if exist(tif_file,'dir') % loop through the directory and load images
    tif_directory = tif_file;
    if nargin == 1
        size_T = length(dir(fullfile(tif_directory,'T_*')));
        vol_3D = load_tiff_stack(tif_directory, 1);
        volume = zeros([size(vol_3D) size_T], class(vol_3D));   

        for t = 1:size_T
            if ndims(volume)==4 % 3D
                volume(:,:,:,t) = load_tiff_stack(tif_directory, t);
            elseif ndims(volume) == 3 % 2D
                volume(:,:,t) = load_tiff_stack(tif_directory, t);
            end
        end
        return;
    else
        tif_file = fullfile(tif_directory, ...
                             sprintf('T_%05d.tif',varargin{1}));
    end
end
    
if exist(tif_file, 'file')
    tiff_info = imfinfo(tif_file);
    size_X = tiff_info(1).Width;
    size_Y = tiff_info(1).Height;
    size_Z = length(tiff_info);

    switch size_Z
        case 1
            volume = imread(tif_file);
        otherwise
            for i = 1:size_Z
                volume(:,:,i) = imread(tif_file,i);
            end
    end
end