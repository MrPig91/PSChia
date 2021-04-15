function Get-ChiaConnection {
    [CmdletBinding()]
    param()

    $Param = @{
        Command = "get_connections"
        Parameters = "" | ConvertTo-Json
        Service = "Full_Node"
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        $Response.connections
    }
    else{
        Write-Error "Command Failed: $($Response.error)"
    }
}