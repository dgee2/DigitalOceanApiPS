function ConvertTo-DigitalOceanImage {
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
        $ret = [DigitalOceanImage]::new()
        $ret.Id = $rawObject.id

        $ret
    }
    end {
    }
}