Describe 'PSScriptAnalyzer' {
       Context 'Standard Rules' {
        $analysis = Invoke-ScriptAnalyzer -Path $PSScriptRoot/../Scripts -IncludeDefaultRules -Recurse
        $scriptAnalyzerRules = Get-ScriptAnalyzerRule
 
        forEach ($rule in $scriptAnalyzerRules) {
            It $rule {
                If ($analysis.RuleName -contains $rule) {
                    $analysis |
                         Where-Object RuleName -EQ $rule -OutVariable failures |
                         Out-Default
                    $failures.Count | Should Be 0
                }
            }
        }
    }
}