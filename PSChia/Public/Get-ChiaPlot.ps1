function Get-ChiaPlots {
    [CmdletBinding()]
    param(
    )

    $Param = @{
        Command = "get_plots"
        Parameters = ("" | ConvertTo-Json)
        Service = "Harvester"
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        foreach ($plot in $Response.plots){
            [PSCustomObject]@{
                PSTypeName = "PSChia.ChiaPlot"
                Parent_Folder = (Split-Path $plot.filename -Parent)
                File_Name = (Split-Path $plot.filename -Leaf)
                FullName = $plot.filename
                File_Size = $plot.file_size
                File_SizeGB = [math]::Round($plot.file_size / 1gb,2)
                "K-Size" = $plot.size
                Modified_Time = ConvertFrom-UnixEpoch $Plot.time_modified
                Plot_Seed = $plot."plot-seed"
                Plot_Public_Key = $plot.plot_public_key
                Pool_Public_Key = $plot.pool_public_key
                Pool_Contract_Puzzle_Hash = $plot.pool_contract_puzzle_hash
            }
        }
    }
}