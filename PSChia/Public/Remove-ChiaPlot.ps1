function Remove-ChiaPlot {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias("FullName")]
        [string[]]$FileName
    )

    Process{
        foreach ($plot in $FileName){
            $Param = @{
                Command = "delete_plot"
                Parameters = (@{filename = $plot} | ConvertTo-Json)
                Service = "Harvester"
            }

            #Write-Warning "Function not tested yet and so not yet implemented"
            $response = Invoke-chiaRPCCommand @Param
            $response
        }
    }
}