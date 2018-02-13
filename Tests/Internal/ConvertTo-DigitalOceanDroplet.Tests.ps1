Import-Module $PSScriptRoot/../../Module/DigitalOceanApi.psd1
. $PSScriptRoot/../../Module/Scripts/Internal/ConvertTo-DigitalOceanDroplet.ps1
$rawObject = @{
    id = 3164494
    name = 'example.com'
    memory = 1024
    vcpus = 1
    disk = 25
    locked = $true
    status = 'active'
    kernel = @{
        id = 2233
        name = 'Ubuntu 14.04 x64 vmlinuz-3.13.0-37-generic'
        version = '3.13.0-37-generic'
    }
    created_at = '2014-11-14T16:36:31Z'
    features = @(
        'ipv6',
        'virtio'
    )
    backup_ids = @(
        7938654
    )
    snapshot_ids = @(
        7938206
    )
    image = @{
        id = 6918990
        name = '14.04 x64'
        distribution = 'Ubuntu'
        slug = 'ubuntu-16-04-x64'
        public = $true
        regions = @(
            'nyc1',
            'ams1',
            'sfo1',
            'nyc2',
            'ams2',
            'sgp1',
            'lon1',
            'nyc3',
            'ams3',
            'nyc3'
        )
        created_at = '2014-10-17T20:24:33Z'
        type = 'snapshot'
        min_disk_size = 20
        size_gigabytes = 2.34
    }
    volume_ids = @(
        9876545,
        3216548
    )
    size = @{
    }
    size_slug = 's-1vcpu-1gb'
    networks = @{
        v4 = @(
            @{
                ip_address = '104.131.186.241'
                netmask = '255.255.240.0'
                gateway = '104.131.176.1'
                type = 'public'
            }
        )
        v6 = @(
            @{
                ip_address = '2604:A880:0800:0010:0000:0000:031D:2001'
                netmask = 64
                gateway = '2604:A880:0800:0010:0000:0000:0000:0001'
                type = 'public'
            }
        )
    }
    region = @{
        name = 'New York 3'
        slug = 'nyc3'
        sizes = @(
            's-1vcpu-1gb',
            's-1vcpu-2gb',
            's-1vcpu-3gb',
            's-2vcpu-2gb',
            's-3vcpu-1gb',
            's-2vcpu-4gb',
            's-4vcpu-8gb',
            's-6vcpu-16gb',
            's-8vcpu-32gb',
            's-12vcpu-48gb',
            's-16vcpu-64gb',
            's-20vcpu-96gb',
            's-24vcpu-128gb',
            's-32vcpu-192gb'
        )
        features = @(
            'virtio',
            'private_networking',
            'backups',
            'ipv6',
            'metadata'
        )
        available = $true
    }
    tags = @(
        'Hello world 1',
        'Hello 2'
    )
}
Describe 'ConvertTo-DigitalOceanDroplet' {
    Context 'Passed Single rawObject'{
        $result = ConvertTo-DigitalOceanDroplet $rawObject

        It 'Returns a DigitalOceanDroplet instance'{
            $result.GetType() | Should -Be 'DigitalOceanDroplet'
        }
        It 'Parses Id correctly'{
            $result.Id | Should -Be $rawObject.id
        }
        It 'Parses Name correctly'{
            $result.Name | Should -Be $rawObject.name
        }
        It 'Parses Memory correctly'{
            $result.Memory | Should -Be $rawObject.memory
        }
        It 'Parses VCPUs correctly'{
            $result.VCPUs | Should -Be $rawObject.vcpus
        }
        It 'Parses DiskSize correctly'{
            $result.DiskSize | Should -Be $rawObject.disk
        }
        It 'Parses Locked correctly'{
            $result.Locked | Should -Be $rawObject.locked
        }
        It 'Parses Status correctly'{
            $result.Status | Should -Be $rawObject.status
        }
        It 'Parses Kernel correctly'{
            $result.Kernel | Should -Be $rawObject.kernel
        }
        It 'CreatedAt to DateTime'{
            $result.CreatedAt.GetType() | Should -Be 'DateTime'
        }
        It 'Parses CreatedAt correctly'{
            $result.CreatedAt | Should -Be ([datetime]$rawObject.created_at)
        }
        It 'Parses Features correctly'{
            $result.Features | Should -Be $rawObject.features
        }
        It 'Parses BackupIds correctly'{
            $result.BackupIds | Should -Be $rawObject.backup_ids
        }
        It 'Parses SnapshotIds correctly'{
            $result.SnapshotIds | Should -Be $rawObject.snapshot_ids
        }
        It 'Parses Image correctly'{
            $result.Image | Should -Be $rawObject.image
        }
        It 'Parses VolumeIds correctly'{
            $result.VolumeIds | Should -Be $rawObject.volume_ids
        }
        It 'Parses Size correctly'{
            $result.Size | Should -Be $rawObject.size
        }
        It 'Parses SizeSlug correctly'{
            $result.SizeSlug | Should -Be $rawObject.size_slug
        }
        It 'Parses Networks correctly'{
            $result.Networks | Should -Be $rawObject.networks
        }
        It 'Parses Region correctly'{
            $result.Region | Should -Be $rawObject.region
        }
        It 'Parses Tags correctly'{
            $result.Tags | Should -Be $rawObject.tags
        }
    }
    Context 'Passed pipeline rawObject'{
        $result = $rawObject | ConvertTo-DigitalOceanDroplet

        It 'Returns a DigitalOceanDroplet instance'{
            $result.GetType() | Should -Be 'DigitalOceanDroplet'
        }
        It 'Parses Id correctly'{
            $result.Id | Should -Be $rawObject.id
        }
        It 'Parses Name correctly'{
            $result.Name | Should -Be $rawObject.name
        }
        It 'Parses Memory correctly'{
            $result.Memory | Should -Be $rawObject.memory
        }
        It 'Parses VCPUs correctly'{
            $result.VCPUs | Should -Be $rawObject.vcpus
        }
        It 'Parses DiskSize correctly'{
            $result.DiskSize | Should -Be $rawObject.disk
        }
        It 'Parses Locked correctly'{
            $result.Locked | Should -Be $rawObject.locked
        }
        It 'Parses Status correctly'{
            $result.Status | Should -Be $rawObject.status
        }
        It 'Parses Kernel correctly'{
            $result.Kernel | Should -Be $rawObject.kernel
        }
        It 'CreatedAt to DateTime'{
            $result.CreatedAt.GetType() | Should -Be 'DateTime'
        }
        It 'Parses CreatedAt correctly'{
            $result.CreatedAt | Should -Be ([datetime]$rawObject.created_at)
        }
        It 'Parses Features correctly'{
            $result.Features | Should -Be $rawObject.features
        }
        It 'Parses BackupIds correctly'{
            $result.BackupIds | Should -Be $rawObject.backup_ids
        }
        It 'Parses SnapshotIds correctly'{
            $result.SnapshotIds | Should -Be $rawObject.snapshot_ids
        }
        It 'Parses Image correctly'{
            $result.Image | Should -Be $rawObject.image
        }
        It 'Parses VolumeIds correctly'{
            $result.VolumeIds | Should -Be $rawObject.volume_ids
        }
        It 'Parses Size correctly'{
            $result.Size | Should -Be $rawObject.size
        }
        It 'Parses SizeSlug correctly'{
            $result.SizeSlug | Should -Be $rawObject.size_slug
        }
        It 'Parses Networks correctly'{
            $result.Networks | Should -Be $rawObject.networks
        }
        It 'Parses Region correctly'{
            $result.Region | Should -Be $rawObject.region
        }
        It 'Parses Tags correctly'{
            $result.Tags | Should -Be $rawObject.tags
        }
    }
}
