# https://adventofcode.com/2022/day/4

$Count = 0

:outer foreach ($Text in Get-Content -Path $PSScriptRoot\input.txt) {
    $Group = $Text.Split(',')

    $First = $Group[0].Split('-')
    $Second = $Group[1].Split('-')

    $SecondAsArray = $Second[0]..$Second[1]

    foreach ($x in $First[0]..$First[1]) {
        if ($SecondAsArray.Contains($x)) {
            $Count++   
            continue outer
        }        
    }    
}

$Count