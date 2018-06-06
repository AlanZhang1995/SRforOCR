clear;close all;
%% settings
folder_lr = 'D:\\CNN\\ICDAR2015-TextSR-dataset\\RELEASE_2015-08-31\\DATA\\TRAIN\\LR\\validation';
folder_hr = 'D:\\CNN\\ICDAR2015-TextSR-dataset\\RELEASE_2015-08-31\\DATA\\TRAIN\\HR\\validation';
savepath1 = 'train20_validation.h5';
% folder_lr = 'D:\\CNN\\ICDAR2015-TextSR-dataset\\RELEASE_2015-08-31\\DATA\\TRAIN\\LR';
% folder_hr = 'D:\\CNN\\ICDAR2015-TextSR-dataset\\RELEASE_2015-08-31\\DATA\\TRAIN\\HR';
savepath1 = 'train20_train.h5';

size_im =18;  %hr最小高度
receptive_field=18;%感受野
% receptive_field=41;%感受野
stride_hei = 2;
stride_wid = 5;
up_scale = 2;

%% initialization
data = zeros(receptive_field, receptive_field, 1, 1);
label = zeros(receptive_field, receptive_field, 2, 1);%two channel，one for label, the other for edge
padding = round(abs(receptive_field - size_im)/2)+1;
% padding = round(abs(receptive_field - size_im)/2);
count = 0;


%% generate data
filepaths_input = dir(fullfile(folder_lr,'*.pgm'));
filepaths_label = dir(fullfile(folder_hr,'*.pgm'));
    
for i = 1 : length(filepaths_label)
%     fullfile(folder_lr,['train-lr-',filepaths_label(i).name(end-7:end)])
%     fullfile(folder_hr,filepaths_label(i).name)
    im_input=imread(fullfile(folder_lr,['train-lr-',filepaths_label(i).name(end-7:end)]));
    im_input = imresize(im_input, up_scale, 'bicubic');
%    size(im_input)
    im_label=imread(fullfile(folder_hr,filepaths_label(i).name));
    im_sobel=sobel2_(im_label);   %去边缘，0值置1 [1,255]
    im_label=im2double(uint8(im_label));
    im_input=im2double(uint8(im_input));
    im_sobel=im2double(uint8(im_sobel));

    im_sobel = sqrt(im_sobel);%由于网络结构原因，有这句话为梯度加权，没有则为梯度平方加权(Due to the network structure, loss is weighted by the gradient with this sentence, and without this is weighted by gradient's square)
    [hei, wid] = size(im_label);
    
%      figure,imshow(im_label);
%      figure,imshow(im_input);
%      figure,imshow(im_sobel);

    for x = 1 : stride_hei : hei-size_im+1
        for y = 1 :stride_wid : wid-size_im+1
            subim_input=zeros(receptive_field);
            subim_label=zeros(receptive_field);
            subim_edge=zeros(receptive_field);
            temp = im_input(x : x+size_im-1, y : y+size_im-1);
            subim_input(padding:padding+size_im-1,padding:padding+size_im-1)=temp;
            temp = im_label(x : x+size_im-1, y : y+size_im-1);
            subim_label(padding:padding+size_im-1,padding:padding+size_im-1)=temp;
            temp = im_sobel(x : x+size_im-1, y : y+size_im-1);
            subim_edge(padding:padding+size_im-1,padding:padding+size_im-1)=temp;
            count=count+1;
            data(:, :, 1, count) = subim_input;
            label(:, :, 1, count) = subim_label;
            label(:, :, 2, count) = subim_edge;
%               figure,imshow(subim_label);
%               figure,imshow(subim_input);
%               figure,imshow(subim_edge);
        end
    end
end

%% writing to HDF5
chunksz = 64;%每次处理64个
created_flag = false;%第一次创建HDF5文件用false；之后在创建的HDF5文件后面续其他内容用true
totalct = 0;

for batchno = 1:floor(count/chunksz)
    last_read=(batchno-1)*chunksz;
    batchdata = data(:,:,1,last_read+1:last_read+chunksz); 
    batchlabs = label(:,:,1:2,last_read+1:last_read+chunksz);

    startloc = struct('dat',[1,1,1,totalct+1], 'lab', [1,1,1,totalct+1]);
    curr_dat_sz = store2hdf5(savepath1, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
    created_flag = true;%之后在创建的HDF5文件后面续其他内容用true
    totalct = curr_dat_sz(end);
end



%% 展示HDF5文件相关信息
h5disp(savepath1);

% 查看结果
data=h5read(savepath1,'/label');
figure,imshow(data(:,:,1,1));
figure,imshow(data(:,:,1,2));
figure,imshow(data(:,:,1,3));
figure,imshow(data(:,:,1,4));
figure,imshow(data(:,:,1,5));
figure,imshow(data(:,:,1,6));
figure,imshow(data(:,:,1,7));
figure,imshow(data(:,:,1,8));
figure,imshow(data(:,:,2,1));
figure,imshow(data(:,:,2,2));
figure,imshow(data(:,:,2,3));
figure,imshow(data(:,:,2,4));
figure,imshow(data(:,:,2,5));
figure,imshow(data(:,:,2,6));
figure,imshow(data(:,:,2,7));
figure,imshow(data(:,:,2,8));