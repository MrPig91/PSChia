function Invoke-chiaRPCCommand {
    [CmdletBinding()]
    param(
        [string]$Command,

        [string]$Parameters,

        [ValidateSet("Harvester","Wallet","Full_Node","Daemon","Farmer")]
        [string]$Service,

        [string]$HostName = $Script:HostName
    )

    Try{
        $Cert = Get-chiaPFXCert -Service $Service -HostName $HostName -ErrorAction Stop
        switch ($Service){
            "Harvester" {
                Write-Information "Harvester service flagged, setting port and getting cert"
                $Port = 8560
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
       Write-Error "Unable to grab/create Cert for $Service service: $_" -ErrorAction Stop
    }

    $Param = @{
        Method = "Post"
        Uri = "https://$($HostName):$($Port)/$($Command)"
        ContentType = "application/json"
        Body = $Parameters
        Certificate = $Cert
    }

    try{
        Invoke-RestMethod @Param
    }
    catch [System.InvalidOperationException]{
        if ($_.Exception.Message -like "*Could not establish trust relationship for the SSL/TLS secure channel.*"){
            Write-Information "Insecure sessions not allowed, setting Cert Call Back to allow."
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