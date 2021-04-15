function Get-ChiaUnfinishedBlockHeader{
    [CmdletBinding()]
    param()

    $Param = @{
        Command = "get_unfinished_block_headers"
        Parameters = "" | ConvertTo-Json
        Service = "Full_Node"
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        $Response
    }
}