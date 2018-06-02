function im_sr1=process_SR(net1,im)
im=imresize(im, 2, 'bicubic');

if size(im,3) == 3
    flag_3c=1;
    im_3c = rgb2ycbcr(im);
    im_input = im_3c(:, :, 1);
else
    flag_3c=0;
    im_input = im;
end

im_sr1=my_VDSR(net1,im_input);

if flag_3c==1
    im_3c(:, :, 1)=im_sr1;
    im_sr1 = ycbcr2rgb(im_3c);
end