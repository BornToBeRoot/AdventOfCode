# https://adventofcode.com/2022/day/3

$Text = Get-Content -Path $PSScriptRoot\input.txt

$TotalSum = 0

foreach ($Bag in $Text) {
    $Offset = $Bag.Length / 2

    $Part1 = $Bag.Substring(0, $Offset)
    $Part2 = $Bag.Substring($Offset, $Offset)

    [System.Collections.ArrayList]$CharValues = @()

    $Part1.ToCharArray() | ForEach-Object {        
        if ($Part2.Contains($_)) {            
            $Ascii = ($_ -cmatch "[A-Z]") ? 38 : 96
                 
            [void]$CharValues.Add([Int]$_ - $Ascii)
        }               
    }    

    $CharValues | Get-Unique | ForEach-Object { $TotalSum += $_ }
}

$TotalSum
