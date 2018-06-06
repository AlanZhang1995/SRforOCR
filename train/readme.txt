'caffe' fold contains necessary files to train our edge weighted SR network and you need to do following steps to run it
1. adapt caffe_path in 'train.sh'
2. adapt hdf5_path in 'VDSR_net.prototxt'
3. adapt net_path and snapshot_path in 'VDSR_solver.prototxt'
4. write your train.txt and validation.txt

you can use code in 'traindata' to generate your own training dataset. Please:
1. adapt input_image_path 'folder_lr' and 'folder_lr'
2. adapt hdf5_save_path 'folder_lr' and 'savepath1'