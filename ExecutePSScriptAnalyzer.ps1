param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]
    $BuildSourcesDirectory
)

Install-Module -Name Pester -Force -Scope CurrentUser -SkipPublisherCheck
Install-Module -Name PSScriptAnalyzer -Force -Scope CurrentUser

# PSScriptAnalyzer Tests
Invoke-Pester -OutputFile "$BuildSourcesDirectory\Test-PSScriptAnalyzer.XML" -OutputFormat 'NUnitXml' -Script $BuildSourcesDirectory -Tag 'PSScriptAnalyzer' -EnableExit