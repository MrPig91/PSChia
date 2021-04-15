function Get-ChiaTransaction {
    [CmdletBinding(DefaultParameterSetName = "WalletId")]
    param(
        [Parameter(Mandatory, ParameterSetName = "TransactionId")]

        [Parameter(Mandatory, ParameterSetName = "WalletId")]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$WalletId
    )

    if ($PSCmdlet.ParameterSetName -eq "WalletId"){
        $Param = @{
            Command = "get_transactions"
            Parameters = @{wallet_id = $WalletId} | ConvertTo-Json
            Service = "Wallet"
        }
    }
    else{
        $Param = @{
            Command = "get_transaction"
            Parameters = @{transaction_id = $WalletId} | ConvertTo-Json
            Service = "Wallet"
        }
    }

    Invoke-chiaRPCCommand @Param

}