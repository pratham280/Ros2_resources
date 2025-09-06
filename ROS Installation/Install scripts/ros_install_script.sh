#!/bin/bash -eu
# Script to install ROS1 Noetic or ROS2 (Kilted, Jazzy, Humble) on Ubuntu
set -e

# Set ROS distro name based on Ubuntu version
version=$(lsb_release -sc)
echo ">>> {Checking your Ubuntu version} "
echo ""
relesenum=`grep DISTRIB_DESCRIPTION /etc/*-release | awk -F 'Ubuntu ' '{print $2}' | awk -F ' LTS' '{print $1}'`
echo ">>> {Your Ubuntu version is: [Ubuntu $version $relesenum]}"
echo ""
#Getting version and release number of Ubuntu
case $version in
  "focal")
    echo ">>> {Detected ROS Distro: ROS Noetic Ninjemys}"
    name_ros_distro="noetic"
    ros_version="1"
    ;;
  "noble")
    echo ">>> {You can install ROS 'kilted' or 'jazzy'.}"
    read -p ">>> Enter ROS distro to install (kilted : 1 / jazzy: 0) [jazzy : 0]: " noble_ros_choice
    case "$noble_ros_choice" in
      "1")
        echo ">>> {Detected ROS2 Distro: ROS Kilted Kaola}"
        name_ros_distro="kilted"
        ros_version="2"
        ;;
      "0")
        echo ">>> {Detected ROS2 Distro: ROS Jazzy Jalisco}"
        name_ros_distro="jazzy"
        ros_version="2"
        ;;
      *)
        echo ">>> {Defaulting to 'jazzy'.}"
        echo ">>> {Detected ROS2 Distro: ROS Jazzy Jalisco}"
        name_ros_distro="jazzy"
        ros_version="2"
        ;;
    esac
    ;;
  "jammy")
    echo ">>> {Detected ROS2 Distro: ROS Humble Hawksbill}"
    name_ros_distro="humble"
    ros_version="2"
    ;;
    "xenial")
      echo ">>> {Detected ROS Distro: ROS Kinetic Kame}"
      name_ros_distro="kinetic"
      ros_version="1"
      ;;
  *)
    echo ">>> {ERROR: Unsupported Ubuntu version for automatic ROS distro selection. Exiting.....}"
    exit 1
    ;;
esac
echo ""
echo "#########################"
echo ""
# Check if ROS is already installed
if dpkg -l | grep -q "ros-${name_ros_distro}-"; then
  echo ">>> {A ROS package for ${name_ros_distro} already exists on your system.}"
  echo ">>> {Do you want to continue with the installation or quit?}"
  read -p ">>> Enter 'c' to continue or 'q' to quit [q]: " ros_continue_choice
  case "$ros_continue_choice" in
    "c"|"C")
      echo ">>> {Continuing with installation...}"
      ;;
    *)
      echo ">>> {Exiting installation as requested.}"
      # echo "#########################"
      exit 0
      ;;
  esac
fi
echo ""
# Print the selected ROS distro with first letter uppercase
ros_distro_capitalized="$(echo ${name_ros_distro:0:1} | tr '[:lower:]' '[:upper:]')${name_ros_distro:1}"
echo ">>> {Starting ROS$ros_version $ros_distro_capitalized Installation}"
user_name=$(whoami)
echo ""
echo "#########################"
echo ""
echo ">>> {STEP 0: Setting locale}"
sudo apt update && sudo apt install locales -y
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
echo ""
echo "#########################"
echo ""
# ----------------------------------------------------------------------------------------------
# Installation procedure structure based on ROS version
if [ "$ros_version" = "1" ]; then
echo ">>> {STEP 1: Enable required repositories}"
sudo add-apt-repository universe
sudo add-apt-repository restricted
sudo add-apt-repository multiverse
sudo apt update
echo ""
echo ">>> {Installing curl for adding keys}"
echo ""
sudo apt update && sudo apt install curl -y
# Add ROS repository if not already present
if ! grep -q "^deb .*.ros/ubuntu" /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null; then
  echo ">>> {Adding ROS repository to sources.list.d}"
  echo "deb http://packages.ros.org/ros/ubuntu ${version} main" | sudo tee /etc/apt/sources.list.d/ros-latest.list
else
  echo ">>> {ROS repository already present, skipping.}"
fi
# Check if ROS key is already added
if apt-key list 2>/dev/null | grep -q "F42ED6FBAB17C654"; then
  echo ">>> {ROS key already present, skipping key addition.}"
else
  echo ">>> {Adding ROS key...}"
  curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add -
  if apt-key list 2>/dev/null | grep -q "F42ED6FBAB17C654"; then
    echo ">>> {ROS key added successfully!}"
  else
    echo ">>> {ERROR: Unable to add ROS key. Exiting.}"
    exit 1
  fi
fi
echo ""
echo ">>> {Repositories enabled successfully!}"
echo ""
echo "#########################"
echo ""
echo ">>> {STEP 2: Installing ROS2}"
sudo apt update && sudo apt upgrade -y
echo ">>> {Install ROS, you pick how much of ROS you would like to install.}"
echo ""
echo "     [1. Desktop-Full Install: (Recommended) : Everything in Desktop plus 2D/3D simulators and 2D/3D perception packages ]"
echo ""
echo "     [2. Desktop Install: Everything in ROS-Base plus tools like rqt and rviz]"
echo ""
echo "     [3. ROS-Base: (Bare Bones) ROS packaging, build, and communication libraries. No GUI tools.]"
echo ""
read -p "Enter your install (Default is 1): " answer 

