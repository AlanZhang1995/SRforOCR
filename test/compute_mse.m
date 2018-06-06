function [mse_bic,mse_vdsr]=compute_mse(im_b,im_h,im_hr,flag) %flag表示加权方式
if flag==1 %梯度加权
    edge_=sobel2_(im_hr);      %去边缘，0值置1 [1,255]
    edge_=im2double(uint8(edge_));  %归一化
elseif flag==2 %梯度平方加权
    edge_=sobel2_(im_hr);      %去边缘，0值置1 [1,255]
    edge_=im2double(uint8(edge_));  %归一化
    edge_=edge_ .* edge_;
elseif flag==3 %sqrt加权
    edge_=sobel2_(im_hr);      %去边缘，0值置1 [1,255]
    edge_=im2double(uint8(edge_));  %归一化
    
%     SE=strel('square',2);%作用相当于ones(X);
%     edge_=imdilate(edge_,SE);                                   %膨胀  

    edge_=edge_ .^ (1/2);
elseif flag==4 %sigmoid整合
    edge_=sobel1_(im_hr);      %去边缘[0,255]  
    edge_=im2double(uint8(edge_));  %归一化
    edge_ = my_sigmoid4(edge_); %用平移和缩放后的sigmoid函数对权值进行整合:
elseif flag==5                  %其他函数
    edge_=other_(im_hr);
end

%模拟网络，计算加权的MSE
edge_=sqrt(edge_);

im_b=double(im_b) .* edge_;
im_h=double(im_h) .* edge_;
im_hr=double(im_hr) .* edge_;

%mse_bic
imdff =im_b  - im_hr;
imdff = imdff(:);
edge_=edge_(:);
mse_bic = sqrt(sum(imdff.^2)/sum(edge_.^2));
% mse_bic = 20*log10(255/mse_bic)

%mse_vdsr
imdff =im_h  - im_hr;
imdff = imdff(:);
mse_vdsr = sqrt(sum(imdff.^2)/sum(edge_.^2));
% mse_vdsr = 20*log10(255/mse_vdsr)