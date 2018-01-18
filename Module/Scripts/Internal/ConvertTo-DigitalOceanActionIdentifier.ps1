function ConvertTo-DigitalOceanActionIdentifier {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)]
        [System.Collections.Hashtable]
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