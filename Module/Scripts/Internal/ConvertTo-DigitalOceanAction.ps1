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
        New-Object PSObject -Property @{
            Id = $rawObject.id
            Status = $rawObject.status
            Type = $rawObject.type
            StartedAt = [datetime]$rawObject.started_at
            CompletedAt = [datetime]$rawObject.completed_at
            ResourceId = $rawObject.resource_id
            ResourceType = $rawObject.resource_type
            Region = $rawObject.region_slug
        }
    }
    
    end {
    }
}