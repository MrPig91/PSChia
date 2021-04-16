function Get-ChiaTransaction {
    [CmdletBinding(DefaultParameterSetName = "WalletId")]
    param(
        #[Parameter(Mandatory, ParameterSetName = "TransactionId")]
        #[string]$TransactionID,

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
            Parameters = @{transaction_id = $TransactionID} | ConvertTo-Json
            Service = "Wallet"
        }
    }

    try{
        $Response = Invoke-chiaRPCCommand @Param -ErrorAction Stop
        if ($Response.success){
            $Response.transactions
            #$Response.transaction
        }
        else{
            Write-Error "Command Failed: $($Response.error)"
        }
    }
    catch{
        $PSCmdlet.WriteError($_)
    }

}