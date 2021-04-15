function Get-ChiaFarmedAmount {
    [CmdletBinding()]
    param()

    $Param = @{
        Command = "get_farmed_amount"
        Parameters = "" | ConvertTo-Json
        Service = "Wallet"
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        $Response
    }
    else{
        Write-Error "Command Failed: $($Response.error)"
    }
}