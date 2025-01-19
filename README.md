# qtbase_patched (for Fedora 41)
Patch for the stuttering overview animation.

mkdir qtbase
cd qtbase
dnf download qt6-qtbase --source
rpm2cpio *.src.rpm | cpio -idmv
sudo dnf builddep  qt6-qtbase.spec #also install fedpkg while you're at it
edit src/corelib/animation/qabstractanimation.cpp and change define DEFAULT_TIMER_INTERVAL 16 to define DEFAULT_TIMER_INTERVAL 6 #works well for 144hz screens
open SPEC file and change Release: x%{?dist} to something like Release: 99%{?dist}
fedpkg --release f41 local #Recompile the library with the patch in place
copy built .rpm packages from both x86_64 and noarch into a single folder and run sudo dnf install ./*
reboot
