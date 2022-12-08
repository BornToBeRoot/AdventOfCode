# https://adventofcode.com/2022/day/4

$Count = 0

foreach ($Text in Get-Content -Path $PSScriptRoot\day04_sample.txt) {
    $Group = $Text.Split(',')

    $First = $Group[0].Split('-')
    $Second = $Group[1].Split('-')

    if ([int]$First[0] -ge [int]$Second[0] -and [int]$First[1] -le [int]$Second[1]) {
        $Count++
        continue
    }

    if ([int]$Second[0] -ge [int]$First[0] -and [int]$Second[1] -le [int]$First[1]) {
        $Count++
        continue
    }
}

$Count