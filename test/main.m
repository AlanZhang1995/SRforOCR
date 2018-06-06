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
img_path_list1 = dir(strcat(file_path1,'*.pgm'));%��ȡ���ļ���������pgm��ʽ��ͼ�� 
img_path_list2 = dir(strcat(file_path2,'*.pgm'));%��ȡ���ļ���������pgm��ʽ��ͼ��  
path_list3=dir(strcat(file_path3,'*.txt'));

num=0;
count=0;
PSNR_bic=[];%PSNR
PSNR_vdsr=[];
SSIM_bic=[];%SSIM
SSIM_vdsr=[];

img_num = length(img_path_list1);%��ȡͼ��������  
if img_num > 0 %������������ͼ��  
        for j = 1 : img_num  %��һ��ȡͼ��
            image_name = img_path_list1(j).name;% ͼ����  
            im  =   imread(strcat(file_path1,image_name)); 
            [im_b,im_h]  = my_VDSR_Ver1(im,model);%��VDSR�ؽ�
%             [im_b,im_h]  = my_VDSR_Ver2(im,model);%��VDSR�ؽ�(padding)
             imwrite(im_h,[output_path,image_name]);
%             imwrite(im_b,['D:\CNN\ICDAR2015-TextSR-dataset\RELEASE_2015-08-31\DATA\TEST\LR\VDSR_result\',image_name]);
             im_hr  =   imread(strcat(file_path2,img_path_list2(j).name));
           %% ��������ָ��
             %PSNR
             [psnr_bic,psnr_vdsr]=my_SRCNN_PSNR(im_b,im_h,im_hr);
             PSNR_bic=[PSNR_bic,psnr_bic];
             PSNR_vdsr=[PSNR_vdsr,psnr_vdsr];
             %SSIM
             [ssim_bic,~]=ssim(im_b, im_hr);
             [ssim_vdsr,~]=ssim(im_h, im_hr);
             SSIM_bic=[SSIM_bic,ssim_bic];
             SSIM_vdsr=[SSIM_vdsr,ssim_vdsr];
             
            %OCR��ȷ��
            name = path_list3(j).name;
            fileID1 = fopen(strcat(file_path3,name));
            annotation = fgetl(fileID1); %��ע
            count=count+length(annotation);
            fclose(fileID1);
            [ocr,ocr_content]=auto_ocr(annotation,im_h);%������
            content_save(j).content=ocr_content;
            num=num+ocr;
            
            
           
%            %% ����������� 
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
              j %�鿴����

        end  
end  
fprintf('MISSION COMPLAIN\n');
%% ����ָ��
save('20VDSR_pnsr.mat','PSNR_bic','PSNR_vdsr');
save('20VDSR_ssim.mat','SSIM_bic','SSIM_vdsr');
save('20VDSR_mse.mat','MSE_bic','MSE_vdsr');
save('20VDSR_ocr.mat','content_save');
%% ����ƽ��ָ��
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
count=count+2;            %����125����ͼƬ�ı�ע���⣬�ᵼ��matlab��c������OCR�ķ���֮��������ַ�����Ϊ֮ǰ������C��Ϊ�˽����ͳһ�ԣ���������+2��С����
num=num+2;                %����125����ͼƬ�ı�ע���⣬�ᵼ��matlab��c������OCR�ķ���֮��������ַ�����Ϊ֮ǰ������C��Ϊ�˽����ͳһ�ԣ���������+2��С����
OCR=(count-num)/count
toc;