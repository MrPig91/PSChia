function Stop-ChiaNode {
    [CmdletBinding()]
    param()

    $Param = @{
        Command = "stop_node"
        Parameters = "" | ConvertTo-Json
        Service = "Full_Node"
    }
    
    Write-Warning "Untested"
    #Invoke-chiaRPCCommand @Param
}