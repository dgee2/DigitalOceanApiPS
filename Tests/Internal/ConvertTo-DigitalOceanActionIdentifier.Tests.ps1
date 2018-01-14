. $PSScriptRoot/../../Scripts/Internal/ConvertTo-DigitalOceanActionIdentifier.ps1
$rawObject = @{
    id = 36805096
    rel = "create"
    href = "https://api.digitalocean.com/v2/actions/36805096"
}
Describe 'ConvertTo-DigitalOceanActionIdentifier' {
    Context 'Passed Single rawObject'{
        $result = ConvertTo-DigitalOceanActionIdentifier $rawObject

        It 'Parses Id correctly'{
            $result.Id | Should -Be $rawObject.id
        }
        It 'Parses Type correctly'{
            $result.Type | Should -Be $rawObject.rel
        }
    }
    Context 'Passed pipeline rawObject'{
        $result = $rawObject | ConvertTo-DigitalOceanActionIdentifier

        It 'Parses Id correctly'{
            $result.Id | Should -Be $rawObject.id
        }
        It 'Parses Type correctly'{
            $result.Type | Should -Be $rawObject.rel
        }
    }
}