case "$answer" in
  1)
    package_type="desktop-full"
    ;;
  2)
    package_type="desktop"
    ;;
  3)
    package_type="ros-base"
    ;;
  * )
    package_type="desktop-full"
    ;;
esac
echo ""
echo ">>> {Starting ROS installation, this will take about 10 min. It will depends on your internet connection}"
echo ""
sudo apt install -y ros-${name_ros_distro}-${package_type} 
echo ""
echo ">>> {ROS installation completed!}"
echo ""
echo "#########################"
echo ""
echo ">>> {STEP 3: Setting up ROS environment and installing Colcon}"
echo ""
read -p ">>> Do you want to automatically source the ROS environment in your shell startup file? (y/n) [N]: " source_ros_choice
case "$source_ros_choice" in
  "y"|"Y")
    echo "source /opt/ros/noetic/setup.bash" >> /home/$SUDO_USER/.bashrc
    source /home/$SUDO_USER/.bashrc
    ;;
  "n"|"N"|"")
    echo ">>> {Skipping automatic sourcing of ROS environment. You will need to source it manually.}"
    ;;
  *)
    echo ">>> {Skipping automatic sourcing of ROS environment. You will need to source it manually.}"
    ;;
esac
echo ""
echo ">>> {Installing Rosdep and other ROS tools}"
sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
sudo rosdep init
rosdep update
echo ""
echo "#########################"
echo ""
echo ">>> {STEP 4: Testing ROS installation, checking ROS version.}"
echo ""
echo ">>> {Type [ rosversion -d ] to get the current ROS installed version}"
# --------------------------------------------------------------------------------------------
elif [ "$ros_version" = "2" ]; then
echo ">>> {STEP 1: Enable required repositories}"
sudo apt install software-properties-common -y
sudo add-apt-repository universe
echo ""
echo ">>> {Installing curl for adding keys}"
echo ""
sudo apt update && sudo apt install curl -y
# Check if ROS2 keyring already exists
if [ -f /usr/share/keyrings/ros-archive-keyring.gpg ]; then
  echo ">>> {ROS2 keyring already exists, skipping key installation.}"
else
  export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
  curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb"
  sudo dpkg -i /tmp/ros2-apt-source.deb
fi
echo ""
echo ">>> {Repositories enabled successfully!}"
echo ""
echo "#########################"
echo ""
echo ">>> {STEP 2: Installing development tools and ROS tools}"
sudo apt update && sudo apt install ros-dev-tools -y
echo ""
echo "#########################"
echo ""
echo ">>> {STEP 3: Installing ROS2}"
sudo apt update && sudo apt upgrade -y
echo ">>> {Install ROS, you pick how much of ROS you would like to install.}"
echo "     [1. Desktop Install (Recommended): Everything in ROS-Base plus ROS, RViz, demos, tutorials.]"
echo ""
echo "     [2. ROS-Base: Communication libraries, message packages, command line tools. No GUI tools.]"
echo ""
read -p "Enter your install (Default is 1):" answer 
case "$answer" in
  1)
    package_type="desktop"
    ;;
  2)
    package_type="ros-base"
    ;;
  *)
    package_type="desktop"
    ;;
esac
echo ""
echo ">>> {Starting ROS installation, this will take about 10 min. It will depends on your internet connection}"
echo ""
sudo apt install -y ros-${name_ros_distro}-${package_type} 
echo ""
echo ">>> {ROS installation completed!}"
echo ""
echo "#########################"
echo ""
echo ">>> {STEP 4: Setting up ROS environment and installing Colcon}"
echo ""
read -p ">>> Do you want to automatically source the ROS environment in your shell startup file? (y/n) [N]: " source_ros_choice
case "$source_ros_choice" in
  "y"|"Y")
    echo ">>> {Configuring automatic sourcing of ROS environment}"
    echo ""
    default_shell=$(basename "$SHELL")
    echo ">>> {Your default shell is: $default_shell}"
    echo ""
      if [ "$default_shell" = "zsh" ]; then
        echo "source /opt/ros/$name_ros_distro/setup.zsh" >> /home/$SUDO_USER/.zshrc
      elif [ "$default_shell" = "bash" ]; then
        echo "source /opt/ros/$name_ros_distro/setup.bash" >> /home/$SUDO_USER/.bashrc
      else
        echo ">>> {Unknown shell: $default_shell. Please manually source the appropriate ROS setup file.}"
      fi
    ;;
  "n"|"N"|"")
    echo ">>> {Skipping automatic sourcing of ROS environment. You will need to source it manually.}"
    ;;
  *)
    echo ">>> {Skipping automatic sourcing of ROS environment. You will need to source it manually.}"
    ;;
esac
echo ""
echo ">>> {Installing Colcon}"
sudo apt update && sudo apt install python3-colcon-common-extensions -y
echo ""
echo "#########################"
echo ""
echo ">>> {STEP 6: Testing ROS installation, checking ROS version.}"
echo ""
echo ">>> {Type [echo \$ROS_DISTRO] to get the current ROS installed version}"}
else
  echo ">>> {Unknown ROS version. Please check your configuration.}"
  exit 1
fi