# Gazebo Installation

![Gazebo](https://gazebosim.org/assets/images/highlight.png)

## Table of Contents
- [Installation Script](#installation-script)
- [Gazebo Classic Installation](#gazebo-classic-installation)
  - [Prerequisites](#prerequisites)
  - [Ubuntu Package Installation](#ubuntu-package-installation)
  - [Source Installation](#source-installation)
- [Gazebo (gz) Installation](#gazebo-gz-installation)
  - [Fortress (Ubuntu 22.04)](#fortress-ubuntu-2204)
  - [Harmonic (Ubuntu 24.04)](#harmonic-ubuntu-2404)
  - [Ionic (Ubuntu 24.04)](#ionic-ubuntu-2404)
- [ROS Integration](#ros-integration)
  - [Compatibility Matrix](#compatibility-matrix)
  - [Integration Steps](#integration-steps)
- [Uninstall Gazebo](#uninstall-gazebo)
  - [Uninstall Classic](#uninstall-classic)
  - [Uninstall gz](#uninstall-gz)
- [References](#reference)
## Installation Script

I have created Script for Installation of Gazebo Classic and Gazebo Sim 
```bash
xyz
```

## Gazebo Installation 
## Summary of Compatible ROS and Gazebo Combinations

This table includes all currently supported versions of ROS and Gazebo. All
other ROS and Gazebo releases are end of life and we do not recommend their
continued use.

|                           | **GZ Fortress (LTS)**   | **GZ Harmonic (LTS)**   | **GZ Ionic**
|---------------------------|-----------------------  | ----------------------  | ------------
| **ROS 2 Rolling**         | ❌                      | ⚡                       | ✅
| **ROS 2 Kilted**          | ❌                      | ⚡                       | ✅
| **ROS 2 Jazzy (LTS)**     | ❌                      | ✅                      | ❌
| **ROS 2 Humble (LTS)**    | ✅                      | ⚡                       | ❌
| **ROS 1 Noetic (LTS)**    | ⚡                       | ❌                      | ❌


* ✅ - Recommended combination
* ❌ - Incompatible / not possible.
* ⚡ - Possible, *but use with caution*. These combinations of ROS and Gazebo can
  be made to work together, but some effort is required.

## Gazebo Classic

## ROS Integration

## Reference

__GazeboClassic__ - https://classic.gazebosim.org/tutorials?tut=install_ubuntu

__Gazebosim__ - https://gazebosim.org/docs/latest/ros_installation/
