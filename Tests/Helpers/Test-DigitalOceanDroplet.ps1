. $PSScriptRoot/Test-DigitalOceanImage.ps1
function Test-DigitalOceanDroplet {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        $DigitalOceanDroplet,
        # Parameter help description
        [Parameter(Mandatory)]
        $RawObject
    )
    
    begin {
    }
    
    process {
        It 'Parses Id correctly'{
            $DigitalOceanDroplet.Id | Should -Be $RawObject.id
        }
        It 'Parses Name correctly'{
            $DigitalOceanDroplet.Name | Should -Be $RawObject.name
        }
        It 'Parses Memory correctly'{
            $DigitalOceanDroplet.Memory | Should -Be $RawObject.memory
        }
        It 'Parses VCPUs correctly'{
            $DigitalOceanDroplet.VCPUs | Should -Be $RawObject.vcpus
        }
        It 'Parses DiskSize correctly'{
            $DigitalOceanDroplet.DiskSize | Should -Be $RawObject.disk
        }
        It 'Parses Locked correctly'{
            $DigitalOceanDroplet.Locked | Should -Be $RawObject.locked
        }
        It 'Parses Status correctly'{
            $DigitalOceanDroplet.Status | Should -Be $RawObject.status
        }
        It 'Parses Kernel correctly'{
            $DigitalOceanDroplet.Kernel | Should -Be $RawObject.kernel
        }
        It 'CreatedAt to DateTime'{
            $DigitalOceanDroplet.CreatedAt.GetType() | Should -Be 'DateTime'
        }
        It 'Parses CreatedAt correctly'{
            $DigitalOceanDroplet.CreatedAt | Should -Be ([datetime]$RawObject.created_at)
        }
        It 'Parses Features correctly'{
            $DigitalOceanDroplet.Features | Should -Be $RawObject.features
        }
        It 'Parses BackupIds correctly'{
            $DigitalOceanDroplet.BackupIds | Should -Be $RawObject.backup_ids
        }
        It 'Parses SnapshotIds correctly'{
            $DigitalOceanDroplet.SnapshotIds | Should -Be $RawObject.snapshot_ids
        }
        Context 'Parses Image correctly'{
            $DigitalOceanDroplet.Image | Test-DigitalOceanImage -RawObject $RawObject.image
        }
        It 'Parses VolumeIds correctly'{
            $DigitalOceanDroplet.VolumeIds | Should -Be $RawObject.volume_ids
        }
        It 'Parses Size correctly'{
            $DigitalOceanDroplet.Size | Should -Be $RawObject.size
        }
        It 'Parses SizeSlug correctly'{
            $DigitalOceanDroplet.SizeSlug | Should -Be $RawObject.size_slug
        }
        It 'Parses Networks correctly'{
            $DigitalOceanDroplet.Networks | Should -Be $RawObject.networks
        }
        It 'Parses Region correctly'{
            $DigitalOceanDroplet.Region | Should -Be $RawObject.region
        }
        It 'Parses Tags correctly'{
            $DigitalOceanDroplet.Tags | Should -Be $RawObject.tags
        }
    }
    
    end {
    }
}