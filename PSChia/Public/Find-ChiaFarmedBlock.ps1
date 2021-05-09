function Find-ChiaFarmedBlock {
    [CmdletBinding()]
    param(
        [int]$WalletId = 1
    )

    $Transactions = Get-ChiaTransaction -WalletId $WalletId | where {$_.Type -eq 2 -or $_.Type -eq 3}
    $grouped = $Transactions | group confirmed_at_height

    foreach ($group in $grouped){
        $blocks = Get-ChiaBlock -StartHeight ($group.Name - 100) -EndHeight $group.Name
        $farmedBlock = $blocks | where {$_.foliage.foliage_block_data.farmer_reward_puzzle_hash -eq $group.Group[0].to_puzzle_hash}

        [PSCustomObject]@{
            ConfirmedHeight = $group.Name
            FarmedHeight = $farmedBlock.reward_chain_block.height
            plot_public_key = $farmedBlock.reward_chain_block.proof_of_space.plot_public_key
        }
    }
}