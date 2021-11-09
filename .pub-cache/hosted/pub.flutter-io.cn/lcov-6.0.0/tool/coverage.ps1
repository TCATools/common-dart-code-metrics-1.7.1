#!/usr/bin/env pwsh
Set-StrictMode -Version Latest
Set-Location (Split-Path $PSScriptRoot)

pub run coverage:format_coverage --in=var/test --lcov --out=var/lcov.info --packages=.dart_tool/package_config.json --report-on=lib
pub global run coveralls var/lcov.info
