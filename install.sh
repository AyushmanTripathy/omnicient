#!/bin/sh

# this script is for installing omnicient
# https://github.com/AyushmanTripathy/omnicient

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

python_version="python3"

show_info() {
  printf "$GREEN[INFO]$NC $1\n"
}

show_error() {
  printf "$RED[ERROR]$NC $1\n"
}

check_for_pip() {
  python_version="$1"
  show_info "using $1"
  # check for pip
  $1 -m pip -h >> /dev/null
  if [ $? -ne 0 ]
  then
    show_error "pip not found"
    check_for_pip "python"
    return
  else
    show_info "found pip"
  fi

  # installing deps
  $1 -m pip install beautifulsoup4
  if [ $? -eq 0 ]
  then
    show_info "installation complete beautifulsoup4"
  else
    show_error "installation failed for beautifulsoup4"
    check_for_pip "python"
    return
  fi
}

check_for_pip "$python_version"

# install location
show_info "enter install location"
printf "$HOME/"
read location
if [ -z "$location" ]
then
  location="$HOME/.local/bin"
  show_info "using default location"
else
  location="$HOME/$location"
fi
location="$location/omnicient"

# copy files
show_info "using $location"
echo "#!/usr/bin/env $python_version" > $location
cat "omnicient.py" >> $location

if [ $? -ne 0 ]
then
  show_error "copying failed!" && exit
fi
chmod +x $location

# complete
show_info "installation complete"
show_info "report any issues at https://github.com/AyushmanTripathy/omnicient"
show_info "thank you for trying out omnicient"
