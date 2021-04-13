function Get-ChiaBlock {
    [CmdletBinding(DefaultParameterSetName = "SingleBlock")]
    param(
        [Parameter(ValueFromPipeline,ValueFromPipelineByPropertyName,
        ParameterSetName = "SingleBlock")]
        [string[]]$HeaderHash,

        [Parameter(Mandatory,ParameterSetName = "Blocks")]
        [int]$StartHeight,

        [Parameter(Mandatory,ParameterSetName = "Blocks")]
        [int]$EndHeight,

        [Parameter(ParameterSetName = "Blocks")]
        [switch]$ExcludeHeaderHash

    )

    Begin{
        $Param = @{
            Command = "get_block"
            Parameters = "" | ConvertTo-Json
            Service = "Full_Node"
        }
    }

    Process{
        if ($PSBoundParameters.ContainsKey("HeaderHash")){
            foreach ($hash in $HeaderHash){
                $Param["Parameters"] = @{header_hash = $hash} | ConvertTo-Json
                $Response = Invoke-chiaRPCCommand @Param
                if ($Response.success){
                    $Response.block
                }
                else{
                    $Response
                }
            }
        }
        else{
            $Parameters = @{
                start = $StartHeight
                end = $EndHeight
                Exclude_header_hash = $ExcludeHeaderHash.IsPresent
            }
            $Param["Command"] = "get_blocks"
            $Param["Parameters"] = ($Parameters | ConvertTo-Json)
            $Response = Invoke-chiaRPCCommand @Param
            if ($Response.success){
                $Response.blocks
            }
            else{
                $Response
            }
        }
    }

}