function Get-DigitalOceanImage {
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
         [Parameter(Mandatory=$false,ParameterSetName='Slug')]
         [string]
         $Slug,
         # Parameter help description
         [Parameter(Mandatory=$false,ParameterSetName='Paging')]
         [int]
         $Page,
         # Parameter help description
         [Parameter(Mandatory=$false,ParameterSetName='Paging')]
         [int]
         $PerPage,
         # Parameter help description
         [ValidateSet('distribution','application', IgnoreCase=$false)]
         [Parameter(Mandatory=$false,ParameterSetName='Default')]
         [Parameter(Mandatory=$false,ParameterSetName='Paging')]
         [string]
         $Type,
         # Parameter help description
         [Parameter(Mandatory=$false,ParameterSetName='Default')]
         [Parameter(Mandatory=$false,ParameterSetName='Paging')]
         [switch]
         $Private
    )
    
    begin {
    }
    
    process {
        $uri = "images"
        if($PSCmdlet.ParameterSetName -eq 'ID'){
            $uri += "/$Id"
        }
        if($PSCmdlet.ParameterSetName -eq 'Slug'){
            $uri += "/$Slug"
        }

        $query = @{}

        if($PSCmdlet.ParameterSetName -eq 'Paging') {
            if ($Page -gt 0) {
                $query.page = $Page
            }
            if ($PerPage -gt 0) {
                $query.per_page = $PerPage
            }
        }
        
        if($Type -ne $null -and $Type.Length -gt 0) {
            $query.type = $Type
        }

        if($Private){
            $query.private = $true
        }

        if($query.Count -gt 0) {
            $uri += '?' + (($query.Keys | ForEach-Object { [uri]::EscapeDataString($_) + '=' + [uri]::EscapeDataString($query.$_) }) -join '&')
        }
        $response = Invoke-DigitalOceanApiCall -Token $Token -Url $uri
        
        if($PSCmdlet.ParameterSetName -eq 'ID' -or $PSCmdlet.ParameterSetName -eq 'Slug'){
            $response.image | ConvertTo-DigitalOceanImage
        } else {
            $images = $response.images | ConvertTo-DigitalOceanImage

            $properties = @{
                Images = $images
                TotalCount = $response.meta.total
            }

            New-Object PSObject -Property $properties
        }
    }
    
    end {
    }
}