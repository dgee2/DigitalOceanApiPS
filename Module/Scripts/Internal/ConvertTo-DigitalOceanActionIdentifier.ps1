function ConvertTo-DigitalOceanActionIdentifier {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)]
        [PSCustomObject]
        $rawObject
    )
    begin {
    }
    process {
        New-Object PSObject -Property @{
            Id = $rawObject.id
            Type = $rawObject.rel
        }
    }
    end {
    }
}