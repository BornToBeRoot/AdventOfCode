# https://adventofcode.com/2022/day/11

$Text = Get-Content -Path $PSScriptRoot\input.txt

[System.Collections.ArrayList]$Monkeys = @()

<#
Example monkey in the list:

Monkey          : 0
Items           : {79, 98}
Operation       : *,19
Test            : 23
NextMonkeyTrue  : 2
NextMonkeyFalse : 3
#>
for($i = 0; $i -lt $Text.Count; $i += 7) {
    [System.Collections.ArrayList]$Items = @()
    $($Text[$i+1].Trim().Split(":")[1].Replace(" ","").Split(",")) | ForEach-Object { [void]$Items.Add([int]$_) }

    [void]$Monkeys.Add([pscustomobject]@{
        Monkey = $Text[$i].Trim().Split(" ")[1].Split(":")[0]
        Items = $Items
        Operation = $Text[$i+2].Trim().Split("=")[1].Trim().Split(" ")[1..2] -join ","
        Test = [int]$($Text[$i+3].Trim().Split(" ")[3])
        NextMonkeyTrue = [int]$($Text[$i+4].Trim().Split(" ")[5])
        NextMonkeyFalse = [int]$($Text[$i+5].Trim().Split(" ")[5])
        Inspected = 0
    })
}

for($i = 0; $i -lt 20; $i++) {
    foreach($Monkey in $Monkeys) {
        $Operations = $Monkey.Operation.Split(",")        

        foreach($Item in $Monkey.Items) {
            $Monkey.Inspected++

            $OperationValue = $Operations[1]
            if($OperationValue -eq "old") {
                $OperationValue = $Item
            }

            switch($Operations[0]) {
                "+" { $Result = $Item + $OperationValue }
                "*" { $Result = $Item * $OperationValue }                
            }

            $NewWorryLevel = [Math]::Floor($Result / 3)
            $NewMonkey = $NewWorryLevel%$Monkey.Test -eq 0 ? $Monkey.NextMonkeyTrue : $Monkey.NextMonkeyFalse
                        
            [void]$Monkeys[$NewMonkey].Items.Add($NewWorryLevel)
        }        

        $Monkey.Items.Clear()
    }
}

$MonkeysInspected = ($Monkeys.Inspected | Sort-Object -Descending)[0..1]
Write-Host "Part 1: $($MonkeysInspected[0] * $MonkeysInspected[1])"
