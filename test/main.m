close all;
clear all;

tic;

%%%%%%%%%%%%%%%path_set%%%%%%%%%%%%%%%
model = 'D:\CNN\20VDSR.mat'; %CNN model path
output_path='D:\CNN\ICDAR2015-TextSR-dataset\RELEASE_2015-08-31\DATA\TEST\LR\VDSR_resultt\'; %SR image output path
file_path1 =  'D:\CNN\ICDAR2015-TextSR-dataset\RELEASE_2015-08-31\DATA\TEST\LR\';% input images path
file_path2 =  'D:\CNN\ICDAR2015-TextSR-dataset\RELEASE_2015-08-31\DATA\TEST\HR\';% label path
file_path3 = 'D:\\CNN\\ICDAR2015-TextSR-dataset\\RELEASE_2015-08-31\\DATA\\TEST\\ANNOTATION\\';    %ANNOTATION path

mkdir(output_path);
img_path_list1 = dir(strcat(file_path1,'*.pgm'));%获取该文件夹中所有pgm格式的图像 
img_path_list2 = dir(strcat(file_path2,'*.pgm'));%获取该文件夹中所有pgm格式的图像  
path_list3=dir(strcat(file_path3,'*.txt'));

num=0;
count=0;
PSNR_bic=[];%PSNR
PSNR_vdsr=[];
SSIM_bic=[];%SSIM
SSIM_vdsr=[];

img_num = length(img_path_list1);%获取图像总数量  
if img_num > 0 %有满足条件的图像  
        for j = 1 : img_num  %逐一读取图像
            image_name = img_path_list1(j).name;% 图像名  
            im  =   imread(strcat(file_path1,image_name)); 
            [im_b,im_h]  = my_VDSR_Ver1(im,model);%做VDSR重建
%             [im_b,im_h]  = my_VDSR_Ver2(im,model);%做VDSR重建(padding)
             imwrite(im_h,[output_path,image_name]);
%             imwrite(im_b,['D:\CNN\ICDAR2015-TextSR-dataset\RELEASE_2015-08-31\DATA\TEST\LR\VDSR_result\',image_name]);
             im_hr  =   imread(strcat(file_path2,img_path_list2(j).name));
           %% 计算评价指标
             %PSNR
             [psnr_bic,psnr_vdsr]=my_SRCNN_PSNR(im_b,im_h,im_hr);
             PSNR_bic=[PSNR_bic,psnr_bic];
             PSNR_vdsr=[PSNR_vdsr,psnr_vdsr];
             %SSIM
             [ssim_bic,~]=ssim(im_b, im_hr);
             [ssim_vdsr,~]=ssim(im_h, im_hr);
             SSIM_bic=[SSIM_bic,ssim_bic];
             SSIM_vdsr=[SSIM_vdsr,ssim_vdsr];
             
            %OCR正确率
            name = path_list3(j).name;
            fileID1 = fopen(strcat(file_path3,name));
            annotation = fgetl(fileID1); %标注
            count=count+length(annotation);
            fclose(fileID1);
            [ocr,ocr_content]=auto_ocr(annotation,im_h);%错误量
            content_save(j).content=ocr_content;
            num=num+ocr;
            
            
           
%            %% 输出几个样例 
%              if (mod(j,13)==0)
% %              figure, imshow(im_hr); title('HR Image');
% %              figure, imshow(im_b); title('Bicubic Interpolation');
% %              figure, imshow(im_h); title('VDSR Reconstruction');
%              mkdir(strcat('D:\CNN\SRCNN&CDSR_in_matlab\VDSR\result\',num2str(j)))
%              imwrite(im_hr,strcat('D:\CNN\SRCNN&CDSR_in_matlab\VDSR\result\',num2str(j),'\3HR Image.jpg'));
%              imwrite(im_b,strcat('D:\CNN\SRCNN&CDSR_in_matlab\VDSR\result\',num2str(j),'\1Bicubic Interpolation.jpg'));
%              imwrite(im_h,strcat('D:\CNN\SRCNN&CDSR_in_matlab\VDSR\result\',num2str(j),'\2VDSR Reconstruction.jpg'));
%              end
             %%
              j %查看进度

        end  
end  
fprintf('MISSION COMPLAIN\n');
%% 保存指标
save('20VDSR_pnsr.mat','PSNR_bic','PSNR_vdsr');
save('20VDSR_ssim.mat','SSIM_bic','SSIM_vdsr');
save('20VDSR_mse.mat','MSE_bic','MSE_vdsr');
save('20VDSR_ocr.mat','content_save');
%% 计算平均指标
%SSIM
[~,sz] = size(SSIM_bic);
ssim_bic = sum(SSIM_bic)/sz
ssim_vdsr = sum(SSIM_vdsr)/sz
%PSNR
[~,sz] = size(PSNR_bic);
psnr_bic = sum(PSNR_bic)/sz
psnr_vdsr = sum(PSNR_vdsr)/sz
%OCR
% OCR=(count-num)/count
count=count+2;            %由于125这张图片的标注问题，会导致matlab和c两种算OCR的方法之间差两个字符，因为之前都是用C，为了结果的统一性，这里做个+2的小调整
num=num+2;                %由于125这张图片的标注问题，会导致matlab和c两种算OCR的方法之间差两个字符，因为之前都是用C，为了结果的统一性，这里做个+2的小调整
OCR=(count-num)/count
toc;