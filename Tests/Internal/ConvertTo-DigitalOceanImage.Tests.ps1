Import-Module $PSScriptRoot/../../Module/DigitalOceanApi.psd1
. $PSScriptRoot/../../Module/Scripts/Internal/ConvertTo-DigitalOceanImage.ps1
. $PSScriptRoot/../../Module/Scripts/Enums/EDigitalOceanImageType.ps1
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
        $result = ConvertTo-DigitalOceanImage $rawObject
        
        It 'Returns a DigitalOceanImage instance'{
            $result.GetType() | Should -Be 'DigitalOceanImage'
        }
        It 'Parses Id correctly' {
            $result.Id | Should -Be $rawObject.id
        }
        It 'Parses Name correctly' {
            $result.Name | Should -Be $rawObject.name
        }
        It 'Parses Distribution correctly' {
            $result.Distribution | Should -Be $rawObject.distribution
        }
        It 'Parses Slug correctly' {
            $result.Slug | Should -Be $rawObject.slug
        }
        It 'Parses Public correctly' {
            $result.Public | Should -Be $rawObject.public
        }
        It 'Parses Regions correctly' {
            $result.Regions | Should -Be $rawObject.regions
        }
        It 'CreatedAt to DateTime'{
            $result.CreatedAt.GetType() | Should -Be 'DateTime'
        }
        It 'Parses CreatedAt correctly'{
            $result.CreatedAt | Should -Be ([datetime]$rawObject.created_at)
        }
        It 'Type to EDigitalOceanImageType'{
            $result.Type.GetType() | Should -Be 'EDigitalOceanImageType'
        }
        It 'Parses Type correctly'{
            $result.Type | Should -Be ([EDigitalOceanImageType]$rawObject.type)
        }
        It 'Parses MinDiskSize correctly' {
            $result.MinDiskSize | Should -Be $rawObject.min_disk_size
        }
        It 'Parses Size correctly' {
            $result.Size | Should -Be $rawObject.size_gigabytes
        }
    }
    Context 'Passed pipeline rawObject' {
        $result = $rawObject | ConvertTo-DigitalOceanImage

        It 'Returns a DigitalOceanImage instance'{
            $result.GetType() | Should -Be 'DigitalOceanImage'
        }
        It 'Parses Id correctly' {
            $result.Id | Should -Be $rawObject.id
        }
        It 'Parses Name correctly' {
            $result.Name | Should -Be $rawObject.name
        }
        It 'Parses Distribution correctly' {
            $result.Distribution | Should -Be $rawObject.distribution
        }
        It 'Parses Slug correctly' {
            $result.Slug | Should -Be $rawObject.slug
        }
        It 'Parses Public correctly' {
            $result.Public | Should -Be $rawObject.public
        }
        It 'Parses Regions correctly' {
            $result.Regions | Should -Be $rawObject.regions
        }
        It 'CreatedAt to DateTime'{
            $result.CreatedAt.GetType() | Should -Be 'DateTime'
        }
        It 'Parses CreatedAt correctly'{
            $result.CreatedAt | Should -Be ([datetime]$rawObject.created_at)
        }
        It 'Type to EDigitalOceanImageType'{
            $result.Type.GetType() | Should -Be 'EDigitalOceanImageType'
        }
        It 'Parses Type correctly'{
            $result.Type | Should -Be ([EDigitalOceanImageType]$rawObject.type)
        }
        It 'Parses MinDiskSize correctly' {
            $result.MinDiskSize | Should -Be $rawObject.min_disk_size
        }
        It 'Parses Size correctly' {
            $result.Size | Should -Be $rawObject.size_gigabytes
        }
    }
}