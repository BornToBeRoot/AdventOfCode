# https://adventofcode.com/2022/day/3

$Text = Get-Content -Path $PSScriptRoot\input.txt

$TotalSum = 0

for ($i = 0; $i -lt $Text.Length; $i += 3) {

    [System.Collections.ArrayList]$CharValues = @()

    $Text[$i].ToCharArray() | ForEach-Object {
        if ($Text[$i + 1].Contains($_) -and $Text[$i + 2].Contains($_)) {
            $Ascii = ($_ -cmatch "[A-Z]") ? 38 : 96
            [void]$CharValues.Add([Int]$_ - $Ascii)             
        }        
    }

    $CharValues | Get-Unique | ForEach-Object { $TotalSum += $_ }
}

$TotalSum
