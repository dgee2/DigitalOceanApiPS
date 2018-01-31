function Get-DigitalOceanDroplet {
    [CmdletBinding()]
    param (
         # Parameter help description
         [Parameter(Mandatory=$true)]
         [string]
         $Token,
         # Parameter help description
         [Parameter(Mandatory=$true)]
         [int]
         $Id
    )
    
    begin {
    }
    
    process {
        $response = Invoke-DigitalOceanApiCall -Token $Token -Url "droplets/$Id"
        $response.droplet
    }
    
    end {
    }
}