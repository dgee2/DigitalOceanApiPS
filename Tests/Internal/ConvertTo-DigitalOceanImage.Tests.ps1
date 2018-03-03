Import-Module $PSScriptRoot/../../Module/DigitalOceanApi.psd1
. $PSScriptRoot/../../Module/Scripts/Internal/ConvertTo-DigitalOceanImage.ps1
. $PSScriptRoot/../Helpers/Test-DigitalOceanImage.ps1
$rawObject = @{
    id = 7555620
    name = "Nifty New Snapshot"
    distribution = "Ubuntu"
    slug = "Some Unique Slug"
    public = $true
    regions = @(
        "nyc1",
        "nyc2"
    )
    created_at = "2014-11-04T22:23:02Z"
    type = "snapshot"
    min_disk_size = 20
    size_gigabytes = 2.34
}

Describe 'ConvertTo-DigitalOceanImage' {
    Context 'Passed Single rawObject' {
        ConvertTo-DigitalOceanImage $rawObject | Test-DigitalOceanImage -RawObject $rawObject
    }
    Context 'Passed pipeline rawObject' {
        $rawObject | ConvertTo-DigitalOceanImage | Test-DigitalOceanImage -RawObject $rawObject
    }
}