#!/bin/bash

# miscelaneos a instalar
apt install arc-theme \
  git g++ python-numpy \
  libeigen3-dev zlib1g-dev libqt4-opengl-dev libgl1-mesa-dev \
  libfftw3-dev libtiff5-dev \
  libqt5opengl5 libqt5opengl5-dev \
  libcanberra-gtk3-module libcanberra-gtk-module \
  chromium-browser chrome-gnome-shell \
  x2goclient sshfs \
  inkscape keepassx \
  gdebi-core htop tree curl \
  libmng-dev \
  libgtkglext1 \
  tcsh \
  python-qwt5-qt4 \
  gnome-tweaks gnome-shell-extensions \
  moka-icon-theme \
  libssl-dev curl libcurl4-openssl-dev \
  numix-blue-gtk-theme numix-gtk-theme numix-icon-theme \
  papirus-icon-theme \
  tilix shutter \
  cinnamon-desktop-environment plasma-desktop budgie-desktop lxde gnome-session

#update-alternatives --config gdm3.css






# rstudio
# First we install a PPA for the latest version of R, which is more modern than that in the ubuntu repos
add-apt-repository ppa:marutter/rrutter
apt-get update
apt install r-base r-base-dev
# and now we install rstudio
wget --progress=bar --directory-prefix=/tmp https://download1.rstudio.org/rstudio-xenial-1.1.456-amd64.deb
gdebi /tmp/rstudio-xenial-1.1.456-amd64.deb
ln -s /usr/lib/rstudio/bin/libicui18n.so.55 /usr/lib/rstudio/bin/libicui18n.so.52
wget --progress=bar --directory-prefix=/tmp http://mirrors.kernel.org/ubuntu/pool/main/libx/libxp/libxp6_1.0.2-1ubuntu1_amd64.deb
gdebi /tmp/libxp6_1.0.2-1ubuntu1_amd64.deb




# para fsl 509
# apt install libmng-dev
ln -sv /usr/lib/x86_64-linux-gnu/libmng.so.2 /usr/lib/x86_64-linux-gnu/libmng.so.1
ln -sv /usr/lib/x86_64-linux-gnu/libjpeg.so.8 /usr/lib/x86_64-linux-gnu/libjpeg.so.62
f=`locate libpng12.so.0 | head -n 1`
cp -v $f /usr/lib/x86_64-linux-gnu/


# para mrtrix
# apt install libgtkglext1
f=/usr/lib/x86_64-linux-gnu/libgsl.so.23
ln -sv $f /usr/lib/x86_64-linux-gnu/libgsl.so.0

# para freesurfer 5.3
# apt install tcsh


# rclone
rclonedeb=rclone-v1.45-linux-amd64.deb
if [ -f $rclonedeb ]
then
  gdebi --n $rclonedeb
else
  echo "Did not find .deb for rclone: $rclonedeb"
fi
