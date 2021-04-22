function Get-OpenSSLPath {
    [CmdletBinding()]
    param()
    $OpenSSLPath = "C:\Program Files\Git\mingw64\bin\openssl.exe"
    $OpenSSL2ndPath = "$ENV:LOCALAPPDATA\Local\Programs\Git\mingw64\bin\openssl.exe"
    if (Test-Path $OpenSSLPath){
        $OpenSSLPath
    }
    elseif (Test-Path $OpenSSL2ndPath){
        $OpenSSL2ndPath
    }
    else{
        $Message = "GIT is not installed, please install GIT so that OpenSSL can be used."
        $ErrorRecord = [System.Management.Automation.ErrorRecord]::new(
            [System.IO.FileNotFoundException]::new($Message,"C:\Program Files\Git\mingw64\bin\openssl.exe"),
            'GITNotInstalledException',
            [System.Management.Automation.ErrorCategory]::ObjectNotFound ,
            "C:\Program Files\Git\mingw64\bin\openssl.exe"
        )
        $PSCmdlet.WriteError($ErrorRecord)
    }
}