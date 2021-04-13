function Add-PlotDirectory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipelineByPropertyName,ValueFromPipeline)]
        [string]$Path
    )

    $Param = @{
        Command = "add_plot_directory"
        Parameters = (@{dirname = $Path} | ConvertTo-Json)
        Service = "Harvester"
    }

    Invoke-chiaRPCCommand @Param
}