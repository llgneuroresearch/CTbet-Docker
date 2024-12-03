# CTbet-Docker
Docker container for CT brain extraction based on nnU-Net, a self-configuring method for medical image segmentation.

The Dockerfile sets up an environment for running NNUNETV2 with PyTorch and CUDA support. It includes the necessary dependencies and configurations for NNUNETV2.

## Instructions

> [!NOTE]  
> Before using the following command lines. Docker and nvidia-container-toolkit must be installed. (`sudo apt install -y docker.io nvidia-container-toolkit` or `sudo apt install -y docker.io nvidia-docker2`)


### Building the Docker Image Manually

To build the Docker image, run the following command in the directory containing the Dockerfile:

```
docker build -t ctbet:latest .
```

### Pulling the Docker Image from DockerHub

To pull the Docker image, run the following command:

```
docker pull avnirlab/ctbet:<tag>
```

1. Every time main branch is updated, the CICD build the Dockerfile and push the image to Dockerhub with latest tag (avnirlab/ctbet:latest).
2. Every time a new tag is created, the CICD build the Dockerfile and push the image to Dockerhub with tag name (e.g. avnirlab/ctbet:1.0.0).

### Run inference

After building or pulling the Docker image, you can run inference on your nifti images.

> [!IMPORTANT]  
> If you want to run the inference using CUDA, please use NVIDIA driver 560 or higher and CUDA 12.6 or higher.

- Input

The input consists into a directory containing all your CT scans in Nifti format. Nifti files does not required a specific filename.

- Output

Create an output folder where the CT scans without the skull will be saved.

- Command line

To run the inference, run the following command:

```
docker run -ti -v PATH_TO_INPUT:/input -v PATH_TO_OUTPUT:/output -u 0:$(id -g) --gpus all --rm --shm-size 2g avnirlab/ctbet:latest -device cuda
```

PATH_TO_INPUT and PATH_TO_OUTPUT must be absolute paths. If you want to run the inference on CPU, change `cuda` to `cpu` in the previous command line.