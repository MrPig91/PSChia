function New-HarvesterPFX {
    [CmdletBinding()]
    param()
    Write-Information "Creating new PFX Cert for Harvester service"
    $ErrorActionPreference = "Stop"
    try{
        #$OpenSSL = Get-OpenSSLPath -ErrorAction Stop
        $HarvesterPath = "$ENV:USERPROFILE\.Chia\mainnet\config\ssl\harvester"
        $PFXPath = "$ENV:LOCALAPPDATA\PSChia"
        if (!(Test-Path $PFXPath)){
            New-Item -Path "$ENV:LOCALAPPDATA\PSChia" -ItemType Directory | Out-Null
        }
        if (Test-Path $HarvesterPath){
            $cert = "$HarvesterPath\private_harvester.crt"
            $key = "$HarvesterPath\private_harvester.key"
        }
        else{
            Write-Error "Unable to grab certs" -ErrorAction Stop
        }

        $pass = New-chiaPassword
        $password = ConvertTo-SecureString -String $pass -AsPlainText -Force
        $EncryptedPassword = ConvertFrom-SecureString -SecureString $password
        $EncryptedPassword | Out-File -FilePath "$ENV:LOCALAPPDATA\PSChia\HarvesterPass.txt"
    
        &$OpenSSL pkcs12 -export -out "$ENV:LOCALAPPDATA\PSChia\Harvester.pfx" -inkey $key -in $cert -passout pass:$pass
        Write-Information "Harvester PFX Cert successfully created"
        $ErrorActionPreference = "Continue"
    }
    catch [System.IO.FileNotFoundException]{
        $ErrorActionPreference = "Continue"
        $PSCmdlet.WriteError($_)
    }
    catch{
        $ErrorActionPreference = "Continue"
        Write-Error "Unable to create Harvester Cert: $($_)"
    }
}