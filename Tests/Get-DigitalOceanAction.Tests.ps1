. $PSScriptRoot/../ModuleLoader.ps1

$id = 36804636
$testAction = @{
    id = $id
    status = 'completed'
    type = 'create'
    started_at = '2014-11-14T16:29:21Z'
    completed_at = '2014-11-14T16:30:06Z'
    resource_id = 3164444
    resource_type = 'droplet'
    region = 'nyc3'
    region_slug = 'nyc3'
}
$testResponse = @{
 	action = @(
        $testAction
    )
 }
$testToken = "$((new-guid).guid -replace @('-',''))$((new-guid).guid -replace @('-',''))"

Describe 'Get-DigitalOceanAction' {
 	Mock Invoke-RestMethod -MockWith {$testResponse}
 	Context 'Request'{
 	 	Get-DigitalOceanAction -Token $testToken -Id $id
 	 	It 'Passes the authorization header'{
 	 	 	Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter { $headers.Keys -contains 'Authorization' -and $headers.Authorization -eq "Bearer $testToken"}
 	 	}
 	 	It 'Sends to the correct url'{
 	 	 	Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter { $uri -eq "https://api.digitalocean.com/v2/actions/$id" }
 	 	}
    }
 	Context 'Response' {
        $response = Get-DigitalOceanAction -Token $testToken -Id $id

        It 'Parses Id correctly'{
            $response.Id | Should -Be $testAction.id
        }
        It 'Parses Status correctly'{
            $response.Status | Should -Be $testAction.status
        }
        It 'Parses Type correctly'{
            $response.Type | Should -Be $testAction.type
        }
        It 'Parses StartedAt correctly'{
            $response.StartedAt | Should -Be ([datetime]$testAction.started_at)
        }
        It 'Parses CompletedAt correctly'{
            $response.CompletedAt | Should -Be ([datetime]$testAction.completed_at)
        }
        It 'Parses ResourceId correctly'{
            $response.ResourceId | Should -Be $testAction.resource_id
        }
        It 'Parses ResourceType correctly'{
            $response.ResourceType | Should -Be $testAction.resource_type
        }
        It 'Parses Region correctly'{
            $response.Region | Should -Be $testAction.region_slug
        }
 	}
}
