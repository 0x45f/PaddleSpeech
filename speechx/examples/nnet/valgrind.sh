#!/bin/bash

# this script is for memory check, so please run ./run.sh first.

set +x
set -e

if [ ! -d ../../tools/valgrind/install ]; then
  echo "please install valgrind in the speechx tools dir.\n" 
  exit 1
fi

. ../path.sh

model_dir=../paddle_asr_model

valgrind --tool=memcheck --track-origins=yes --leak-check=full --show-leak-kinds=all pp-model-test --model_path=$model_dir/avg_1.jit.pdmodel --param_path=$model_dir/avg_1.jit.pdparams

