function [im_b,im_h] = my_VDSR_Ver2(im,model)

up_scale = 2;

if size(im,3)>1
    im = rgb2ycbcr(im);
    im = im(:, :, 1);
end

im_l = single(im)/255;
im_b = imresize(im_l, up_scale, 'bicubic');

% a=im_b(6,6)+im_b(12,12);
% imwrite(im_b,strcat('D:\CNN\SRCNN&CDSR_in_matlab\VDSR\result\1\',num2str(a),'.jpg'));
im_b = PaddingOrDepaddingForTest2(im_b,1);%padding
% imwrite(im_b,strcat('D:\CNN\SRCNN&CDSR_in_matlab\VDSR\result\2\',num2str(a),'.jpg'));

%im_h = VDSR(model, im_b);
im_h = VDSR(model, im_b');
im_h=im_h';

im_b = PaddingOrDepaddingForTest2(im_b,0);
im_h = PaddingOrDepaddingForTest2(im_h,0);
% imwrite(im_b,strcat('D:\CNN\SRCNN&CDSR_in_matlab\VDSR\result\3\',num2str(a),'.jpg'));

im_h = uint8((im_h+im_b)* 255);
im_b = uint8(im_b * 255);
