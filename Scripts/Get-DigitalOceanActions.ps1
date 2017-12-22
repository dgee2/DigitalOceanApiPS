function Get-DigitalOceanActions {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory=$true)]
        [string]
        $Token
    )
    
    begin {
    }
    
    process {
        $headers = @{ 
            "Authorization" =  "Bearer $Token"
            "Content-Type" = "application/json"
        }
        $response = Invoke-RestMethod -Headers $headers "https://api.digitalocean.com/v2/actions"

        $actions = $response.actions | ForEach-Object {
            New-Object PSObject -Property @{
                Id = $_.id
                Status = $_.status
                Type = $_.type
                StartedAt = [datetime]$_.started_at
                CompletedAt = [datetime]$_.completed_at
                ResourceId = $_.resource_id
                ResourceType = $_.resource_type
                Region = $_.region_slug
            }
        }

        $properties = @{
            Actions = $actions
        }

        New-Object PSObject -Property $properties
    }
    
    end {
    }
}
