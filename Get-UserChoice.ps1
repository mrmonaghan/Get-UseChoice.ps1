function Get-UserChoice {
[CmdletBinding()]

param(
    [Parameter(
        Mandatory = $True,
        ValueFromPipeline = $true,
        ValueFromPipelineByPropertyName = $True)]
    [Alias('Name','Input')]
    [Object]$Data,

    [Parameter()]
    [string]$Title,

    [Parameter()]
    [string]$Description

)

    Begin {
        $DefaultChoiceIndex = -1
        $Options = @()
        $i = 0
        }
    Process {
        foreach ($value in $Data) {
            $i++
            $NewChoice = [System.Management.Automation.Host.ChoiceDescription]::new("&$value")
            $NewChoice | Add-Member -MemberType NoteProperty -Name Name -Value $value
            $Options += $NewChoice
            }
        }


    end {
        $ChosenIndex = $host.UI.PromptForChoice($Title,$Description,$Options,$DefaultChoiceIndex)
        $Chosen = $Options[$ChosenIndex].name
        Write-Output $Chosen
        }
}