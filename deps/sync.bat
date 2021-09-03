@echo off

echo Sync started.

echo libmp3lame...
if not exist libmp3lame-CMAKE (
    (git clone https://github.com/Iunusov/libmp3lame-CMAKE.git)
) else (
    (cd libmp3lame-CMAKE) && (git pull) && (cd ..)
)
echo OGG...
if not exist ogg (
    (git clone https://github.com/xiph/ogg.git)
) else (
    (cd ogg) && (git pull) && (cd ..)
)

echo vorbis...
if not exist vorbis (
    (git clone https://github.com/xiph/vorbis.git)
) else (
    (cd vorbis) && (git pull) && (cd ..)
)

echo libshout...
if not exist Icecast-libshout (
    (git clone --recurse-submodules https://github.com/xiph/Icecast-libshout.git)
) else (
    (cd Icecast-libshout) && (git pull) && (git submodule update --init --recursive) && (cd ..)
)
cp CMakeLists_Icecast-libshout.txt Icecast-libshout/CMakeLists.txt

)
echo libflac...
if not exist flac (
    (git clone https://github.com/xiph/flac.git)
) else (
    (cd flac) && (git pull) && (cd ..)
)


echo fltk...
if not exist fltk (
    (git clone https://github.com/fltk/fltk.git)
) else (
    (cd fltk) && (git pull) && (cd ..)
)

echo VST_SDK_2.4...
if not exist vst_sdk_2.4 (
    (git clone https://r-tur@bitbucket.org/r-tur/vst_sdk_2.4.git)
) else (
    (cd vst_sdk_2.4) && (git pull) && (cd ..)
)



echo lame...
rm -Recurse -Force lame
Invoke-WebRequest -Uri "https://sourceforge.net/projects/lame/files/latest/download" -OutFile toBeDeleted
rm toBeDeleted
7z x "download" -so | 7z x -aoa -si -ttar -o"lame"
mv lame-* lame
rm download
cp CMakeLists_lame.txt lame/CMakeLists.txt

echo Done.
