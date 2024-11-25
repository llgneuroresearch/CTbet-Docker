#! /bin/sh

# This script is used to run inference on a trained model.

nnUNetv2_install_pretrained_model_from_zip /assets/nnUNetv2_pretrained_model.zip

for file in /input/*; do
    if [ "${file##*_}" != "0000.nii.gz" ]; then
        mv "$file" "${file%.nii.gz}_0000.nii.gz"
    fi
done

nnUNetv2_predict -i /input -o /output/results -d 001 -c 3d_fullres -f all $@
