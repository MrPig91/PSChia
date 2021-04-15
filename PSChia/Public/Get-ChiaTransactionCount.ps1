function Get-ChiaTransactionCount {
    [CmdletBinding()]
    param(
        [ValidateRange(1,[int]::MaxValue)]
        [int]$WalletId
    )

    $Param = @{
        Command = "get_transaction_count"
        Parameters = @{wallet_id = $WalletId} | ConvertTo-Json
        Service = "Wallet"
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        [pscustomobject]@{
            WalletId = $Response.wallet_id
            Count = $Response.count
        }
    }
    else{
        Write-Error "Command Failed: $($Response.error)"
    }
}