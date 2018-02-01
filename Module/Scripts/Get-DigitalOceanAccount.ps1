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

        $ret = [DigitalOceanAccount]::new()
        $ret.DropletLimit = $account.droplet_limit
        $ret.FloatingIpLimit = $account.floating_ip_limit
        $ret.Email = $account.email
        $ret.UUID = $account.uuid
        $ret.EmailVerified = $account.email_verified
        $ret.Status = $account.status
        $ret.StatusMessage = $account.status_message

        $ret
    }
    
    end {
    }
}
