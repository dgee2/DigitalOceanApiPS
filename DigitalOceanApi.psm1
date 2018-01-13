# load all script files
Get-ChildItem $PSScriptRoot/Scripts -File -Recurse | ForEach-Object {
    Import-Module $_.FullName
 }
