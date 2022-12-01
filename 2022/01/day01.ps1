# https://adventofcode.com/2022/day/1

$Text = Get-Content -Path $PSScriptRoot\day01_input.txt

[System.Collections.ArrayList]$ElvesMap = @()

$ElvesCount = 1
$TempCalories = 0

for($i = 0; $i -lt $Text.Length; $i++)
{
    $Calories = [int]$Text[$i]

    $TempCalories += $Calories

    if($Calories -eq 0 -or $i -eq ($Text.Length -1)) {
        [void]$ElvesMap.Add([pscustomobject] @{
            Elf = $ElvesCount            
            Calories = $TempCalories
        })
        
        $ElvesCount++
        $TempCalories = 0
    }
}

# Part 1
($ElvesMap | Sort-Object -Property Calories -Descending | Select-Object -First 1).Calories

# Part 2
(($ElvesMap | Sort-Object -Property Calories -Descending | Select-Object -First 3).Calories | Measure-Object -Sum).Sum
