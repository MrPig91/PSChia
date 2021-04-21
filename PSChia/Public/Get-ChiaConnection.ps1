function Get-ChiaConnection {
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateSet("Harvester","Wallet","Full_Node","Farmer")]
        [string]$Service = "Full_Node"
    )

    $Param = @{
        Command = "get_connections"
        Parameters = "" | ConvertTo-Json
        Service = $Service
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        $Response.connections
    }
    else{
        Write-Error "Command Failed: $($Response.error)"
    }
}