param (
    # Parameter help description
    [Parameter(Mandatory=$true)]
    [string]
    $BuildSourcesDirectory
)

Install-Module -Name Pester -Force -Scope CurrentUser -SkipPublisherCheck

$Files = Get-ChildItem -Path $scriptFolder -include *.ps1, *.psm1 -Exclude *.Tests.ps1, ExecutePester.ps1, ModuleLoader.ps1 -Recurse | Select-object -ExpandProperty Fullname

# Unit Tests
Invoke-Pester -OutputFile "$BuildSourcesDirectory\Test-Pester.XML" -OutputFormat 'NUnitXml' -Script $BuildSourcesDirectory -CodeCoverage $Files -CodeCoverageOutputFile "$BuildSourcesDirectory\CodeCoverage-Pester.XML" -ExcludeTag 'PSScriptAnalyzer' -EnableExit
