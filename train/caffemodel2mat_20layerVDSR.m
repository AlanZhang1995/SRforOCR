% %% Load the Caffe.Net and save in model file.
% clear; 
% close all;
% caffe.reset_all();
% caffe.set_mode_cpu();
% 
% net_dir = 'D:\\CNN\\CAFFE_VDSR\\VDSR\\';
% net_structure = [net_dir 'VDSR_mat.prototxt'];
% net_params = [net_dir '_iter_8240.caffemodel'];
% phase = 'test';
% 
% % Initialize a network
% net = caffe.Net(net_structure, net_params, phase);
% 
% % def = 'D:\\CNN\\CAFFE_VDSR\\VDSR\\VDSR_net.prototxt';% ������_netֻ����_mat!!!!!!!!!!!!!!
% % net = 'D:\\CNN\\CAFFE_VDSR\\VDSR\\_iter_8240.caffemodel';
% % ConvNet = caffe.Net(def, net, 'test');
% save model/ConvNet ConvNet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%layers�е�parameter(1)��ʾȨ�ز���,parameter(2)��ʾƫ�ò���
%������ṹ�г�ȡȨ�غ�ƫ�þ��󣬲����б���?
caffe.reset_all();%����Ѿ�����������solver�Ͷ���net;
clear; close all;

layers = 20;                    %�ָ�
savepath = '20VDSR.mat';
%net_dir = 'D:\CNN\CAFFE_VDSR\VDSR\20VDSR\\';
net_dir = './caffe/';
net_structure = [net_dir 'VDSR_mat.prototxt'];
%net_params = [net_dir 'VDSR_Anchor_iter_38480'];
net_params = ['VDSR_Anchor_iter_38480.caffemodel'];
phase = 'test';

% Initialize a network
net = caffe.Net(net_structure, net_params, phase);

%% reshap parameters
weights_conv = cell(layers,1);

for idx = 1 : layers
      conv_filters = net.layers(['conv' num2str(idx)]).params(1).get_data();
      [~,fsize,channel,fnum] = size(conv_filters);


     if channel == 1
            weights = single(ones(fsize^2, fnum ));
     else
            weights = single(ones(channel, fsize^2, fnum));
     end

     for i = 1 : channel
            for j = 1 : fnum
                   temp = conv_filters(:,:,i,j);
                   if channel == 1
                       weights(:,j) = temp(:);
                   else
                       weights(i,:,j) = temp(:);
                   end
            end
     end


     weights_conv{idx} = weights;
end





%% save parameters
weights_conv1 = weights_conv{1};
weights_conv2 = weights_conv{2};
weights_conv3 = weights_conv{3};
weights_conv4 = weights_conv{4};
weights_conv5 = weights_conv{5};
weights_conv6 = weights_conv{6};
weights_conv7 = weights_conv{7};
weights_conv8 = weights_conv{8};
weights_conv9 = weights_conv{9};
weights_conv10 = weights_conv{10};
weights_conv11 = weights_conv{11};
weights_conv12 = weights_conv{12};
weights_conv13 = weights_conv{13};
weights_conv14 = weights_conv{14};
weights_conv15 = weights_conv{15};
weights_conv16 = weights_conv{16};
weights_conv17 = weights_conv{17};
weights_conv18 = weights_conv{18};
weights_conv19 = weights_conv{19};
weights_conv20 = weights_conv{20};
biases_conv1 = net.layers('conv1').params(2).get_data();
biases_conv2 = net.layers('conv2').params(2).get_data();
biases_conv3 = net.layers('conv3').params(2).get_data();
biases_conv4 = net.layers('conv4').params(2).get_data();
biases_conv5 = net.layers('conv5').params(2).get_data();
biases_conv6 = net.layers('conv6').params(2).get_data();
biases_conv7 = net.layers('conv7').params(2).get_data();
biases_conv8 = net.layers('conv8').params(2).get_data();
biases_conv9 = net.layers('conv9').params(2).get_data();
biases_conv10 = net.layers('conv10').params(2).get_data();
biases_conv11 = net.layers('conv11').params(2).get_data();
biases_conv12 = net.layers('conv12').params(2).get_data();
biases_conv13 = net.layers('conv13').params(2).get_data();
biases_conv14 = net.layers('conv14').params(2).get_data();
biases_conv15 = net.layers('conv15').params(2).get_data();
biases_conv16 = net.layers('conv16').params(2).get_data();
biases_conv17 = net.layers('conv17').params(2).get_data();
biases_conv18 = net.layers('conv18').params(2).get_data();
biases_conv19 = net.layers('conv19').params(2).get_data();
biases_conv20 = net.layers('conv20').params(2).get_data();

save(savepath,'weights_conv1','biases_conv1','weights_conv2','biases_conv2','weights_conv3','biases_conv3','weights_conv4','biases_conv4','weights_conv5','biases_conv5','weights_conv6','biases_conv6','weights_conv7','biases_conv7','weights_conv8','biases_conv8','weights_conv9','biases_conv9','weights_conv10','biases_conv10','weights_conv11','biases_conv11','weights_conv12','biases_conv12','weights_conv13','biases_conv13','weights_conv14','biases_conv14','weights_conv15','biases_conv15','weights_conv16','biases_conv16','weights_conv17','biases_conv17','weights_conv18','biases_conv18','weights_conv19','biases_conv19','weights_conv20','biases_conv20');