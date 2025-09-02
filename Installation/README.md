# ROS2/ROS Installation Guide

This section provides installation instructions for ROS and ROS2, organized by distribution.

## ROS Installation (ROS1)

### ROS Noetic (Ubuntu 20.04)
1. Setup sources:
   ```bash
   sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
   sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
   sudo apt update
   ```
2. Install ROS Noetic:
   ```bash
   sudo apt install ros-noetic-desktop-full
   ```
3. Initialize rosdep:
   ```bash
   sudo rosdep init
   rosdep update
   ```
4. Environment setup:
   ```bash
   echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```

### ROS Melodic (Ubuntu 18.04)
Follow similar steps as above, replacing `noetic` with `melodic`.

## ROS2 Installation

### ROS2 Humble (Ubuntu 22.04)
1. Setup sources:
   ```bash
   sudo apt update && sudo apt install curl gnupg lsb-release
   sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
   sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros2-latest.list'
   sudo apt update
   ```
2. Install ROS2 Humble:
   ```bash
   sudo apt install ros-humble-desktop
   ```
3. Environment setup:
   ```bash
   echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```

### ROS2 Foxy (Ubuntu 20.04)
Follow similar steps as above, replacing `humble` with `foxy`.

---
For more details, refer to the [official ROS installation guide](https://wiki.ros.org/ROS/Installation) and [ROS2 installation guide](https://docs.ros.org/en/ros2_documentation/index.html).
