function Enter-ChiaPSSession {
    param(
        [ArgumentCompleter({
            param ($commandName,$parameterName,$wordToComplete,$commandAst,$fakeBoundParameters)
            Get-ChildItem -Path $env:LOCALAPPDATA\PSChia -Filter "*$wordToComplete*" -Directory | foreach {
                [System.Management.Automation.CompletionResult]::new($_.Name,$_.Name,"ParameterValue",$_.Name)
            }
        })]
        [ValidateScript(
            {$_ -in (Get-ChildItem -Path $env:LOCALAPPDATA\PSChia -Directory).Name}
        )]
        $HostName
    )

    $Script:HostName = $HostName
}