# qtbase_patched (for Fedora 42)
Patch for the stuttering overview animation. Taken from <a href="https://bugsfiles.kde.org/attachment.cgi?id=176255" name="Patch" id="linktome" target="_blank">Here</a>.

mkdir qtbase <br>

cd qtbase <br>

dnf download qt6-qtbase --source <br>

rpm2cpio *.src.rpm | cpio -idmv <br>

sudo dnf builddep  qt6-qtbase.spec #also install fedpkg while you're at it <br>

edit src/corelib/animation/qabstractanimation.cpp and change define DEFAULT_TIMER_INTERVAL 16 to define DEFAULT_TIMER_INTERVAL 6 #works well for 144hz screens <br>

open SPEC file and change Release: x%{?dist} to something like Release: 99%{?dist} <br>

fedpkg --release f42 local #Recompile the library with the patch in place <br>

copy built .rpm packages from both x86_64 and noarch into a single folder and run sudo dnf install ./* <br>

reboot
