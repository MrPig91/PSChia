function Open-ChiaConnection {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias("IPAddress")]
        [string]$Hostname,

        [Parameter(Mandatory,ValueFromPipelineByPropertyName,ValueFromPipeline)]
        [int]$Port
    )

    $Param = @{
        Command = "open_connection"
        Parameters = @{host = $Hostname; port = $Port} | ConvertTo-Json
        Service = "Full_Node"
    }

    Invoke-chiaRPCCommand @Param
}