function New-chiaPassword {
    $Length = 0..20
    [System.Collections.ArrayList]$ASCII = @(48..57)
    65..90 | foreach {$ASCII.Add($_)} | Out-Null
    97..122 | foreach {$ASCII.Add($_)} | Out-Null
    ($Length | foreach {[char](Get-Random -InputObject $ASCII)}) -join ""
}