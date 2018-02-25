function Test-DigitalOceanImage {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        $DigitalOceanImage,
        # Parameter help description
        [Parameter(Mandatory)]
        $RawObject
    )
    
    begin {
    }
    
    process {
        It 'Returns a DigitalOceanImage instance'{
            $DigitalOceanImage.GetType() | Should -Be 'DigitalOceanImage'
        }
        It 'Parses Id correctly' {
            $DigitalOceanImage.Id | Should -Be $RawObject.id
        }
        It 'Parses Name correctly' {
            $DigitalOceanImage.Name | Should -Be $RawObject.name
        }
        It 'Parses Distribution correctly' {
            $DigitalOceanImage.Distribution | Should -Be $RawObject.distribution
        }
        It 'Parses Slug correctly' {
            $DigitalOceanImage.Slug | Should -Be $RawObject.slug
        }
        It 'Parses Public correctly' {
            $DigitalOceanImage.Public | Should -Be $RawObject.public
        }
        It 'Parses Regions correctly' {
            $DigitalOceanImage.Regions | Should -Be $RawObject.regions
        }
        It 'CreatedAt to DateTime'{
            $DigitalOceanImage.CreatedAt.GetType() | Should -Be 'DateTime'
        }
        It 'Parses CreatedAt correctly'{
            $DigitalOceanImage.CreatedAt | Should -Be ([datetime]$RawObject.created_at)
        }
        It 'Type to EDigitalOceanImageType'{
            $DigitalOceanImage.Type.GetType() | Should -Be 'EDigitalOceanImageType'
        }
        It 'Parses Type correctly'{
            $DigitalOceanImage.Type | Should -Be ([EDigitalOceanImageType]$RawObject.type)
        }
        It 'Parses MinDiskSize correctly' {
            $DigitalOceanImage.MinDiskSize | Should -Be $RawObject.min_disk_size
        }
        It 'Parses Size correctly' {
            $DigitalOceanImage.Size | Should -Be $RawObject.size_gigabytes
        }
    }
    
    end {
    }
}