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
        $ret = [DigitalOceanActionIdentifier]::new()
        $ret.Id = $rawObject.id
        $ret.Type = $rawObject.rel

        $ret
    }
    end {
    }
}