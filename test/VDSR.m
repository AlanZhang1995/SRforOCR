function im_h = VDSR(model, im_b)

%% load CNN model parameters
load(model);
[conv1_patchsize2,conv1_filters] = size(weights_conv1);
conv1_patchsize = sqrt(conv1_patchsize2);
[conv2_channels,conv2_patchsize2,conv2_filters] = size(weights_conv2);
conv2_patchsize = sqrt(conv2_patchsize2);
[conv3_channels,conv3_patchsize2,conv3_filters] = size(weights_conv3);
conv3_patchsize = sqrt(conv3_patchsize2);
[conv4_channels,conv4_patchsize2,conv4_filters] = size(weights_conv4);
conv4_patchsize = sqrt(conv4_patchsize2);
[conv5_channels,conv5_patchsize2,conv5_filters] = size(weights_conv5);
conv5_patchsize = sqrt(conv5_patchsize2);
[conv6_channels,conv6_patchsize2,conv6_filters] = size(weights_conv6);
conv6_patchsize = sqrt(conv6_patchsize2);
[conv7_channels,conv7_patchsize2,conv7_filters] = size(weights_conv7);
conv7_patchsize = sqrt(conv7_patchsize2);
[conv8_channels,conv8_patchsize2,conv8_filters] = size(weights_conv8);
conv8_patchsize = sqrt(conv8_patchsize2);
[conv9_channels,conv9_patchsize2,conv9_filters] = size(weights_conv9);
conv9_patchsize = sqrt(conv9_patchsize2);
[conv10_channels,conv10_patchsize2,conv10_filters] = size(weights_conv10);
conv10_patchsize = sqrt(conv10_patchsize2);
[conv11_channels,conv11_patchsize2,conv11_filters] = size(weights_conv11);
conv11_patchsize = sqrt(conv11_patchsize2);
[conv12_channels,conv12_patchsize2,conv12_filters] = size(weights_conv12);
conv12_patchsize = sqrt(conv12_patchsize2);
[conv13_channels,conv13_patchsize2,conv13_filters] = size(weights_conv13);
conv13_patchsize = sqrt(conv13_patchsize2);
[conv14_channels,conv14_patchsize2,conv14_filters] = size(weights_conv14);
conv14_patchsize = sqrt(conv14_patchsize2);
[conv15_channels,conv15_patchsize2,conv15_filters] = size(weights_conv15);
conv15_patchsize = sqrt(conv15_patchsize2);
[conv16_channels,conv16_patchsize2,conv16_filters] = size(weights_conv16);
conv16_patchsize = sqrt(conv16_patchsize2);
[conv17_channels,conv17_patchsize2,conv17_filters] = size(weights_conv17);
conv17_patchsize = sqrt(conv17_patchsize2);
[conv18_channels,conv18_patchsize2,conv18_filters] = size(weights_conv18);
conv18_patchsize = sqrt(conv18_patchsize2);
[conv19_channels,conv19_patchsize2,conv19_filters] = size(weights_conv19);
conv19_patchsize = sqrt(conv19_patchsize2);
[conv20_channels,conv20_patchsize2] = size(weights_conv20);
conv20_patchsize = sqrt(conv20_patchsize2);
[hei, wid] = size(im_b);

