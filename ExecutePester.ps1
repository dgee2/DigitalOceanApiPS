Install-Module -Name Pester -Force -Scope CurrentUser -SkipPublisherCheck
Install-Module -Name PSScriptAnalyzer -Force -Scope CurrentUser

$scriptFolder = "$(Build.SourcesDirectory)"
$CodeCoverageOutputFile = "$(Build.SourcesDirectory)\CodeCoverage-Pester.XML"
$resultsFile = "$(Build.SourcesDirectory)\Test-Pester.XML"

$Parameters = @{
    OutputFile = $resultsFile
    OutputFormat = 'NUnitXml'
    Script = $scriptFolder
}

 $Files = Get-ChildItem -Path $scriptFolder -include *.ps1, *.psm1 -Exclude *.Tests.ps1 -Recurse | Select-object -ExpandProperty Fullname

if ($Files) {
    $Parameters.Add('CodeCoverage', $Files)
    $Parameters.Add('CodeCoverageOutputFile', $CodeCoverageOutputFile)
} else {
    Write-Warning -Message "No PowerShell files found under $scriptFolder to analyse for code coverage."
}

Invoke-Pester @Parameters