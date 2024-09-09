# Use NVIDIA's official CUDA base image (Ubuntu 22.04, CUDA 11.x)
FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu22.04

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Update the system and install essential dependencies
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    software-properties-common \
    build-essential \
    git \
    locales \
    && locale-gen en_US en_US.UTF-8 \
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Setup ROS 2 Humble repository
RUN  apt update &&  apt install -y curl gnupg2 lsb-release && \
    curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc |  apt-key add - && \
     sh -c 'echo "deb [trusted=yes] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'

# Install ROS 2 Humble (Desktop Full Installation)
RUN apt-get update && apt-get install -y \
    ros-humble-desktop \
    python3-rosdep2

RUN apt-get install -y \
    python3-colcon-common-extensions \
    python3-vcstool

# Initialize rosdep
# RUN rosdep init
RUN rosdep update

# Source ROS 2 setup file
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

# Install x11 dependencies for GUI applications
RUN apt-get install -y libgl1-mesa-glx libxrender1 libxext6 libxtst6


# Set the default command to run when starting the container
CMD ["/bin/bash"]
