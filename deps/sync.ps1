Write-Host("Sync started.")

Write-Host("OGG...")
if (-not ((Test-Path "ogg") )) {
    (git clone https://github.com/xiph/ogg.git)
} else {
    cd ogg
    git pull
    cd ..
}

Write-Host("vorbis...")
if (-not (Test-Path vorbis )) {
    (git clone https://github.com/xiph/vorbis.git)
} else {
    cd vorbis
    git pull
    cd ..
}

Write-Host("libshout...")
if (-not (Test-Path Icecast-libshout )) {
    git clone --recurse-submodules https://gitlab.xiph.org/xiph/icecast-libshout.git   
} 
cd icecast-libshout
git pull
git submodule update --init --recursive
git checkout 91cee6f7628193527401a06b2216d66f33e46248 #this commit was used to create the patches
git apply ..\PatchLibShout.patch
cd src\common
git apply ..\..\..\PatchLibShoutCommon.patch
cd ..\..\..\

#cp CMakeLists_Icecast-libshout.txt Icecast-libshout/CMakeLists.txt


Write-Host("libflac...")
if (-not (Test-Path flac )) {
    (git clone https://github.com/xiph/flac.git)
} else {
    cd flac
    git pull
    cd ..
}


Write-Host("fltk...")
if (-not (Test-Path fltk )) {
    (git clone https://github.com/fltk/fltk.git)
} else {
    cd fltk
    git pull
    cd ..
}

Write-Host("VST_SDK_2.4...")
if (-not (Test-Path vst_sdk_2.4)) {
    (git clone https://r-tur@bitbucket.org/r-tur/vst_sdk_2.4.git)
} else {
    cd vst_sdk_2.4
    git pull
    cd ..
}



Write-Host("lame...")
$7zPath = "C:\Program Files\7-Zip\7z.exe"
if (-not (Test-Path $7zPath)){
    Write-Host "ERROR: Could not find 7-zip installation at: $($7zPath)" -ForegroundColor Red
    return
}

rm -Recurse -Force -ErrorAction SilentlyContinue lame
$lameArchiveFilename = "lame.tar.gz"
Invoke-WebRequest -Uri "https://sourceforge.net/projects/lame/files/latest/download" -OutFile toBeDeleted
[PSCustomObject]$obj = [PSCustomObject](gc toBeDeleted | Select-String -Pattern ".tar.gz" | ConvertFrom-String)
$url = (((($obj | Get-Member | Where {$_.Definition -like "*url=*"}).Definition) -split "url=")[1]).Replace('">', '')
rm toBeDeleted
Invoke-WebRequest -Uri $url -OutFile $lameArchiveFilename 
tar -xzvf $lameArchiveFilename 
#& $7zPath x $lameArchiveFilename  -so | & $7zPath x -aoa -si -ttar -o"lame"
mv lame-* lame
rm $lameArchiveFilename 
cp CMakeLists_lame.txt lame/CMakeLists.txt

Write-Host("Done.")
