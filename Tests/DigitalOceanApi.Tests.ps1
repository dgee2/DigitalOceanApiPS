Import-Module $PSScriptRoot/../DigitalOceanApi.psm1

$expectedCommands = @(
    'Get-DigitalOceanAccount'
    'Get-DigitalOceanAction'
    'Get-DigitalOceanActions'
)

Describe 'DigitalOceanApi Module' {
        $expectedCommands | ForEach-Object {
        Context $_ {
            It 'Exists in module'{
                $_ | Should -BeIn (Get-Module DigitalOceanApi).ExportedFunctions.Keys
            }
        }
    }
}
