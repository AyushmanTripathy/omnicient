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
  exit
}

# check for pip
python -m pip -h >> /dev/null
if [ $? -ne 0 ]
then
  show_error "pip not found"
else
  show_info "found pip"
fi

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
  show_error "invalid index"
fi
location="${locations[$index]}/omnicient"

# creating clone directory
show_info "using $location"
show_info "cloning repo"
clone_location="/tmp/omnicient-repo/"
mkdir -p $clone_location
cd $clone_location

# clone repo
show_info "cloning into $clone_location"
git clone "https://github.com/AyushmanTripathy/omnicient" --depth 1
if [ $? -ne 0 ]
then
  show_error "failed to clone repo"
fi

# copy files
cp "$clone_location/omnicient/omnicient" $location
rm -rf $clone_location
chmod +x $location

# complete
show_info "installation complete"
show_info "report any issues at https://github.com/AyushmanTripathy/omnicient"
show_info "thank you for trying out omnicient"
