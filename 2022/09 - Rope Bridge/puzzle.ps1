# https://adventofcode.com/2022/day/9

# Repeat for each part
foreach ($Part in @(2, 10)) {
    
    # Init hash set for positions
    [System.Collections.Generic.HashSet[String]]$Positions = @()

    # Init array list with knots
    [System.Collections.ArrayList]$Knots = @()

    for ($i = 0; $i -lt $Part; $i++) {
        [void]$Knots.Add([pscustomobject]@{            
                Y = 0
                X = 0
            })
    }

    # Go through each line in input file
    foreach ($Line in Get-Content -Path $PSScriptRoot\input.txt) {
        $LineValues = $Line.Split(" ")
    
        # Set direction to move
        $Y = 0
        $X = 0
    
        switch ($LineValues[0]) {
            "R" { $X = 1 }
            "L" { $X = -1 }
            "U" { $Y = 1 } 
            "D" { $Y = -1 } 
        }

        # Repeat movement for number of steps
        for ($n = 0; $n -lt [int]$LineValues[1]; $n++) {     
            $Knots[0].Y = $Knots[0].Y + $Y
            $Knots[0].X = $Knots[0].X + $X
        
            # Update position for each knot
            for ($i = 1; $i -lt $Knots.Count; $i++) {    
                $DiffY = $Knots[$i - 1].Y - $Knots[$i].Y                        
                $DiffX = $Knots[$i - 1].X - $Knots[$i].X
                        
                if ([Math]::Abs($DiffX) -gt 1 -or [Math]::Abs($DiffY) -gt 1) {          
                    $Knots[$i].X = $Knots[$($i)].X + [Math]::Sign($DiffX)
                    $Knots[$i].Y = $Knots[$($i)].Y + [Math]::Sign($DiffY)             
                }
            }

            # Add last knot to hash set
            [void]$Positions.Add("[$($Knots[$($Knots.Count-1)].Y),$($Knots[$($Knots.Count-1)].X)]")
        }    
    }

    # Result
    Write-Host "Part $Part result: $($Positions.Count)"
}
