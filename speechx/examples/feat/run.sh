#!/bin/bash
set +x
set -e

. ./path.sh

# 1. compile
if [ ! -d ${SPEECHX_EXAMPLES} ]; then
    pushd ${SPEECHX_ROOT} 
    bash build.sh
    popd
fi

# 2. download model
if [ ! -d ../paddle_asr_model ]; then
    wget https://paddlespeech.bj.bcebos.com/s2t/paddle_asr_online/paddle_asr_model.tar.gz
    tar xzfv paddle_asr_model.tar.gz
    mv ./paddle_asr_model ../
    # produce wav scp
    echo "utt1 " $PWD/../paddle_asr_model/BAC009S0764W0290.wav > ../paddle_asr_model/wav.scp
fi

model_dir=../paddle_asr_model
feat_wspecifier=./feats.ark
cmvn=./cmvn.ark

# 3. run feat
linear_spectrogram_main \
    --wav_rspecifier=scp:$model_dir/wav.scp \
    --feature_wspecifier=ark,t:$feat_wspecifier \
    --cmvn_write_path=$cmvn
