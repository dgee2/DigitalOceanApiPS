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
        $ret = [DigitalOceanImage]::new()
        $ret.Id = $rawObject.id
        $ret.Name = $rawObject.name
        $ret.Distribution = $rawObject.distribution
        $ret.Slug = $rawObject.slug
        $ret.Public = $rawObject.public
        $ret.Regions = $rawObject.regions
        $ret.CreatedAt = [datetime]$rawObject.created_at
        $ret.Type = [EDigitalOceanImageType]$rawObject.type
        $ret.MinDiskSize = $rawObject.min_disk_size
        $ret.Size = $rawObject.size_gigabytes
        $ret
    }
    end {
    }
}