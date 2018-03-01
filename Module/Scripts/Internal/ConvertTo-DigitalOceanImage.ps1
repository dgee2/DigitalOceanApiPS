function ConvertTo-DigitalOceanImage {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)]
        [PSCustomObject]
        $rawObject
    )
    begin {
    }
    process {
        New-Object PSObject -Property @{
            Id = $rawObject.id
            Name = $rawObject.name
            Distribution = $rawObject.distribution
            Slug = $rawObject.slug
            Public = $rawObject.public
            Regions = $rawObject.regions
            CreatedAt = [datetime]$rawObject.created_at
            Type = $rawObject.type
            MinDiskSize = $rawObject.min_disk_size
            Size = $rawObject.size_gigabytes
        }
    }
    end {
    }
}