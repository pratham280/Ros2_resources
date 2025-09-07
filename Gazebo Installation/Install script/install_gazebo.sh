#!/bin/bash -eu

set -e

# Check for existing Gazebo installations (Classic and GZ)
gazebo_classic_installed=""
gazebo_gz_installed=""

# Check for Gazebo Classic (gazebo, gazebo11, etc.)
if command -v gazebo >/dev/null 2>&1; then
    gazebo_classic_installed="yes"
elif dpkg -l | grep -q '^ii  gazebo\|^ii  gazebo11'; then
    gazebo_classic_installed="yes"
fi

# Check for Gazebo GZ (gz, gz-fortress, gz-harmonic, gz-ionic, etc.)
if command -v gz >/dev/null 2>&1; then
    gazebo_gz_installed="yes"
elif dpkg -l | grep -q '^ii  gz-'; then
    gazebo_gz_installed="yes"
fi

if [ "$gazebo_classic_installed" = "yes" ] || [ "$gazebo_gz_installed" = "yes" ]; then
    echo "##################################################################################################"
    echo "Detected existing Gazebo installation(s):"
    if [ "$gazebo_classic_installed" = "yes" ]; then
        echo "- Gazebo Classic (gazebo/gazebo11) detected."
    fi
    if [ "$gazebo_gz_installed" = "yes" ]; then
        echo "- Gazebo (gz) detected."
    fi
    echo "Do you want to continue with the installation or quit?"
    read -p ">>> Enter 'c' to continue or 'q' to quit [q]: " gazebo_continue_choice
    case "$gazebo_continue_choice" in
        "c"|"C")
            echo "Continuing with installation..."
            ;;
        *)
            echo "Exiting installation as requested."
            exit 0
            ;;
    esac
    echo "##################################################################################################"
fi

# Try to detect installed ROS version/distro
detected_ros_distro=""
if command -v rosversion >/dev/null 2>&1; then
	detected_ros_distro=$(rosversion -d 2>/dev/null || true)
elif [ -n "$ROS_DISTRO" ]; then
	detected_ros_distro="$ROS_DISTRO"
else
	# Try to detect from /opt/ros
	if [ -d "/opt/ros" ]; then
		detected_ros_distro=$(ls /opt/ros | head -n1)
	fi
fi

if [ -n "$detected_ros_distro" ]; then
	echo "Detected ROS distro on your system: $detected_ros_distro"
	ros_distro_default="$detected_ros_distro"
else
	ros_distro_default="noetic"
fi

echo "##################################################################################################"
echo "Gazebo Installation Script - Choose your ROS Distro for compatible Gazebo version"
echo "##################################################################################################"
echo ""

ros_distro=${ros_distro:-$ros_distro_default}

case "$ros_distro" in
	"noetic")
		echo "You selected ROS Noetic. Recommended Gazebo version: Gazebo 11."
		gazebo_pkg="gazebo11"
		;;
	"humble")
		echo "You selected ROS2 Humble. Recommended Gazebo version: Gazebo Fortress."
		gazebo_pkg="gazebo-fortress"
		;;
	"jazzy")
		echo "You selected ROS2 Jazzy. Recommended Gazebo version: Gazebo Harmonic."
		gazebo_pkg="gazebo-harmonic"
		;;
	"kilted")
		echo "You selected ROS2 Kilted. Recommended Gazebo version: Gazebo Kinetic (or latest supported)."
		gazebo_pkg="gazebo-ionic"
		;;
	*)
		echo "Unknown ROS distro. Installing Gazebo Classic."
		gazebo_pkg="gazebo11"
		;;
esac

echo "Gazebo package to be installed: $gazebo_pkg"
read -p "Proceed with installation? (y/n) [y]: " proceed
if [[ "$proceed" =~ ^[Nn]$ ]]; then
	echo "Installation cancelled."
	exit 0
fi

case "$gazebo_pkg" in
    "gazebo11")
        echo "Installing Gazebo 11..."
        sudo apt update
        curl -sSL http://get.gazebosim.org | sh
        ;;
    "gazebo-fortress")
        echo "Installing Gazebo Fortress..."
        sudo apt-get update
        sudo apt-get install curl lsb-release gnupg -y
        sudo curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
        sudo apt-get update
        sudo apt-get install gz-fortress -y
        ;;
    "gazebo-harmonic")
        echo "Installing Gazebo Harmonic..."
        sudo apt-get update
        sudo apt-get install curl lsb-release gnupg -y
        sudo curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
        sudo apt-get update
        sudo apt-get install gz-harmonic -y
        ;;
    "gazebo-ionic")
        echo "Installing Gazebo Ionic..."
        sudo apt-get update
        sudo apt-get install curl lsb-release gnupg -y
        sudo curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null
        sudo apt-get update
        sudo apt-get install gz-ionic -y
        exit 1
        ;;
    *)
        echo "Unknown Gazebo package. Exiting."
        exit 1
        ;;
esac
