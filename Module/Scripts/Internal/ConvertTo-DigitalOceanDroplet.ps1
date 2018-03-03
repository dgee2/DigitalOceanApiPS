function ConvertTo-DigitalOceanDroplet {
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
            Memory = $rawObject.memory
            VCPUs = $rawObject.vcpus
            DiskSize = $rawObject.disk
            Locked = $rawObject.locked
            Status = $rawObject.status
            Kernel = $rawObject.kernel
            CreatedAt = [datetime]$rawObject.created_at
            Features = $rawObject.features
            BackupIds = $rawObject.backup_ids
            SnapshotIds = $rawObject.snapshot_ids
            Image = $rawObject.image | ConvertTo-DigitalOceanImage
            VolumeIds = $rawObject.volume_ids
            Size = $rawObject.size
            SizeSlug = $rawObject.size_slug
            Networks = $rawObject.networks
            Region = $rawObject.region
            Tags = $rawObject.tags
        }
    }
    
    end {
    }
}