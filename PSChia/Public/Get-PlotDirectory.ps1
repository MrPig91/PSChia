function Get-PlotDirectory {
    [CmdletBinding()]
    param()

    $Param = @{
        Command = "get_plot_directories"
        Parameters = ("" | ConvertTo-Json)
        Service = "Harvester"
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        foreach ($directory in $Response.directories){
            [PSCustomObject]@{
                DirectoryPath = $directory
            }
        }
    }
    else{
        Write-Warning "Unable to get plot directories"
        $Response
    }
}