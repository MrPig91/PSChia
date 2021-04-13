function Remove-PlotDirectory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [string[]]$Path
    )

    Process{
        foreach ($directory in $Path){
            $Param = @{
                Command = "remove_plot_directory"
                Parameters = (@{dirname = $directory} | ConvertTo-Json)
                Service = "Harvester"
            }
            Invoke-chiaRPCCommand @Param | foreach {
                [PSCustomObject]@{
                    Path = $directory
                    Success = $_.success
                }
            }
        }
    }
}