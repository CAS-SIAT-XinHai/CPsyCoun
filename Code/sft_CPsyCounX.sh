#!/usr/bin/env bash
WORK_DIR=$(dirname $(dirname $(readlink -f $0)))
echo "${WORK_DIR}"
UUID=$(uuidgen)
echo "${UUID}"

MODEL=$1
MODEL_NAME_OR_PATH=$2
DATASET=$3

OUTPUT_DIR="${WORK_DIR}"/output/${UUID}

# InternLM2-7B-Chat  intern2, wqkv

TEMPLATE="default"
LORA_TARGET="q_proj,v_proj"

if [[ $MODEL == InternLM2-7B-Chat ]]; then
  TEMPLATE="intern2"
  LORA_TARGET="wqkv"
else
  echo "$MODEL is not supported"
  exit
fi

mkdir -p "${OUTPUT_DIR}"
log_file="${OUTPUT_DIR}"/logs.txt
exec &> >(tee -a "$log_file")

GPU_VIS=0,1,2,3
MASTER_PORT=2345
deepspeed  --include localhost:$GPU_VIS --master_port $MASTER_PORT $WORK_DIR/src/train_bash.py \
    --deepspeed ds_config.json \
    --stage sft \
    --model_name_or_path "${MODEL_NAME_OR_PATH}" \
    --do_train \
    --dataset "$DATASET" \
    --template "$TEMPLATE" \
    --finetuning_type full \
    --lora_target "$LORA_TARGET" \
    --output_dir "${OUTPUT_DIR}" \
    --overwrite_cache \
    --overwrite_output_dir \
    --per_device_train_batch_size 4 \
    --gradient_accumulation_steps 28 \
    --lr_scheduler_type cosine \
    --logging_steps 10 \
    --save_steps 21 \
    --learning_rate 1e-6 \
    --num_train_epochs 9.0 \
    --plot_loss \
    --fp16