function Get-ChiaFarmedPlot {
    [CmdletBinding()]
    param()

    $FarmedBlocks = Find-ChiaFarmedBlock
    $Plots = Get-ChiaPlot

    $Plots | where Plot_Public_Key -in $FarmedBlocks.plot_public_key
}