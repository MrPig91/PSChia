function Invoke-chiaRPCCommand {
    [CmdletBinding()]
    param(
        [string]$Command,

        [string]$Parameters,

        [ValidateSet("Harvester","Wallet","Full_Node","Daemon","Farmer")]
        [string]$Service
    )

    Try{
        switch ($Service){
            "Harvester" {
                Write-Information "Harvester service flagged, setting port and getting cert"
                $Port = 8560
                $Cert = Get-HarvesterPFX
            }
            "Wallet" {
                $Port = 9256
            }
            "Full_Node" {
                $Port = 8555
            }
            "Farmer" {
                $Port = 8559
            }
            "Daemon" {
                $Port = 55400
            }
        } #switch
    }
    catch{
       Write-Error "Unable to grab/create Cert for $Service service" -ErrorAction Stop
    }

    $Param = @{
        Method = "Post"
        Uri = "https://localhost:$($Port)/$($Command)"
        ContentType = "application/json"
        Body = $Parameters
        Certificate = $Cert
    }

    try{
        Invoke-RestMethod @Param
    }
    catch [System.InvalidOperationException]{
        if ($_.Exception.Message -like "*Could not establish trust relationship for the SSL/TLS secure channel.*"){
            Set-CertCallBack
            Invoke-RestMethod @Param
        }
        else{
            $PSCmdlet.WriteError($_)
        }
    }
    catch{
        $PSCmdlet.WriteError($_)
    }
}