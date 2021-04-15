function Get-ChiaSignagePoint {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [Alias("SigPoint","sp_hash")]
        [string[]]$SignagePoint
    )

    Begin{
        $Param = @{
            Command = "get_signage_point"
            Parameters = "" | ConvertTo-Json
            Service = "Farmer"
        }
    }

    Process{
        if ($PSBoundParameters.ContainsKey("SignagePoint")){
            foreach ($hash in $SignagePoint){
                Write-Information "Getting Sig Point $hash"
                $Param["Parameters"] = @{sp_hash = $hash} | ConvertTo-Json
                $Response = Invoke-chiaRPCCommand @Param
                if ($Response.success){
                    [PSCustomObject]@{
                        Proofs = $Response.proofs

                    }
                }
                else{
                    Write-Error "Command Failed: $($Response.error)"
                }
            }
        }
        else{
            Write-Information "Getting all recent sig points"
            $Param["Command"] = "get_signage_points"
            $Response = Invoke-chiaRPCCommand @Param
            if ($Response.success){
                $Response.signage_points | foreach {
                    [PSCustomObject]@{
                        Proofs = $_.proofs
                        SignagePoint = $_.signage_point
                    }
                }
            }
            else{
                Write-Error "Command Failed: $($Response.error)"
            }
        }
    } #Process
}