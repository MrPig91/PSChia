function Get-ChiaPlotDirectory {
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
        Write-Error "Command Failed: $($Response.error)"
    }
}