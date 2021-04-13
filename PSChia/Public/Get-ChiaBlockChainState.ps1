function Get-ChiaBlockChainState {
    [CmdletBinding()]
    param()

    $Param = @{
        Command = "get_blockchain_state"
        Parameters = ("" | ConvertTo-Json)
        Service = "Full_Node"
    }

    $Response = Invoke-chiaRPCCommand @Param
    if ($Response.success){
        $BlockChainState = $Response.blockchain_state
        $BlockChainState.PSObject.TypeNames.Insert(0,"PSChia.ChiaBlockChainState")
        $BlockChainState | Add-Member -MemberType ScriptProperty -Name Height -Value {$this.peak.height}
        $BlockChainState | Add-Member -MemberType ScriptProperty -Name Synced -Value {$this.sync.synced}
        $BlockChainState | Add-Member -MemberType ScriptProperty -Name SpacePB -Value {[math]::Round($this.Space / 1.126e+15,2)}
        $BlockChainState
    }
    else{
        Write-Warning "Command failed"
        $Response
    }
}