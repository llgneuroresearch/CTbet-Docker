FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-devel

# Install NNUNETV2
RUN apt update && apt install -y git
RUN pip install nnunetv2==2.4.1
RUN pip install --upgrade git+https://github.com/FabianIsensee/hiddenlayer.git
RUN pip install blosc2 acvl_utils==0.2
COPY assets /assets
RUN mkdir /input /output
WORKDIR /output
ENV nnUNet_results=/assets
ENV nnUNet_raw=/assets
ENV nnUNet_preprocessed=/assets

ENTRYPOINT [ "bash", "/assets/inference.sh" ]