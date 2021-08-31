<#
	Since we are using the unmodified FLAC repo we need to patch it to not search for an 
	installed libogg, since we can just use the one which is built vor libshout anyway.
#>
$filePath = ".\flac\CMakeLists.txt"
$flacCmakeFile = Get-Content $filePath
$flacCmakeFilePatched = $flacCmakeFile.Replace("    find_package(Ogg REQUIRED)", "    #find_package(Ogg REQUIRED)")
Set-Content -Value $flacCmakeFilePatched -Path $filePath