. $PSScriptRoot/../Scripts/Get-DigitalOceanAccount.ps1

$testResponse = @{
    account=@{
        droplet_limit=25
        floating_ip_limit=3
        email="test@test.org"
        uuid="c94d05974a18ab3e45a706eb9e99d0205bd5gfd4"
        email_verified=$true
        status="active"
        status_message="blah blah"
    }
}
$testToken = "$((new-guid).guid -replace @('-',''))$((new-guid).guid -replace @('-',''))"

Describe 'Get-DigitalOceanAccount' {
    Mock Invoke-RestMethod -MockWith {$testResponse}
    Context 'Request'{
        Get-DigitalOceanAccount -Token $testToken
        It 'Passes the authorization header'{
            Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter { $headers.Keys -contains 'Authorization' -and $headers.Authorization -eq "Bearer $testToken"}
        }
        It 'Sends to the correct url'{
            Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter { $uri -eq 'https://api.digitalocean.com/v2/account' }
        }
    }
    Context 'Response' {
        $response = Get-DigitalOceanAccount -Token $testToken
        It 'Parses DropletLimit correctly'{
            $response.DropletLimit | Should -Be $testResponse.account.droplet_limit
        }
        It 'Parses FloatingIpLimit correctly'{
            $response.FloatingIpLimit | Should -Be $testResponse.account.floating_ip_limit
        }
        It 'Parses Email correctly'{
            $response.Email | Should -Be $testResponse.account.email
        }
        It 'Parses UUID correctly'{
            $response.UUID | Should -Be $testResponse.account.uuid
        }
        It 'Parses EmailVerified correctly'{
            $response.EmailVerified | Should -Be $testResponse.account.email_verified
        }
        It 'Parses Status correctly'{
            $response.Status | Should -Be $testResponse.account.status
        }
        It 'Parses StatusMessage correctly'{
            $response.StatusMessage | Should -Be $testResponse.account.status_message
        }
    }
}
