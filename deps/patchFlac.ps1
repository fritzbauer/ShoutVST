<#
	Since we are using the unmodified FLAC repo we need to patch it to not search for an 
	installed libogg, since we can just use the one which is built vor libshout anyway.
#>
$filePath = ".\flac\CMakeLists.txt"
$flacCmakeFile = Get-Content $filePath
if($flacCMakeFile.Contains("    find_package(Ogg REQUIRED)")){
    $flacCmakeFilePatched = $flacCmakeFile.Replace("    find_package(Ogg REQUIRED)", "    #find_package(Ogg REQUIRED)")
    Set-Content -Value $flacCmakeFilePatched -Path $filePath
} elseif ($flacCMakeFile.Contains("    #find_package(Ogg REQUIRED)")) {
    Write-Host "FLAC Cmake file already patched." -ForegroundColor Green
} else {
    Write-Host "Failed to patch FLAC Cmake file." -ForegroundColor Red
}
