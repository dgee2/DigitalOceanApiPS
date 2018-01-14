. $PSScriptRoot/Internal/ConvertTo-DigitalOceanAction.ps1

function Get-DigitalOceanAction {
    [CmdletBinding(DefaultParameterSetName='Default')]
    param (
        # Parameter help description
        [Parameter(Mandatory=$true)]
        [string]
        $Token,
        # Parameter help description
        [Parameter(Mandatory=$false,ParameterSetName='ID')]
        [int]
        $Id,
        # Parameter help description
        [Parameter(Mandatory=$false,ParameterSetName='Paging')]
        [int]
        $Page,
        # Parameter help description
        [Parameter(Mandatory=$false,ParameterSetName='Paging')]
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

        if($PSCmdlet.ParameterSetName -eq 'ID'){
            $uri = "https://api.digitalocean.com/v2/actions/$Id"
        } else {
            $uri = "https://api.digitalocean.com/v2/actions"
        }

        $query = @{}

        if($PSCmdlet.ParameterSetName -eq 'Paging') {
            if ($Page -gt 0) {
                $query.page = $Page
            }
            if ($PerPage -gt 0) {
                $query.per_page = $PerPage
            }
            if($query.Count -gt 0) {
                $uri += '?' + (($query.Keys | ForEach-Object { [uri]::EscapeDataString($_) + '=' + [uri]::EscapeDataString($query.$_) }) -join '&')
            }
        }

        $response = Invoke-RestMethod -Headers $headers $uri

        if($PSCmdlet.ParameterSetName -eq 'ID'){
            $response.action | ConvertTo-DigitalOceanAction
        } else {
            $actions = $response.actions | ConvertTo-DigitalOceanAction

            $properties = @{
                Actions = $actions
                TotalCount = $response.meta.total
            }

            New-Object PSObject -Property $properties
        }
    }
    
    end {
    }
}
