function Close-ChiaConnection {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [int]$NodeId
    )

    $Param = @{
        Command = "close_connection"
        Parameters = @{node_id = $NodeId} | ConvertTo-Json
        Service = "Full_Node"
    }

    Invoke-chiaRPCCommand @Param
}