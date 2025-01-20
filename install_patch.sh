#!/bin/bash

# Exit on error
set -e

# Create and move into qtbase directory
mkdir qtbase
cd qtbase

# Download the source RPM for qt6-qtbase
dnf download qt6-qtbase --source

# Extract the contents of the source RPM
rpm2cpio *.src.rpm | cpio -idmv

# Install build dependencies and fedpkg
sudo dnf builddep qt6-qtbase.spec
sudo dnf install -y fedpkg

# Modify qabstractanimation.cpp
sed -i 's/#define DEFAULT_TIMER_INTERVAL 16/#define DEFAULT_TIMER_INTERVAL 6/' src/corelib/animation/qabstractanimation.cpp

# Modify the SPEC file release version
sed -i 's/^Release:.*$/Release: 99%{?dist}/' qt6-qtbase.spec

# Recompile the library with the patch in place
fedpkg --release f41 local

# Create a folder to store built RPMs and copy them there
mkdir -p built_rpms
cp ~/rpmbuild/RPMS/x86_64/*.rpm ./built_rpms
cp ~/rpmbuild/RPMS/noarch/*.rpm ./built_rpms

# Install the RPM packages
sudo dnf install -y ./built_rpms/*.rpm

echo "Process completed successfully."