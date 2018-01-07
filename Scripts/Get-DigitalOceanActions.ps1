. $PSScriptRoot/Internal/ConvertTo-DigitalOceanAction.ps1

function Get-DigitalOceanActions {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory=$true)]
        [string]
        $Token,
        # Parameter help description
        [Parameter(Mandatory=$false)]
        [int]
        $Page,
        # Parameter help description
        [Parameter(Mandatory=$false)]
        [int]
        $PerPage
    )
    
    begin {
    }
    
    process {
        $headers = @{ 
            "Authorization" =  "Bearer $Token"
            "Content-Type" = "application/json"
        }

        $uri = "https://api.digitalocean.com/v2/actions"

        $query = @{}

        if ($Page -gt 0) {
            $query.page = $Page
        }
        if ($PerPage -gt 0) {
            $query.per_page = $PerPage
        }
        if($query.Count -gt 0) {
            $uri += '?' + (($query.Keys | ForEach-Object { [uri]::EscapeDataString($_) + '=' + [uri]::EscapeDataString($query.$_) }) -join '&')
        }

        $response = Invoke-RestMethod -Headers $headers $uri

        $actions = $response.actions | ConvertTo-DigitalOceanAction

        $properties = @{
            Actions = $actions
            TotalCount = $response.meta.total
        }

        New-Object PSObject -Property $properties
    }
    
    end {
    }
}
