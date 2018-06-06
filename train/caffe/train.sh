#!/bin/bash
CAFFE_BIN=/home/zhc/caffe/build/tools/caffe
solver_path=./VDSR_solver.prototxt
$CAFFE_BIN train -solver=$solver_path  -gpu 1 2>&1|tee ./loss.log
