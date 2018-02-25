# load all script files
Get-ChildItem $PSScriptRoot/Scripts/Enums -File -Recurse | ForEach-Object {
    . $_.FullName
}
Get-ChildItem $PSScriptRoot/Scripts -File -Recurse | ForEach-Object {
    . $_.FullName
}