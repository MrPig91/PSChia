function New-chiaPFXCert {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet("Harvester","Wallet","Full_Node","Farmer")]
        [string]$Service,
        [string]$HostName = "Localhost",
        [string]$CertPathDirectory
    )
    Write-Information "Creating new PFX Cert for $Service service"
    $ErrorActionPreference = "Stop"
    try{
        $OpenSSL = Get-OpenSSLPath -ErrorAction Stop
        if ($PSBoundParameters.ContainsKey("CertPathDirectory")){
            $ServicePath = $CertPathDirectory
        }
        else{
            $ServicePath = "$ENV:USERPROFILE\.Chia\mainnet\config\ssl\$Service"
        }
        $PFXPath = "$ENV:LOCALAPPDATA\PSChia"
        if (!(Test-Path $PFXPath)){
            New-Item -Path "$ENV:LOCALAPPDATA\PSChia" -ItemType Directory | Out-Null
        }
        if ((Test-Path "$ServicePath\private_$Service.crt") -and (Test-Path "$ServicePath\private_$Service.key")){
            $cert = "$ServicePath\private_$Service.crt"
            $key = "$ServicePath\private_$Service.key"
        }
        else{
            $Message = "Chia Certs/Key Not Found for $Service"
            $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
                [System.IO.FileNotFoundException]::new($Message,$SErvicePath),
                'CertNotFound',
                [System.Management.Automation.ErrorCategory]::ObjectNotFound,
                "$ServicePath"
            )
            $PSCmdlet.ThrowTerminatingError($ErrorRecord)
        }

        $PFXHostPath = "$ENV:LOCALAPPDATA\PSChia\$Hostname"
        if (!(Test-Path $PFXHostPath)){
            New-Item -Path "$ENV:LOCALAPPDATA\PSChia\$Hostname" -ItemType Directory | Out-Null
        }

        $pass = New-chiaPassword
        $password = ConvertTo-SecureString -String $pass -AsPlainText -Force
        $EncryptedPassword = ConvertFrom-SecureString -SecureString $password
        $EncryptedPassword | Out-File -FilePath "$PFXHostPath\$($Service)Pass.txt"
    
        &$OpenSSL pkcs12 -export -out "$PFXHostPath\$($Service).pfx" -inkey $key -in $cert -passout pass:$pass
        Write-Information "$Service PFX Cert successfully created"
        $ErrorActionPreference = "Continue"
    }
    catch [System.IO.FileNotFoundException]{
        $ErrorActionPreference = "Continue"
        $PSCmdlet.WriteError($_)
    }
    catch{
        $ErrorActionPreference = "Continue"
        Write-Error "Unable to create $Service Cert: $($_)" -ErrorAction Stop
    }
}