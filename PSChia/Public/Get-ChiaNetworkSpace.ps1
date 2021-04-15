function Get-ChiaNetworkSpace{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$OlderHeaderHash,

        [Parameter(Mandatory)]
        [string]$NewerHeaderHash
    )

    $Param = @{
        Command = "get_network_space"
        Parameters = (@{older_block_header_hash = $OlderHeaderHash; newer_block_header_hash = $NewerHeaderHash} | ConvertTo-Json)
        Service = "Full_Node"
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        $Response.space
    }
    else{
        Write-Error "Command Failed: $($Response.error)"
    }

}