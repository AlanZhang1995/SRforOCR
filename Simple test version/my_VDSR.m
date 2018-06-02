%%%%%%function serve for 'split1_process_master.m'%%%%%%%%
function im_h=my_VDSR(net,im)
%% input image preprocess
im = im2double(im);
%% preparing input data
[row, col] = size(im);
im_data = zeros(row, col, 1, 1);
im_data(:, :, 1, 1) = im;

im_data = permute(im_data, [2, 1, 3, 4]);
[width, height, ~, ~] = size(im_data);

label_width = width;
label_height = height;
im_label = zeros(label_width, label_height, 1, 1);
%% shape the input layer
net.blobs('data').reshape([width height 1 1]); % reshape blob 'data'
net.blobs('label').reshape([label_width label_height 1 1]); % reshape blob 'label'
net.reshape();
%% forward
loss = net.forward({im_data, im_label});
%% exact the result of VDSR
conv3_feat = net.blobs('res').get_data();
%% get the hr image
im_h = uint8(conv3_feat(:, :, 1)' * 255);