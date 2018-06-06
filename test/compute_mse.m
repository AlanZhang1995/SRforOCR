function [mse_bic,mse_vdsr]=compute_mse(im_b,im_h,im_hr,flag) %flag��ʾ��Ȩ��ʽ
if flag==1 %�ݶȼ�Ȩ
    edge_=sobel2_(im_hr);      %ȥ��Ե��0ֵ��1 [1,255]
    edge_=im2double(uint8(edge_));  %��һ��
elseif flag==2 %�ݶ�ƽ����Ȩ
    edge_=sobel2_(im_hr);      %ȥ��Ե��0ֵ��1 [1,255]
    edge_=im2double(uint8(edge_));  %��һ��
    edge_=edge_ .* edge_;
elseif flag==3 %sqrt��Ȩ
    edge_=sobel2_(im_hr);      %ȥ��Ե��0ֵ��1 [1,255]
    edge_=im2double(uint8(edge_));  %��һ��
    
%     SE=strel('square',2);%�����൱��ones(X);
%     edge_=imdilate(edge_,SE);                                   %����  

    edge_=edge_ .^ (1/2);
elseif flag==4 %sigmoid����
    edge_=sobel1_(im_hr);      %ȥ��Ե[0,255]  
    edge_=im2double(uint8(edge_));  %��һ��
    edge_ = my_sigmoid4(edge_); %��ƽ�ƺ����ź��sigmoid������Ȩֵ��������:
elseif flag==5                  %��������
    edge_=other_(im_hr);
end

%ģ�����磬�����Ȩ��MSE
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