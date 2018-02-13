function ConvertTo-DigitalOceanAction {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [PSCustomObject]
        $rawObject
    )
    
    begin {
    }
    
    process {
        $ret = [DigitalOceanAction]::new()
        $ret.Id = $rawObject.id
        $ret.Status = $rawObject.status
        $ret.Type = $rawObject.type
        $ret.StartedAt = [datetime]$rawObject.started_at
        $ret.CompletedAt = [datetime]$rawObject.completed_at
        $ret.ResourceId = $rawObject.resource_id
        $ret.ResourceType = $rawObject.resource_type
        $ret.Region = $rawObject.region_slug

        $ret
    }
    
    end {
    }
}