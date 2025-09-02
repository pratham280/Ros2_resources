![ros mascot](https://live.staticflickr.com/4097/4787692791_03b2c7ee06.jpg)
# Robot Operating System (ROS/ROS2) Installation Guide

This guide provides installation instructions for various ROS and ROS2 distributions. Each section is dedicated to a specific version for clarity.

Covering only **Tier-1 Platform** as Mentioned in [REP 2000](https://www.ros.org/reps/rep-2000.html).



## Table of Contents
- [Prerequisites](#prerequisites)
   - [Set Locale](#set-locale)
   - [Adding Ubuntu Universe Repository](#adding-ubuntu-universe-repository)
   - [Getting Necessary Packages](#getting-necessary-packages)
- [ROS2 Installation](#ros2-installation)
   - [ROS2 Kilted Kaiju (Ubuntu 24.04)](#ros2-kilted-kaiju-ubuntu-2404)
   - [ROS2 Jazzy Jalisco (Ubuntu 24.04)](#ros2-jazzy-jalisco-ubuntu-2404)
   - [ROS2 Humble Hawksbill (Ubuntu 22.04)](#ros2-humble-hawksbill-ubuntu-2204)
   - [ROS2 Foxy Fitzroy (Ubuntu 20.04)](#ros2-foxy-fitzroy-ubuntu-2004)
- [ROS Installation](#ros-installation)
   - [ROS Noetic Ninjemys (Ubuntu 20.04)](#ros-noetic-ninjemys-ubuntu-2004)
   - [ROS Melodic Morenia (Ubuntu 18.04)](#ros-melodic-morenia-ubuntu-1804)
   - [ROS Kinetic Kame (Ubuntu 18.04)](#ros-kinetic-kame-ubuntu-1804)

## Prerequisites
### Set Locale
Make sure you have a locale which supports **UTF-8**. If you are in a minimal environment (such as a docker container), the locale may be something minimal like **POSIX**. We test with the following settings. However, it should be fine if you’re using a different UTF-8 supported locale
   ```bash
   locale  # check for UTF-8

   sudo apt update && sudo apt install locales
   
   sudo locale-gen en_US en_US.UTF-8
   sudo update-locale LC_ALL=en_US.UTF-8 
   
   LANG=en_US.UTF-8
   export LANG=en_US.UTF-8

   locale  # verify settings
   ```
### Adding Ubuntu Universe Repository
   ```bash
   sudo apt install software-properties-common

   sudo add-apt-repository universe
   ```
### Getting Necessary Packages
   ```bash
   sudo apt update && sudo apt install curl git -y
   ```
---
## ROS2 Installation

### <img src="https://docs.ros.org/en/humble/_images/kilted-small.png" alt="Humble" width="60" style="vertical-align:middle; border-radius:12px;"/>   ROS2 Kilted Kaiju (Ubuntu 24.04)
1. Setup sources:

   ```bash
   sudo apt update && sudo apt install curl gnupg lsb-release
   sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
   sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros2-latest.list'
   sudo apt update
   ```
2. Install ROS2 Galactic:

   ```bash
   sudo apt install ros-galactic-desktop
   ```
3. Environment setup:

   ```bash
   echo "source /opt/ros/kilted/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```
---
### <img src="https://docs.ros.org/en/humble/_images/jazzy-small.png" alt="Humble" width="60" style="vertical-align:middle; border-radius:12px;"/>   ROS2 Jazzy Jalisco (Ubuntu 24.04)
1. Setup sources:

   ```bash
   sudo apt update && sudo apt install curl gnupg lsb-release
   sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
   sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros2-latest.list'
   sudo apt update
   ```
2. Install ROS2 Galactic:
   ```bash
   sudo apt install ros-galactic-desktop
   ```
3. Environment setup:
   ```bash
   echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```
---

### <img src="https://docs.ros.org/en/humble/_images/humble-small.png" alt="Humble" width="60" style="vertical-align:middle; border-radius:12px;"/>  ROS2 Humble Hawksbill (Ubuntu 22.04)
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

---

### <img src="https://docs.ros.org/en/humble/_images/foxy-small.png" alt="Humble" width="60" style="vertical-align:middle; border-radius:12px;"/>   ROS2 Foxy Fitzroy (Ubuntu 20.04)
1. Setup sources:

   ```bash
   sudo apt update && sudo apt install curl gnupg lsb-release
   sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key | sudo apt-key add -
   sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://packages.ros.org/ros2/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros2-latest.list'
   sudo apt update
   ```
2. Install ROS2 Foxy:
   ```bash
   sudo apt install ros-foxy-desktop
   ```
3. Environment setup:
   ```bash
   echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```

---
## ROS Installation

### <img src="https://raw.githubusercontent.com/ros-infrastructure/artwork/master/distributions/noetic.png" alt="Noetic" width="60" style="vertical-align:middle; border-radius:12px;"/> ROS Noetic Ninjemys (Ubuntu 20.04)
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

---

### <img src="https://raw.githubusercontent.com/ros-infrastructure/artwork/master/distributions/melodic_with_bg.png" alt="Melodic" width="60" style="vertical-align:middle; border-radius:12px;"/> ROS Melodic Morenia (Ubuntu 18.04)
1. Setup sources:

   ```bash
   sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
   sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
   sudo apt update
   ```
2. Install ROS Melodic:
   ```bash
   sudo apt install ros-melodic-desktop-full
   ```
3. Initialize rosdep:
   ```bash
   sudo rosdep init
   rosdep update
   ```
4. Environment setup:
   ```bash
   echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```

---
### <img src="https://raw.githubusercontent.com/ros-infrastructure/artwork/master/distributions/kinetic.png" alt="Kinetic" width="70" style="vertical-align:middle; border-radius:12px;"/> ROS Kinetic Kame (Ubuntu 18.04)
1. Setup sources:

   ```bash
   sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
   sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
   sudo apt update
   ```
2. Install ROS Melodic:
   ```bash
   sudo apt install ros-melodic-desktop-full
   ```
3. Initialize rosdep:
   ```bash
   sudo rosdep init
   rosdep update
   ```
4. Environment setup:
   ```bash
   echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```

---

For more details, refer to the [official ROS installation guide](https://wiki.ros.org/ROS/Installation) and [ROS2 installation guide](https://docs.ros.org/en/ros2_documentation/index.html).
