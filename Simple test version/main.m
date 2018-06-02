caffe.reset_all();
%% caffe with GPU
% caffe.set_mode_cpu();
caffe.set_mode_gpu();
caffe.set_device(0);

net_dir = './';
net_structure = [net_dir , 'VDSR_mat.prototxt'];
% net_params1 =  'model1_trained_with_edge.caffemodel';
net_params1 =  'model2_trained_on_natural_image.caffemodel';
phase = 'test';
net1 = caffe.Net(net_structure, net_params1, phase);

% fileName = 'invoice1.png';
fileName = 'bill.png';
img = imread(fileName);
[hei,wid,ch]=size(img);
im_sr1=zeros(2*hei,2*wid,ch);
im=img(1:round(hei/2),1:round(wid/2),:);
im_sr1(1:round(hei/2)*2,1:round(wid/2)*2,:)=process_SR(net1,im);
im=img(round(hei/2)+1:end,1:round(wid/2),:);
im_sr1(round(hei/2)*2+1:end,1:round(wid/2)*2,:)=process_SR(net1,im);
im=img(1:round(hei/2),round(wid/2)+1:end,:);
im_sr1(1:round(hei/2)*2,round(wid/2)*2+1:end,:)=process_SR(net1,im);
im=img(round(hei/2)+1:end,round(wid/2)+1:end,:);
im_sr1(round(hei/2)*2+1:end,round(wid/2)*2+1:end,:)=process_SR(net1,im);

% imwrite(uint8(im_sr1),'invoice1_SR.png');
imwrite(uint8(im_sr1),'bill_SR.png');