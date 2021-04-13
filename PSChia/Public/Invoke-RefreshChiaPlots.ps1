function Invoke-RefreshPlots {
    [CmdletBinding()]
    param()

    $Param = @{
        Command = "refresh_plots"
        Parameters = ("" | ConvertTo-Json)
        Service = "Harvester"
    }

    Invoke-chiaRPCCommand @Param
}