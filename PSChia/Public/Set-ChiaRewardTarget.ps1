function Set-ChiaRewardTarget {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$FarmerTargetAddress,

        [Parameter(Mandatory)]
        [string]$PoolTargetAddress
    )

    $Param = @{
        Command = "set_reward_targets"
        Parameters = @{farmer_target = $FarmerTargetAddress; pool_target = $PoolTargetAddress} | ConvertTo-Json
        Service = "Farmer"
    }

    Invoke-chiaRPCCommand @Param
}
