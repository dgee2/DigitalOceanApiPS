. $PSScriptRoot/Internal/ConvertTo-DigitalOceanAction.ps1

function Get-DigitalOceanAction {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory=$true)]
        [string]
        $Token,
        # Parameter help description
        [Parameter(Mandatory=$false)]
        [int]
        $Id
    )
    
    begin {
    }
    
    process {
        $headers = @{ 
            "Authorization" =  "Bearer $Token"
            "Content-Type" = "application/json"
        }

        $uri = "https://api.digitalocean.com/v2/actions/$Id"

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

        $response.action | ConvertTo-DigitalOceanAction
    }
    
    end {
    }
}
