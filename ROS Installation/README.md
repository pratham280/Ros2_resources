![ros mascot](https://live.staticflickr.com/4097/4787692791_03b2c7ee06.jpg)

# Robot Operating System (ROS/ROS2) Installation Guide

This guide provides installation instructions for various ROS and ROS2 distributions. Each section is dedicated to a specific version for clarity.

> Covering only **Tier-1 Platform**[^1]. as Mentioned in [REP 2000](https://www.ros.org/reps/rep-2000.html).

I have Created an All-in-one Script which installs based on ubuntu version and best suited ROS Distro.

```bash
wget -c https://raw.githubusercontent.com/pratham280/Ros2_resources/refs/heads/master/ROS%Installation/Install%script/ros_install_script.sh && sudo ./ros_install_script.sh
```



## Table of Contents

- [Prerequisites](#prerequisites)
  - [Set Locale](#set-locale)
  - [Adding Ubuntu Universe Repository](#adding-ubuntu-universe-repository)
  - [Getting Necessary Packages](#getting-necessary-packages)
- [ROS2 Installation](#ros2-installation)
  - [Kilted Kaiju (Ubuntu 24.04)](#ros2-kilted-kaiju-ubuntu-2404)
  - [Jazzy Jalisco (Ubuntu 24.04)](#ros2-jazzy-jalisco-ubuntu-2404)
  - [Humble Hawksbill (Ubuntu 22.04)](#ros2-humble-hawksbill-ubuntu-2204)
  - [Foxy Fitzroy (Ubuntu 20.04)](#ros2-foxy-fitzroy-ubuntu-2004)
- [ROS Installation](#ros-installation)
  - [Noetic Ninjemys (Ubuntu 20.04)](#ros-noetic-ninjemys-ubuntu-2004)
  - [Kinetic Kame (Ubuntu 16.04)](#ros-kinetic-kame-ubuntu-1604)
- [Uninstall ROS](#uninstall-ros)

## Prerequisites

### Set Locale

Make sure you have a locale which supports `UTF-8`. If you are in a minimal environment (such as a docker container), the locale may be something minimal like `POSIX`. We test with the following settings. However, it should be fine if you’re using a different UTF-8 supported locale

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

<img src="https://docs.ros.org/en/humble/_images/kilted-small.png" alt="Humble" width="60" />

### ROS2 Kilted Kaiju (Ubuntu 24.04)

1. Setup sources:

   ```bash
   sudo apt update && sudo apt install curl -y

   export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
   curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" # If using Ubuntu derivates use $UBUNTU_CODENAME

   sudo dpkg -i /tmp/ros2-apt-source.deb
   ```
   a. Install development tools (optional)
   ```bash
   sudo apt update && sudo apt install ros-dev-tools
   ```
2. Install ROS2 Kilted:

   ```bash
   sudo apt update && sudo apt upgrade
   sudo apt install ros-kilted-desktop
   ```

3. Environment setup:
   ```bash
   echo "source /opt/ros/kilted/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```
   > :information_source: Note\
   Replace `.bash` with your shell if you’re not using bash. Possible values are: `setup.bash`,` setup.sh`, `setup.zsh`.

4. Install Colcon[^2]
   ``` bash
   sudo apt install python3-colcon-common-extensions
   ```
   
---

<img src="https://docs.ros.org/en/humble/_images/jazzy-small.png" alt="Humble" width="60" />

### ROS2 Jazzy Jalisco (Ubuntu 24.04)

1. Setup sources:

   ```bash
   sudo apt update && sudo apt install curl -y

   export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
   curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" # If using Ubuntu derivates use $UBUNTU_CODENAME

   sudo dpkg -i /tmp/ros2-apt-source.deb
   ```
   a. Install development tools (optional)
   ```bash
   sudo apt update && sudo apt install ros-dev-tools
   ```
2. Install ROS2 Jazzy:

   ```bash
   sudo apt update && sudo apt upgrade
   sudo apt install ros-jazzy-desktop
   ```

3. Environment setup:
   ```bash
   echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```
   > :information_source: Note\
   Replace `.bash` with your shell if you’re not using bash. Possible values are: `setup.bash`,` setup.sh`, `setup.zsh`.
4. Install Colcon[^2]
   ``` bash
   sudo apt install python3-colcon-common-extensions
   ```
---

<img src="https://docs.ros.org/en/humble/_images/humble-small.png" alt="Humble" width="60" /> 

### ROS2 Humble Hawksbill (Ubuntu 22.04)

1. Setup sources:

   ```bash
   sudo apt update && sudo apt install curl -y

   export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
   curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" # If using Ubuntu derivates use $UBUNTU_CODENAME

   sudo dpkg -i /tmp/ros2-apt-source.deb
   ```
   a. Install development tools (optional)
   ```bash
   sudo apt update && sudo apt install ros-dev-tools
   ```
2. Install ROS2 Humble:

   ```bash
   sudo apt update && sudo apt upgrade
   sudo apt install ros-Humble-desktop
   ```

3. Environment setup:
   ```bash
   echo "source /opt/ros/kilted/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```
   > :information_source: Note\
   Replace `.bash` with your shell if you’re not using bash. Possible values are: `setup.bash`,` setup.sh`, `setup.zsh`.
4. Install Colcon[^2]
   ``` bash
   sudo apt install python3-colcon-common-extensions
   ```
---

<img src="https://docs.ros.org/en/humble/_images/foxy-small.png" alt="Humble" width="60" />   

### ROS2 Foxy Fitzroy (Ubuntu 20.04)

1. Setup sources:

   ```bash
   sudo apt update && sudo apt install curl -y

   export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
   curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" # If using Ubuntu derivates use $UBUNTU_CODENAME

   sudo dpkg -i /tmp/ros2-apt-source.deb
   ```
   a. Install development tools (optional)
   ```bash
   sudo apt update && sudo apt install ros-dev-tools
   ```
2. Install ROS2 Foxy:

   ```bash
   sudo apt update && sudo apt upgrade
   sudo apt install ros-foxy-desktop
   ```

3. Environment setup:
   ```bash
   echo "source /opt/ros/kilted/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```
   > :information_source: Note\
   Replace `.bash` with your shell if you’re not using bash. Possible values are: `setup.bash`,` setup.sh`, `setup.zsh`.
4. Install Colcon[^2]
   ``` bash
   sudo apt install python3-colcon-common-extensions
   ```
---

## ROS Installation

<img src="https://raw.githubusercontent.com/ros-infrastructure/artwork/master/distributions/noetic.png" alt="Noetic" width="60" /> 

### ROS Noetic Ninjemys (Ubuntu 20.04)

1. One Line Installation:
   ```bash
   wget -c https://raw.githubusercontent.com/qboticslabs/ros_install_noetic/master/ros_install_noetic.sh && chmod +x ./ros_install_noetic.sh && ./ros_install_noetic.sh
   ```
   > Refer Complete [Installation Guide](https://wiki.ros.org/noetic/Installation/Ubuntu) if Not working
2. Installing Catkin[^3]
   ```bash
   sudo apt-get update
   sudo apt-get install python-rosinstall
   sudo apt install python-catkin-tools
   ```
> 
---
<img src="https://raw.githubusercontent.com/ros-infrastructure/artwork/master/distributions/kinetic.png" alt="Kinetic" width="70" /> 

### ROS Kinetic Kame (Ubuntu 16.04)

1. Setup sources:

   ```bash
   sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

   sudo apt install curl # if you haven't already installed curl
   
   curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
   ```

2. Install ROS Kinetic:

   ```bash
   sudo apt-get update && sudo apt-get install ros-kinetic-desktop-full
   ```


3. Environment setup:

   ```bash
   echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
   source ~/.bashrc
   ```

4. Dependencies for building packages
   ```bash
      sudo apt install python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
   ```
5. Initialize rosdep:

   ```bash
   sudo apt install python-rosdep

   sudo rosdep init
   rosdep update
   ```
6. Installing Catkin[^3]
   ```bash
   sudo apt-get update
   sudo apt-get install python-rosinstall
   sudo apt install python-catkin-tools
   ```
---

For more details, refer to the [official ROS/ROS2 installation guide](https://docs.ros.org/).

[^1]: Tier 1 - Errors or bugs discovered in these platforms are   prioritized for correction by the development team, ROS running on these platforms perform stably
[^2]: Colcon used for building ROS2 Projects
[^3]: Catkin tools used for building ROS Projects 