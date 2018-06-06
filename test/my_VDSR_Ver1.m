function [im_b,im_h] = my_VDSR_Ver1(im,model)

up_scale = 2;

if size(im,3)>1
    im = rgb2ycbcr(im);
    im = im(:, :, 1);
end

im_l = single(im)/255;
im_b = imresize(im_l, up_scale, 'bicubic');

im_h = VDSR(model, im_b');
im_h=im_h';

im_h = uint8((im_h+im_b)* 255);
im_b = uint8(im_b * 255);
