function Get-ChiaNetworkInfo {
    [CmdletBinding()]
    param()

    $Param = @{
        Command = "get_network_info"
        Parameters = "" | ConvertTo-Json
        Service = "Full_Node"
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        $Response
    }
    else{
        Write-Error "Command Failed: $($Response.error)"
    }
}