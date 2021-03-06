#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
Set-Location (Split-Path $PSScriptRoot)

foreach ($item in ".dart_tool/build", "build", "doc/api", "www") {
	if (Test-Path $item) { Remove-Item $item -Recurse }
}

foreach ($item in Get-ChildItem var -Exclude .gitkeep) {
	Remove-Item $item -Recurse
}
