function Get-ChiaFarmedAmount {
    [CmdletBinding()]
    param()

    $Param = @{
        Command = "get_farmed_amount"
        Parameters = "" | ConvertTo-Json
        Service = "Wallet"
    }

    Invoke-chiaRPCCommand @Param
}