%% conv1
weights_conv1 =double(reshape(weights_conv1, conv1_patchsize, conv1_patchsize, conv1_filters));
conv1_data = zeros(hei, wid, conv1_filters);
for i = 1 : conv1_filters
    conv1_data(:,:,i) = imfilter(im_b, weights_conv1(:,:,i)', 'same', 'replicate');
    conv1_data(:,:,i) = max(conv1_data(:,:,i) + biases_conv1(i), 0);
end

%% conv2
conv2_data = zeros(hei, wid, conv2_filters);
for i = 1 : conv2_filters
    for j = 1 : conv2_channels
        conv2_subfilter= reshape(double(weights_conv2(j,:,i)), conv2_patchsize, conv2_patchsize);
        conv2_data(:,:,i) = conv2_data(:,:,i) + imfilter(conv1_data(:,:,j), conv2_subfilter', 'same', 'replicate');
    end
    conv2_data(:,:,i) = max(conv2_data(:,:,i) + biases_conv2(i), 0);

end

%% conv3
conv3_data = zeros(hei, wid, conv3_filters);
for i = 1 : conv3_filters
    for j = 1 : conv3_channels
        conv3_subfilter = reshape(double(weights_conv3(j,:,i)), conv3_patchsize, conv3_patchsize);
        conv3_data(:,:,i) = conv3_data(:,:,i) + imfilter(conv2_data(:,:,j), conv3_subfilter', 'same', 'replicate');
    end
    conv3_data(:,:,i) = max(conv3_data(:,:,i) + biases_conv3(i), 0);

end

%% conv4
conv4_data = zeros(hei, wid, conv4_filters);
for i = 1 : conv4_filters
    for j = 1 : conv4_channels
        conv4_subfilter = reshape(double(weights_conv4(j,:,i)), conv4_patchsize, conv4_patchsize);
        conv4_data(:,:,i) = conv4_data(:,:,i) + imfilter(conv3_data(:,:,j), conv4_subfilter', 'same', 'replicate');
    end
    conv4_data(:,:,i) = max(conv4_data(:,:,i) + biases_conv4(i), 0);

end

%% conv5
conv5_data = zeros(hei, wid, conv5_filters);
for i = 1 : conv5_filters
    for j = 1 : conv5_channels
        conv5_subfilter = reshape(double(weights_conv5(j,:,i)), conv5_patchsize, conv5_patchsize);
        conv5_data(:,:,i) = conv5_data(:,:,i) + imfilter(conv4_data(:,:,j), conv5_subfilter', 'same', 'replicate');
    end
    conv5_data(:,:,i) = max(conv5_data(:,:,i) + biases_conv5(i), 0);

end

%% conv6
conv6_data = zeros(hei, wid, conv6_filters);
for i = 1 : conv6_filters
    for j = 1 : conv6_channels
        conv6_subfilter = reshape(double(weights_conv6(j,:,i)), conv6_patchsize, conv6_patchsize);
        conv6_data(:,:,i) = conv6_data(:,:,i) + imfilter(conv5_data(:,:,j), conv6_subfilter', 'same', 'replicate');
    end
    conv6_data(:,:,i) = max(conv6_data(:,:,i) + biases_conv6(i), 0);

end

%% conv7
conv7_data = zeros(hei, wid, conv7_filters);
for i = 1 : conv7_filters
    for j = 1 : conv7_channels
        conv7_subfilter = reshape(double(weights_conv7(j,:,i)), conv7_patchsize, conv7_patchsize);
        conv7_data(:,:,i) = conv7_data(:,:,i) + imfilter(conv6_data(:,:,j), conv7_subfilter', 'same', 'replicate');

    end
    conv7_data(:,:,i) = max(conv7_data(:,:,i) + biases_conv7(i), 0);

end

%% conv8
conv8_data = zeros(hei, wid, conv8_filters);
for i = 1 : conv8_filters
    for j = 1 : conv8_channels
        conv8_subfilter = reshape(double(weights_conv8(j,:,i)), conv8_patchsize, conv8_patchsize);
        conv8_data(:,:,i) = conv8_data(:,:,i) + imfilter(conv7_data(:,:,j), conv8_subfilter', 'same', 'replicate');
    end
    conv8_data(:,:,i) = max(conv8_data(:,:,i) + biases_conv8(i), 0);

end

%% conv9
conv9_data = zeros(hei, wid, conv9_filters);
for i = 1 : conv9_filters
    for j = 1 : conv9_channels
        conv9_subfilter = reshape(double(weights_conv9(j,:,i)), conv9_patchsize, conv9_patchsize);
        conv9_data(:,:,i) = conv9_data(:,:,i) + imfilter(conv8_data(:,:,j), conv9_subfilter', 'same', 'replicate');
    end
    conv9_data(:,:,i) = max(conv9_data(:,:,i) + biases_conv9(i), 0);

end

%% conv10
conv10_data = zeros(hei, wid, conv10_filters);
for i = 1 : conv10_filters
    for j = 1 : conv10_channels
        conv10_subfilter = reshape(double(weights_conv10(j,:,i)), conv10_patchsize, conv10_patchsize);
        conv10_data(:,:,i) = conv10_data(:,:,i) + imfilter(conv9_data(:,:,j), conv10_subfilter', 'same', 'replicate');
    end
    conv10_data(:,:,i) = max(conv10_data(:,:,i) + biases_conv10(i), 0);

end

%% conv11
conv11_data = zeros(hei, wid, conv11_filters);
for i = 1 : conv11_filters
    for j = 1 : conv11_channels
        conv11_subfilter = reshape(double(weights_conv11(j,:,i)), conv11_patchsize, conv11_patchsize);
        conv11_data(:,:,i) = conv11_data(:,:,i) + imfilter(conv10_data(:,:,j), conv11_subfilter', 'same', 'replicate');
    end
    conv11_data(:,:,i) = max(conv11_data(:,:,i) + biases_conv11(i), 0);

end

%% conv12
conv12_data = zeros(hei, wid, conv12_filters);
for i = 1 : conv12_filters
    for j = 1 : conv12_channels
        conv12_subfilter = reshape(double(weights_conv12(j,:,i)), conv12_patchsize, conv12_patchsize);
        conv12_data(:,:,i) = conv12_data(:,:,i) + imfilter(conv11_data(:,:,j), conv12_subfilter', 'same', 'replicate');
    end
    conv12_data(:,:,i) = max(conv12_data(:,:,i) + biases_conv12(i), 0);
end

%% conv13
conv13_data = zeros(hei, wid, conv13_filters);
for i = 1 : conv13_filters
    for j = 1 : conv13_channels
        conv13_subfilter = reshape(double(weights_conv13(j,:,i)), conv13_patchsize, conv13_patchsize);
        conv13_data(:,:,i) = conv13_data(:,:,i) + imfilter(conv12_data(:,:,j), conv13_subfilter', 'same', 'replicate');
    end
    conv13_data(:,:,i) = max(conv13_data(:,:,i) + biases_conv13(i), 0);

end

%% conv14
conv14_data = zeros(hei, wid, conv14_filters);
for i = 1 : conv14_filters
    for j = 1 : conv14_channels
        conv14_subfilter = reshape(double(weights_conv14(j,:,i)), conv14_patchsize, conv14_patchsize);
        conv14_data(:,:,i) = conv14_data(:,:,i) + imfilter(conv13_data(:,:,j), conv14_subfilter', 'same', 'replicate');
    end
     conv14_data(:,:,i) = max(conv14_data(:,:,i) + biases_conv14(i), 0);

end

%% conv15
conv15_data = zeros(hei, wid, conv15_filters);
for i = 1 : conv15_filters
    for j = 1 : conv15_channels
        conv15_subfilter = reshape(double(weights_conv15(j,:,i)), conv15_patchsize, conv15_patchsize);
        conv15_data(:,:,i) = conv15_data(:,:,i) + imfilter(conv14_data(:,:,j), conv15_subfilter', 'same', 'replicate');
    end
     conv15_data(:,:,i) = max(conv15_data(:,:,i) + biases_conv15(i), 0);

end

%% conv16
conv16_data = zeros(hei, wid, conv16_filters);
for i = 1 : conv16_filters
    for j = 1 : conv16_channels
        conv16_subfilter = reshape(double(weights_conv16(j,:,i)), conv16_patchsize, conv16_patchsize);
        conv16_data(:,:,i) = conv16_data(:,:,i) + imfilter(conv15_data(:,:,j), conv16_subfilter', 'same', 'replicate');
    end
     conv16_data(:,:,i) = max(conv16_data(:,:,i) + biases_conv16(i), 0);
end

%% conv17
conv17_data = zeros(hei, wid, conv17_filters);
for i = 1 : conv17_filters
    for j = 1 : conv17_channels
        conv17_subfilter = reshape(double(weights_conv17(j,:,i)), conv17_patchsize, conv17_patchsize);
        conv17_data(:,:,i) = conv17_data(:,:,i) + imfilter(conv16_data(:,:,j), conv17_subfilter', 'same', 'replicate');
    end
     conv17_data(:,:,i) = max(conv17_data(:,:,i) + biases_conv17(i), 0);

end

%% conv18
conv18_data = zeros(hei, wid, conv18_filters);
for i = 1 : conv18_filters
    for j = 1 : conv18_channels
        conv18_subfilter = reshape(double(weights_conv18(j,:,i)), conv18_patchsize, conv18_patchsize);
        conv18_data(:,:,i) = conv18_data(:,:,i) + imfilter(conv17_data(:,:,j), conv18_subfilter', 'same', 'replicate');
    end
    conv18_data(:,:,i) = max(conv18_data(:,:,i) + biases_conv18(i), 0);

end

%% conv19
conv19_data = zeros(hei, wid, conv19_filters);
for i = 1 : conv19_filters
    for j = 1 : conv19_channels
        conv19_subfilter = reshape(double(weights_conv19(j,:,i)), conv19_patchsize, conv19_patchsize);
        conv19_data(:,:,i) = conv19_data(:,:,i) + imfilter(conv18_data(:,:,j), conv19_subfilter', 'same', 'replicate');
    end
    conv19_data(:,:,i) = max(conv19_data(:,:,i) + biases_conv19(i), 0);

end

%% conv20
conv20_data = zeros(hei, wid);
for i = 1 : conv20_channels
    conv20_subfilter = reshape(double(weights_conv20(i,:)), conv20_patchsize, conv20_patchsize);
    conv20_data(:,:) = conv20_data(:,:) + imfilter(conv19_data(:,:,i), conv20_subfilter', 'same', 'replicate');
end

%% VDSR reconstruction
im_h = conv20_data(:,:) + biases_conv20;