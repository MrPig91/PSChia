function Get-ChiaBlockRecord{
    [CmdletBinding(DefaultParameterSetName = "Height")]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,
        ParameterSetName = "Height")]
        [int[]]$Height,

        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName,
        ParameterSetName = "HeaderHash")]
        [string[]]$HeaderHash,

        [Parameter(Mandatory, ParameterSetName = "StartAndEndHeight")]
        [int]$StartHeight,

        [Parameter(Mandatory, ParameterSetName = "StartAndEndHeight")]
        [int]$EndHeight
    )

    Begin{
        switch ($PSCmdlet.ParameterSetName){
            "Height" {$Command = "get_block_record_by_height"}
            "HeaderHash" {$Command = "get_block_record"}
            "StartAndEndHeight" {$Command = "get_block_records"}
        }
        $Param = @{
            Command = $Command
            Parameters = "" | ConvertTo-Json
            Service = "Full_Node"
        }
    }

    Process{
        switch ($PSCmdlet.ParameterSetName){
            "Height" {
                foreach ($h in $Height){
                    $Param["Parameters"] = (@{height = $h} | ConvertTo-Json)
                }

                 $Response = Invoke-chiaRPCCommand @Param
                 if ($Response.success){
                     $Response.block_record
                 }
                 else{
                    Write-Error "Command Failed: $($Response.error)"
                 }
            }

            "HeaderHash" {
                foreach ($hash in $HeaderHash){
                    $Param["Parameters"] = (@{header_hash = $hash} | ConvertTo-Json)

                    $Response = Invoke-chiaRPCCommand @Param
                    if ($Response.success){
                        $Response.block_record
                    }
                    else{
                        Write-Error "Command Failed: $($Response.error)"
                    }
                }
            }

            "StartAndEndHeight" {
                $Param["Parameters"] = (@{start = $StartHeight; end = $EndHeight} | ConvertTo-Json)

                $Response = Invoke-chiaRPCCommand @Param
                if ($Response.success){
                    $Response.block_records
                }
                else{
                    Write-Error "Command Failed: $($Response.error)"
                }
            }
        }
    }
}