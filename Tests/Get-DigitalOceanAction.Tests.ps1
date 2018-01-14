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
 $testListResponse = @{
    actions = @(
       $testAction
    )
    links = @{
       pages = @{
           last = 'https://api.digitalocean.com/v2/actions?page=159&per_page=1'
           next = 'https://api.digitalocean.com/v2/actions?page=2&per_page=1'
       }
    }
    meta = @{
        total = 159
    }
}
$testToken = "$((new-guid).guid -replace @('-',''))$((new-guid).guid -replace @('-',''))"

Describe 'Get-DigitalOceanAction' {
    Describe 'ID Parameter Set' {
        Mock Invoke-RestMethod -ParameterFilter {$uri -eq "https://api.digitalocean.com/v2/actions/$id"} -MockWith {$testResponse}
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
    Describe 'Default Parameter Set' {
        Mock Invoke-RestMethod -MockWith {$testListResponse}
        Context 'Request'{
                Get-DigitalOceanAction -Token $testToken
                It 'Passes the authorization header'{
                    Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter { $headers.Keys -contains 'Authorization' -and $headers.Authorization -eq "Bearer $testToken"}
                }
                It 'Sends to the correct url'{
                    Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter { $uri -eq 'https://api.digitalocean.com/v2/actions' }
                }
            Context 'Paging'{
                It 'Calls correct url for page'{
                    Get-DigitalOceanAction -Token $testToken -Page 15
                    Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter { $uri -eq 'https://api.digitalocean.com/v2/actions?page=15' }
                }
                It 'Calls correct url for per page'{
                    Get-DigitalOceanAction -Token $testToken -PerPage 23
                    Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter { $uri -eq 'https://api.digitalocean.com/v2/actions?per_page=23' }
                }
                It 'Calls correct url for per page and page'{
                    Get-DigitalOceanAction -Token $testToken -Page 15 -PerPage 23
                    Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter { $uri -eq 'https://api.digitalocean.com/v2/actions?page=15&per_page=23' }
                }
            }
        }
        Context 'Response' {
           $response = Get-DigitalOceanAction -Token $testToken
   
            Context 'Actions'{
                It 'Contains the correct number'{
                    ($response.Actions | Measure-Object).Count | Should -Be 1
                }
                It 'Parses Id correctly'{
                    $response.Actions[0].Id | Should -Be $testAction.id
                }
                It 'Parses Status correctly'{
                    $response.Actions[0].Status | Should -Be $testAction.status
                }
                It 'Parses Type correctly'{
                    $response.Actions[0].Type | Should -Be $testAction.type
                }
                It 'Parses StartedAt correctly'{
                    $response.Actions[0].StartedAt | Should -Be ([datetime]$testAction.started_at)
                }
                It 'Parses CompletedAt correctly'{
                    $response.Actions[0].CompletedAt | Should -Be ([datetime]$testAction.completed_at)
                }
                It 'Parses ResourceId correctly'{
                    $response.Actions[0].ResourceId | Should -Be $testAction.resource_id
                }
                It 'Parses ResourceType correctly'{
                    $response.Actions[0].ResourceType | Should -Be $testAction.resource_type
                }
                It 'Parses Region correctly'{
                    $response.Actions[0].Region | Should -Be $testAction.region_slug
                }
            }
            Context 'TotalCount'{
                It 'Parses TotalCount correctly'{
                    $response.TotalCount | Should -Be $testListResponse.meta.total
                }
            }
        }
    }
}
