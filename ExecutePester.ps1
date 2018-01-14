param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]
    $BuildSourcesDirectory
)

Install-Module -Name Pester -Force -Scope CurrentUser -SkipPublisherCheck
Install-Module -Name PSScriptAnalyzer -Force -Scope CurrentUser

$scriptFolder = "$BuildSourcesDirectory"
$CodeCoverageOutputFile = "$BuildSourcesDirectory\CodeCoverage-Pester.XML"
$resultsFile = "$BuildSourcesDirectory\Test-Pester.XML"

 $Files = Get-ChildItem -Path $scriptFolder -include *.ps1, *.psm1 -Exclude *.Tests.ps1, ExecutePester.ps1, ModuleLoader.ps1 -Recurse | Select-object -ExpandProperty Fullname

Invoke-Pester -OutputFile $resultsFile -OutputFormat 'NUnitXml' -Script $scriptFolder -CodeCoverage $Files -CodeCoverageOutputFile $CodeCoverageOutputFile -EnableExit