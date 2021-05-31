function Get-chiaPFXCert{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet("Harvester","Wallet","Full_Node","Farmer")]
        [string]$Service,
        
        [string]$HostName = "Localhost"
    )
    Write-Information "Grabbing $Service PFX Cert"
    $ErrorActionPreference = "Stop"
    try{
        $PSChiaPath = "$ENV:LOCALAPPDATA\PSChia\$HostName"
        if (Test-Path "$PSChiaPath\$Service.pfx"){
            $encryptedPassword = Get-Content "$PSChiaPath\$($Service)Pass.txt"
            $password = [pscredential]::new("Chia",(ConvertTo-SecureString -String $encryptedPassword)).GetNetworkCredential().Password
            Write-Information "Importing $Service PFX Cert"
            $cert = [System.Security.Cryptography.X509Certificates.X509Certificate2]::New("$PSChiaPath\$Service.pfx",$password,'DefaultKeySet')
            $ErrorActionPreference = "Continue"
            return $cert
        }
        elseif ($HostName -eq "Localhost"){
            Write-Information "$Service Cert not found, going to try and create one now"
            New-chiaPFXCert -Service $Service -ErrorAction Stop
            Get-chiaPFXCert -Service $Service -ErrorAction Stop
        }
    }
    catch{
        $ErrorActionPreference = "Continue"
        $PSCmdlet.WriteError($_)
    }
}