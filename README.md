# SRforOCR
CNN-based Text Image Super Resolution Tailored for OCR(VCIP2017)


License and Citation
====================

All code is provided for research purposes only and without any warranty. Any commercial use requires our consent. When using the code in your research work, please cite the following paper:

    @inproceedings{zhang2017cnn,
     title={CNN-based text image super-resolution tailored for OCR},
     author={Zhang, Haochen and Liu, Dong and Xiong, Zhiwei},
     booktitle={Visual Communications and Image Processing (VCIP), 2017 IEEE},
     pages={1--4},
     year={2017},
     organization={IEEE}
    }

Foreword
=========

This code is based on Caffe and please ensure caffe is installed correctly in your computer.


Simple test version
=======

This is a lite code which you can use as an example to perform super-resolution on your own image and in this part we also provide our well-trainded model mentioned in the paper. 


Training
========

We provide all the files used for training the edge weighted SR network in this part.

The 'caffe' fold contains necessary files to train our edge weighted SR network and you need to do following steps to run it
1. adapt caffe_path in 'train.sh'
2. adapt hdf5_path in 'VDSR_net.prototxt'
3. adapt net_path and snapshot_path in 'VDSR_solver.prototxt'
4. generate the training hdf5 files yourself and write your train.txt and validation.txt

You can use code in 'traindata' to generate your own training dataset. Please:
1. adapt input_image_path 'folder_lr' and 'folder_hr'
2. adapt hdf5_save_path 'savepath1'

Testing
========

We provide all the testing code including SR image producing, PSNR and OCR accuracy calculation as well as implement of proposed padding method in this part.

To run these codes, please:
1. adapt 'path_set' part in 'main.m'
2. build your tesseract correctly.
3. choose 'my_VDSR_Ver1' function to perform SR without padding and 'my_VDSR_Ver2' with proposed paddding method
