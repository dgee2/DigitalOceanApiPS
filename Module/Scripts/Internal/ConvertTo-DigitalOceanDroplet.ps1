function ConvertTo-DigitalOceanDroplet {
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
        $ret = [DigitalOceanDroplet]::new()

        $ret
    }
    
    end {
    }
}