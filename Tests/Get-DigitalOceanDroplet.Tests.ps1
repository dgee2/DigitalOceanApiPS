Import-Module $PSScriptRoot/../Module/DigitalOceanApi.psd1

InModuleScope DigitalOceanApi {
    $id = 36804636
    $testDroplet = @{
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
    $testResponse = @{
        droplet = @(
            $testDroplet
        )
    }
    $testListResponse = @{
        droplets = @(
        $testDroplet
        )
        links = @{
        pages = @{
            last = 'https://api.digitalocean.com/v2/droplets?page=159&per_page=1'
            next = 'https://api.digitalocean.com/v2/droplets?page=2&per_page=1'
        }
        }
        meta = @{
            total = 159
        }
    }
    $testToken = "$((new-guid).guid -replace @('-',''))$((new-guid).guid -replace @('-',''))"
    Describe 'Get-DigitalOceanDroplet' {
        Context 'ID Parameter Set' {
            Mock Invoke-DigitalOceanApiCall -MockWith {$testResponse}
            Context 'Request'{
                Get-DigitalOceanDroplet -Token $testToken -Id $id
                It 'Passes the correct token'{
                    Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Token -eq $testToken }
                }
                It 'Sends to the correct url'{
                    Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq "droplets/$id" }
                }
            }
            Context 'Response' {
                $response = Get-DigitalOceanDroplet -Token $testToken -Id $id

                It 'Parses Id correctly'{
                    $response.Id | Should -Be $testDroplet.id
                }
            }
        }
        Context 'Default Parameter Set' {
            Mock Invoke-DigitalOceanApiCall -MockWith {$testListResponse}
            Context 'Request'{
                Get-DigitalOceanDroplet -Token $testToken
                It 'Passes the correct token'{
                    Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Token -eq $testToken }
                }
                It 'Sends to the correct url'{
                    Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq 'droplets' }
                }
                Context 'Paging'{
                    It 'Calls correct url for page'{
                        Get-DigitalOceanDroplet -Token $testToken -Page 15
                        Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq 'droplets?page=15' }
                    }
                    It 'Calls correct url for per page'{
                        Get-DigitalOceanDroplet -Token $testToken -PerPage 23
                        Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq 'droplets?per_page=23' }
                    }
                    It 'Calls correct url for per page and page'{
                        Get-DigitalOceanDroplet -Token $testToken -Page 15 -PerPage 23
                        Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq 'droplets?page=15&per_page=23' }
                    }
                }
            }
            Context 'Response' {
            $response = Get-DigitalOceanDroplet -Token $testToken
    
                Context 'Droplets'{
                    It 'Contains the correct number'{
                        ($response.Droplets | Measure-Object).Count | Should -Be 1
                    }
                    It 'Parses Id correctly'{
                        $response.Droplets[0].Id | Should -Be $testDroplet.id
                    }
                }
                Context 'TotalCount'{
                    It 'Parses TotalCount correctly'{
                        $response.TotalCount | Should -Be $testListResponse.meta.total
                    }
                }
            }
        }
    }
}