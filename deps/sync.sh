#!/bin/sh
set -e
echo "Sync started."
for i in \
https://github.com/Iunusov/libmp3lame-CMAKE.git \
https://github.com/xiph/ogg.git \
https://github.com/xiph/vorbis.git \
https://github.com/Iunusov/libshout-CMAKE.git \
https://github.com/fltk/fltk.git \
https://r-tur@bitbucket.org/r-tur/vst_sdk_2.4.git \
https://github.com/xiph/flac.git
do
filename="$(basename "$i")"
dir="${filename%.*}"
echo $dir
if [ ! -d "$dir" ]; then
  git clone "$i"
else
  cd "$dir"
  git pull
  cd ..
fi
done
echo "Done."
