param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]
    $BuildSourcesDirectory
)

Install-Module -Name Pester -Force -Scope CurrentUser -SkipPublisherCheck
Install-Module -Name PSScriptAnalyzer -Force -Scope CurrentUser

$parameters = @{
    OutputFile="$BuildSourcesDirectory\Test-PSScriptAnalyzer.XML";
    Tag = 'PSScriptAnalyzer';
    Script = "$PSScriptRoot\..\Tests";
    EnableExit = $true;
}

# PSScriptAnalyzer Tests
Invoke-Pester @parameters
