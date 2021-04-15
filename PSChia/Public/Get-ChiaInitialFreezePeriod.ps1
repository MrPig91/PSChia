function Get-ChiaInitialFreezePeriod {
    [CmdletBinding()]
    param()

    $Param = @{
        Command = "get_initial_freeze_period"
        Parameters = "" | ConvertTo-Json
        Service = "Wallet"
    }
<#
#?? Command Failed; get_initial_freeze_period() takes 1 positional argument but 2 were given ??
    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        $Response
    }
    else{
        Write-Error "Command Failed; $($Response.error)"
    }
#>

}