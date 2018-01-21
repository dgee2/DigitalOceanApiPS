. $PSScriptRoot/../../Module/Scripts/Internal/Invoke-DigitalOceanApiCall.ps1
$rawObject = @{
    test = 'testing';
}
$testToken = "$((new-guid).guid -replace @('-',''))$((new-guid).guid -replace @('-',''))"
$url = "account"
Describe 'Invoke-DigitalOceanApiCall' {
        Mock Invoke-RestMethod -MockWith {$rawObject}
        Context 'Request'{
            Invoke-DigitalOceanApiCall -Token $testToken -Url $url
            It 'Passes the authorization header'{
                Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter { $headers.Keys -contains 'Authorization' -and $headers.Authorization -eq "Bearer $testToken"}
            }
            It 'Sends to the correct url'{
                Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter { $uri -eq "https://api.digitalocean.com/v2/$url" }
            }
        }
        Context 'Response' {
            $response = Invoke-DigitalOceanApiCall -Token $testToken -Url $url
            It 'Returns the raw response object' {
                $response | Should -BeExactly $rawObject
            }
        }
}
