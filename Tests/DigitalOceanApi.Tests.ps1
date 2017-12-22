Import-Module $PSScriptRoot/../DigitalOceanApi.psm1

$expectedCommands = @(
    'Get-DigitalOceanAccount'
)

Describe 'DigitalOceanApi Module' {
        $expectedCommands | ForEach-Object {
        Context $_ {
            It 'Exists in module'{
                $_ | Should -BeIn (Get-Module DigitalOceanApi).ExportedCommands.Keys
            }
        }
    }
}