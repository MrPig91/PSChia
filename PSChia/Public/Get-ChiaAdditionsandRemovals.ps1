function Get-ChiaAdditionsandRemovals{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$HeaderHash,

        [Parameter(Mandatory)]
        [string]$NewerHeaderHash
    )

    $Param = @{
        Command = "get_additions_and_removals"
        Parameters = (@{header_hash = $HeaderHash; newer_block_header_hash = $NewerHeaderHash}) | ConvertTo-Json
        Service = "Full_Node"
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        [PSCustomObject]@{
            Additions = $Response.additions
            Removals = $Response.removals
        }
    }
    else{
        Write-Error "Command Failed: $($Response.error)"
    }
}