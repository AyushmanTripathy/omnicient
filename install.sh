#!/bin/sh

# this script is for installing omnicient
# https://github.com/AyushmanTripathy/omnicient

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

show_info() {
  printf "$GREEN[INFO]$NC $1\n"
}

show_error() {
  printf "$RED[ERROR]$NC $1\n"
}

check_for_pip() {
  show_info "using $1"
  # check for pip
  $1 -m pip -h >> /dev/null
  if [ $? -ne 0 ]
  then
    show_error "pip not found"
    check_for_pip "python3"
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
    check_for_pip "python3"
  fi
}

check_for_pip "python"

# ask for install location
locations=("/usr/local/bin" "$HOME/.local/bin")
index=0
echo "select installation location"
for i in "${locations[@]}"
do
  index=$((index + 1))
  echo "$index: $i"
done
printf "select index> "
read index

# check input
index=$((index - 1))
if [ -z "${locations[$index]}" ]
then
  show_error "invalid index" && exit
fi
location="${locations[$index]}/omnicient"

# copy files
show_info "using $location"
cp "omnicient" $location
if [ $? -ne 0 ]
then
  show_error "copying failed!" && exit
fi
chmod +x $location

# complete
show_info "installation complete"
show_info "report any issues at https://github.com/AyushmanTripathy/omnicient"
show_info "thank you for trying out omnicient"
