Import-Module $PSScriptRoot/../Module/DigitalOceanApi.psd1

InModuleScope DigitalOceanApi {
    . $PSScriptRoot/Helpers/Test-DigitalOceanImage.ps1

    $id = 6918990
    $testImage = @{
        id = $id
        name = '14.04 x64'
        distribution = 'Ubuntu'
        slug = 'ubuntu-16-04-x64'
        public = $true
        regions = @(
            'nyc1',
            'ams1',
            'sfo1'
        )
        created_at = '2014-10-17T20:24:33Z'
        min_disk_size = 20
        size_gigabytes = 2.34
    }
    
    $testResponse = @{
        image = @(
            $testImage
        )
    }
    $testListResponse = @{
        images = @(
            $testImage
        )
        links = @{
        pages = @{
            last = 'https://api.digitalocean.com/v2/images?page=159&per_page=1'
            next = 'https://api.digitalocean.com/v2/images?page=2&per_page=1'
        }
        }
        meta = @{
            total = 159
        }
    }
    $testToken = "$((new-guid).guid -replace @('-',''))$((new-guid).guid -replace @('-',''))"
    Describe 'Get-DigitalOceanImage' {
        Context 'ID Parameter Set' {
            Mock Invoke-DigitalOceanApiCall -MockWith {$testResponse}
            Context 'Request'{
                Get-DigitalOceanImage -Token $testToken -Id $id
                It 'Passes the correct token'{
                    Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Token -eq $testToken }
                }
                It 'Sends to the correct url'{
                    Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq "images/$id" }
                }
            }
            Context 'Response' {
                Get-DigitalOceanImage -Token $testToken -Id $id | Test-DigitalOceanImage -RawObject $testimage
            }
        }
        Context 'Default Parameter Set' {
            Mock Invoke-DigitalOceanApiCall -MockWith {$testListResponse}
            Context 'Request'{
                Get-DigitalOceanImage -Token $testToken
                It 'Passes the correct token'{
                    Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Token -eq $testToken }
                }
                It 'Sends to the correct url'{
                    Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq 'images' }
                }
                Context 'Paging'{
                    It 'Calls correct url for page'{
                        Get-DigitalOceanImage -Token $testToken -Page 15
                        Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq 'images?page=15' }
                    }
                    It 'Calls correct url for per page'{
                        Get-DigitalOceanImage -Token $testToken -PerPage 23
                        Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq 'images?per_page=23' }
                    }
                    It 'Calls correct url for per page and page'{
                        Get-DigitalOceanImage -Token $testToken -Page 15 -PerPage 23
                        Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq 'images?page=15&per_page=23' }
                    }
                }
            }
            Context 'Response' {
            $response = Get-DigitalOceanImage -Token $testToken
    
                Context 'Images'{
                    It 'Contains the correct number'{
                        ($response.Images | Measure-Object).Count | Should -Be 1
                    }
                    $response.Images[0] | Test-DigitalOceanImage -RawObject $testImage
                }
                Context 'TotalCount'{
                    It 'Parses TotalCount correctly'{
                        $response.TotalCount | Should -Be $testListResponse.meta.total
                    }
                }
            }
        }
        Context 'Type' {
            Mock Invoke-DigitalOceanApiCall -MockWith {$testListResponse}
            Context 'Distribution'{
                Get-DigitalOceanImage -Token $testToken -Type 'distribution'
                It 'Sends to the correct url'{
                    Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq 'images?type=distribution' }
                }
            }
            Context 'Application'{
                Get-DigitalOceanImage -Token $testToken -Type 'application'
                It 'Sends to the correct url'{
                    Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq 'images?type=application' }
                }
            }
        }
        Context 'Private' {
            Mock Invoke-DigitalOceanApiCall -MockWith {$testListResponse}
            Get-DigitalOceanImage -Token $testToken -Private
            It 'Sends to the correct url'{
                Assert-MockCalled Invoke-DigitalOceanApiCall -Exactly 1 -ParameterFilter { $Url -eq 'images?private=true' }
            }
        }
    }
}