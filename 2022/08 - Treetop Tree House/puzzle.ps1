# https://adventofcode.com/2022/day/8

# Build input array
[System.Collections.ArrayList]$Row = @()

foreach ($Line in Get-Content -Path $PSScriptRoot\input.txt) {
    [System.Collections.ArrayList]$Column = @()

    foreach ($Char in $Line.ToCharArray()) {
        [void]$Column.Add([int]$Char.ToString())        
    }

    [void]$Row.Add($Column)
}

# Ignore borders, so we can ignore the first and last row and column 
# when iterating over the array
$VisibleTreesScore = ($Row.Count * 2) + ($Row[0].Count * 2) - 4

$TreeScenicScore = 0

# Go through each row
for ($i = 1; $i -lt $Row.Count - 1; $i++) {
    # Go through each column
    for ($y = 1; $y -lt $Row[$i].Count - 1; $y++) {
        $CurrentTree = $Row[$i][$y]
        Write-Host "Current tree is [$i,$y] with value $CurrentTree"

        # Left
        $LeftVisible = $true
        $LeftCount = 0
        foreach($l in $Row[$i][($y - 1)..0]) {
            $LeftCount++
            if ($l -ge $CurrentTree) {
                $LeftVisible = $false
                break
            }
        }         
        
        # Right
        $RightVisible = $true
        $RightCount = 0
        foreach($r in $Row[$i][($y + 1)..$($Row[$y].Count)]) {
            $RightCount++
            if ($r -ge $CurrentTree) {                
                $RightVisible = $false
                break
            }
        }

        # Top
        $TopVisible = $true
        $TopCount = 0
        foreach($t in $Row[($i - 1)..0]) {                 
            $TopCount++
            if($($t[$y]) -ge $CurrentTree)   {
                $TopVisible = $false
                break
            }         
        }
        
        # Bottom
        $BotVisible = $true
        $BotCount = 0
        foreach($b in $Row[($i + 1)..$($Row[$i].Count)]) {            
            $BotCount++            
            if($($b[$y]) -ge $CurrentTree)   {
                $BotVisible = $false
                break
            }            
        }

        # Check if tree is visible
        if ($LeftVisible -or $TopVisible -or $RightVisible -or $BotVisible) {
            $VisibleTreesScore++
        }

        # Check scenic score        
        $CurrentTreeScenicScore = $TopCount * $LeftCount * $BotCount * $RightCount 
        
        if ($CurrentTreeScenicScore -gt $TreeScenicScore) {
            $TreeScenicScore = $CurrentTreeScenicScore
        }
    }    
}

Write-Host "Part 1: $VisibleTreesScore"
Write-Host "Part 2: $TreeScenicScore"
