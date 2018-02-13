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
        $ret = [DigitalOceanDroplet]::new()
        $ret.Id = $rawObject.id
        $ret.Name = $rawObject.name
        $ret.Memory = $rawObject.memory
        $ret.VCPUs = $rawObject.vcpus
        $ret.DiskSize = $rawObject.disk
        $ret.Locked = $rawObject.locked
        $ret.Status = $rawObject.status
        $ret.Kernel = $rawObject.kernel
        $ret.CreatedAt = [datetime]$rawObject.created_at
        $ret.Features = $rawObject.features
        $ret.BackupIds = $rawObject.backup_ids
        $ret.SnapshotIds = $rawObject.snapshot_ids
        $ret.Image = $rawObject.image
        $ret.VolumeIds = $rawObject.volume_ids
        $ret.Size = $rawObject.size
        $ret.SizeSlug = $rawObject.size_slug
        $ret.Networks = $rawObject.networks
        $ret.Region = $rawObject.region
        $ret.Tags = $rawObject.tags
        $ret
    }
    
    end {
    }
}