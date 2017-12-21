. $PSScriptRoot/../Scripts/Get-DigitalOceanAccount.ps1

$testResponse = @{
    Content = '{"account":{"droplet_limit":25,"floating_ip_limit":3,"email":"test@test.org","uuid":"c94d05974a18ab3e45a706eb9e99d0205bd5gfd4","email_verified":true,"status":"active","status_message":"blah blah"}}'
}
$testToken = "$((new-guid).guid -replace @('-',''))$((new-guid).guid -replace @('-',''))"

Describe 'Get-DigitalOceanAccount' {
    Mock Invoke-WebRequest -MockWith {$testResponse}
    Context 'Request'{
        Get-DigitalOceanAccount -Token $testToken
        It 'Passes the authorization header'{
            Assert-MockCalled Invoke-WebRequest -Exactly 1 -ParameterFilter { $headers.Keys -contains 'Authorization' -and $headers.Authorization -eq "Bearer $testToken"}
        }
        It 'Sends to the correct url'{
            Assert-MockCalled Invoke-WebRequest -Exactly 1 -ParameterFilter { $uri -eq 'https://api.digitalocean.com/v2/account' }
        }
    }
    Context 'Response' {
        $response = Get-DigitalOceanAccount -Token $testToken
        It 'Parses DropletLimit correctly'{
            $response.DropletLimit | Should -Be 25
        }
        It 'Parses FloatingIpLimit correctly'{
            $response.FloatingIpLimit | Should -Be 3
        }
        It 'Parses Email correctly'{
            $response.Email | Should -Be 'test@test.org'
        }
        It 'Parses UUID correctly'{
            $response.UUID | Should -Be 'c94d05974a18ab3e45a706eb9e99d0205bd5gfd4'
        }
        It 'Parses EmailVerified correctly'{
            $response.EmailVerified | Should -Be $true
        }
        It 'Parses Status correctly'{
            $response.Status | Should -Be 'active'
        }
        It 'Parses StatusMessage correctly'{
            $response.StatusMessage | Should -Be 'blah blah'
        }
    }
}