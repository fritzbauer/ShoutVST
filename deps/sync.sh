#!/bin/sh
set -e
echo "Sync started."
for i in \
https://github.com/Iunusov/libmp3lame-CMAKE.git \
https://github.com/xiph/ogg.git \
https://github.com/xiph/vorbis.git \
https://github.com/xiph/Icecast-libshout.git \
https://github.com/fltk/fltk.git \
https://r-tur@bitbucket.org/r-tur/vst_sdk_2.4.git \
https://github.com/xiph/flac.git
do
filename="$(basename "$i")"
dir="${filename%.*}"
echo $dir
if [ ! -d "$dir" ]; then
  git clone --recurse-submodules "$i"  
else
  cd "$dir"
  git pull
  git submodule update --init --recursive
  cd ..
fi
done


rm -rf lame
wget https://sourceforge.net/projects/lame/files/latest/download -o toBeDeleted
rm toBeDeleted
tar -xvf download
mv lame-* lame
rm download

cp CMakeLists_Icecast-libshout.txt Icecast-libshout/CMakeLists.txt
cp CMakeLists_lame.txt lame/CMakeLists.txt


echo "Done."
