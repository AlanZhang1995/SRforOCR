function [psnr_bic,psnr_vdsr]=my_SRCNN_PSNR(im_b,im_h,im_hr)

if size(im_hr,3)>1
    im_hr = rgb2ycbcr(im_hr);
    im_hr = im_hr(:, :, 1);
end

%% compute PSNR

psnr_bic = compute_psnr(im_hr,im_b);
psnr_vdsr = compute_psnr(im_hr,im_h);