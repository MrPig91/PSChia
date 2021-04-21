function New-ChiaPSSession {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias("IPAddress")]
        [string]$HostName,

        [Parameter(Mandatory)]
        [ValidateSet("Harvester","Wallet","Full_Node","Farmer")]
        [string]$Service,

        [Parameter()]
        [string]$CertPathDirectory
    )

    if ($PSBoundParameters.ContainsKey("CertPathDirectory")){
        New-chiaPFXCert -HostName $HostName -Service $Service -CertPathDirectory $CertPathDirectory
    }
    else{
        New-chiaPFXCert -HostName $HostName -Service $Service
    }
}