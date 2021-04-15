function Get-ChiaRewardTarget {
    [CmdletBinding()]
    param(
        [switch]$SearchForPrivateKey
    )

    $Param = @{
        Command = "get_reward_targets"
        Parameters = @{search_for_private_key = $SearchForPrivateKey.IsPresent} | ConvertTo-Json
        Service = "Farmer"
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        [PSCustomObject]@{
            FarmerTarget = $Response.farmer_target
            PoolTarget = $Response.pool_target
            HaveFarmerSK = $Response.have_farmer_sk
            HavePoolSK = $Response.have_pool_sk
        }
    }
    else{
        Write-Error "Command Failed: $($Response.error)"
    }
}