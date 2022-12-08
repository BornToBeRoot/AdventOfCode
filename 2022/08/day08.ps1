# https://adventofcode.com/2022/day/8

# Build input array
[System.Collections.ArrayList]$Row = @()

foreach ($Line in Get-Content -Path $PSScriptRoot\day08_input.txt) {
    [System.Collections.ArrayList]$Column = @()

    foreach ($Char in $Line.ToCharArray()) {
        [void]$Column.Add([int]$Char.ToString())        
    }

    [void]$Row.Add($Column)
}

$VisibleTrees = ($Row.Count * 2) + ($Row[0].Count * 2) - 4

# Go through each row
for ($i = 1; $i -lt $Row.Count - 1; $i++) {
    # Go through each column
    :outer for ($y = 1; $y -lt $Row[$i].Count - 1; $y++) {
        $CurrentTree = $Row[$i][$y]
        Write-Host "Current tree is [$i,$y] with value $CurrentTree"

        # Left
        $LeftVisible = $true
        $Row[$i][0..($y - 1)] | ForEach-Object {
            if ($_ -ge $CurrentTree) {
                $LeftVisible = $false
            }
        }
        
        # Right
        $RightVisible = $true
        $Row[$i][($y + 1)..$($Row[$y].Count)] | ForEach-Object {
            if ($_ -ge $CurrentTree) {
                $RightVisible = $false
            }
        }

        # Top
        $TopVisible = $true
        $Row[0..($i - 1)] | ForEach-Object { $_[$y] } | ForEach-Object {
            if ($_ -ge $CurrentTree) {
                $TopVisible = $false
            }
        }
        
        # Bottom
        $BotVisible = $true
        $Row[($i + 1)..$($Row[$i].Count)] | ForEach-Object { $_[$y] } | ForEach-Object {
            if ($_ -ge $CurrentTree) {
                $BotVisible = $false
            }
        }

        # Check if visible
        if ($LeftVisible -or $TopVisible -or $RightVisible -or $BotVisible) {
            $VisibleTrees++
        }
    }    
}

$VisibleTrees