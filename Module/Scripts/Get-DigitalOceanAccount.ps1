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
        $response = Invoke-DigitalOceanApiCall -Token $Token -Url "account"
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
