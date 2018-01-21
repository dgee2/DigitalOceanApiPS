function Invoke-DigitalOceanApiCall {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory=$true)]
        [string]
        $Token,
        # Parameter help description
        [Parameter(Mandatory=$true)]
        [string]
        $Url,
        # Parameter help description
        [Parameter(Mandatory=$false)]
        [string]
        $BaseUri = "https://api.digitalocean.com/v2/"
    )
    
    begin {
    }
    
    process {
        $headers = @{ 
            "Authorization" =  "Bearer $Token"
            "Content-Type" = "application/json"
        }
        Invoke-RestMethod -Headers $headers ($BaseUri + $Url)
    }
    
    end {
    }
}