function Get-HarvesterPFX{
    Write-Information "Grabbing Harvester PFX Cert"
    $ErrorActionPreference = "Stop"
    try{
        $PSChiaPath = "$ENV:LOCALAPPDATA\PSChia"
        if (Test-Path "$PSChiaPath\Harvester.pfx"){
            $encryptedPassword = Get-Content "$PSChiaPath\HarvesterPass.txt"
            $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
            $password = [pscredential]::new("Chia",(ConvertTo-SecureString -String $encryptedPassword)).GetNetworkCredential().Password
            Write-Information "Password: $password"
            $cert.Import("$PSChiaPath\Harvester.pfx",$password,'DefaultKeySet')
            $ErrorActionPreference = "Continue"
            return $cert
        }
        else{
            Write-Information "Harvester Cert not found, going to try and create one now"
            New-HarvesterPFX -ErrorAction Stop
            Get-HarvesterPFX
        }
    }
    catch{
        $PSCmdlet.WriteError($_)
        $ErrorActionPreference = "Continue"
    }
}