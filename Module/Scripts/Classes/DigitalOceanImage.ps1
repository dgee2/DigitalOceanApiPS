Class DigitalOceanImage
{
    [int]$Id
    [string]$Name
    [string]$Distribution
    [string]$Slug
    [bool]$Public
    [string[]]$Regions
    [datetime]$CreatedAt
    [EDigitalOceanImageType]$Type
    [decimal]$MinDiskSize
    [decimal]$Size
}