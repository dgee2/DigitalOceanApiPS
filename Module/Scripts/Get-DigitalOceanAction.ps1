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
        $uri = "actions"
        if($PSCmdlet.ParameterSetName -eq 'ID'){
            $uri += "/$Id"
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

        $response = Invoke-DigitalOceanApiCall -Token $Token -Url $uri

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
