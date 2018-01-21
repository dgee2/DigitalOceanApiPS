param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]
    $BuildSourcesDirectory
)

Install-Module -Name Pester -Force -Scope CurrentUser -SkipPublisherCheck

$Files = Get-ChildItem -Path "$PSScriptRoot\..\Module" -include *.ps1, *.psm1 -Recurse | Select-object -ExpandProperty Fullname

Write-Output "Files to use for code coverage:"
$files | Write-Output

$parameters = @{
    OutputFile="$BuildSourcesDirectory\Test-Pester.XML";
    CodeCoverage = $Files;
    CodeCoverageOutputFile = "$BuildSourcesDirectory\CodeCoverage-Pester.XML";
    ExcludeTag = 'PSScriptAnalyzer';
    Script = "$PSScriptRoot\..\Tests";
    EnableExit = $true;
}

# Unit Tests
Invoke-Pester @parameters
