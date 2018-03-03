Import-Module $PSScriptRoot/../Module/DigitalOceanApi.psd1

$expectedCommands = @(
    'Get-DigitalOceanAccount'
    'Get-DigitalOceanAction'
    'Get-DigitalOceanDroplet'
    'Get-DigitalOceanImage'
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
