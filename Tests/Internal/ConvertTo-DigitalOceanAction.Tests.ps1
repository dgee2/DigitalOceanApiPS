. $PSScriptRoot/../../Module/Scripts/Internal/ConvertTo-DigitalOceanAction.ps1
$rawObject = @{
    id = 36804636
    status = 'completed'
    type = 'create'
    started_at = '2014-11-14T16:29:21Z'
    completed_at = '2014-11-14T16:30:06Z'
    resource_id = 3164444
    resource_type = 'droplet'
    region = 'nyc3'
    region_slug = 'nyc3'
}
Describe 'ConvertTo-DigitalOceanAction' {
    Context 'Passed Single rawObject'{
        $result = ConvertTo-DigitalOceanAction $rawObject

        It 'Parses Id correctly'{
            $result.Id | Should -Be $rawObject.id
        }
        It 'Parses Status correctly'{
            $result.Status | Should -Be $rawObject.status
        }
        It 'Parses Type correctly'{
            $result.Type | Should -Be $rawObject.type
        }
        It 'Parses StartedAt correctly'{
            $result.StartedAt | Should -Be ([datetime]$rawObject.started_at)
        }
        It 'Parses CompletedAt correctly'{
            $result.CompletedAt | Should -Be ([datetime]$rawObject.completed_at)
        }
        It 'Parses ResourceId correctly'{
            $result.ResourceId | Should -Be $rawObject.resource_id
        }
        It 'Parses ResourceType correctly'{
            $result.ResourceType | Should -Be $rawObject.resource_type
        }
        It 'Parses Region correctly'{
            $result.Region | Should -Be $rawObject.region_slug
        }
    }
    Context 'Passed pipeline rawObject'{
        $result = $rawObject | ConvertTo-DigitalOceanAction

        It 'Parses Id correctly'{
            $result.Id | Should -Be $rawObject.id
        }
        It 'Parses Status correctly'{
            $result.Status | Should -Be $rawObject.status
        }
        It 'Parses Type correctly'{
            $result.Type | Should -Be $rawObject.type
        }
        It 'Parses StartedAt correctly'{
            $result.StartedAt | Should -Be ([datetime]$rawObject.started_at)
        }
        It 'Parses CompletedAt correctly'{
            $result.CompletedAt | Should -Be ([datetime]$rawObject.completed_at)
        }
        It 'Parses ResourceId correctly'{
            $result.ResourceId | Should -Be $rawObject.resource_id
        }
        It 'Parses ResourceType correctly'{
            $result.ResourceType | Should -Be $rawObject.resource_type
        }
        It 'Parses Region correctly'{
            $result.Region | Should -Be $rawObject.region_slug
        }
    }
}
