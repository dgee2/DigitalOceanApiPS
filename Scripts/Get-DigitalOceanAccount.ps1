function Get-DigitalOceanAccount {
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
        $response = Invoke-RestMethod -Headers $headers "https://api.digitalocean.com/v2/account"
        $account = $response.account
        New-Object PSObject -Property @{
            DropletLimit = $account.droplet_limit
            FloatingIpLimit = $account.floating_ip_limit
            Email = $account.email
            UUID = $account.uuid
            EmailVerified = $account.email_verified
            Status = $account.status
            StatusMessage = $account.status_message
        }
    }
    
    end {
    }
}