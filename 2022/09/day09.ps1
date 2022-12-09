[System.Collections.ArrayList]$Commands = @()

foreach($Line in Get-Content -Path $PSScriptRoot\day09_input.ps1) {
    $LineValues = $Line.Trim().Split(" ")
    [void]$Commands.Add([pscustomobject]@{
        Direction = $LineValues[0]
        Value = [int]$LineValues[1]
    })
}

[System.Collections.Generic.HashSet[String]]$TailPositions = @()

$CurrentH_Y = 0
$CurrentH_X = 0

$CurrentT_Y = 0
$CurrentT_X = 0

foreach($Command in $Commands) {
    #Write-Host "Direction $($Command.Direction), Value $($Command.Value)"

    switch($Command.Direction) {
        "R" {
            for($i = 0; $i -lt $Command.Value; $i++) {
                $CurrentH_Y_Temp = $CurrentH_Y
                $CurrentH_X_Temp = $CurrentH_X
                
                $CurrentH_X++

                if(($CurrentH_X - $CurrentT_X) -eq 2) {
                    $CurrentT_Y = $CurrentH_Y_Temp
                    $CurrentT_X = $CurrentH_X_Temp
                }

                [void]$TailPositions.Add("[$CurrentT_Y,$CurrentT_X]")

                #Write-Host "Current H [$CurrentH_Y, $CurrentH_X]"
                #Write-Host "Current T [$CurrentT_Y, $CurrentT_X]"
            }
        }
        "L" {
            for($i = 0; $i -lt $Command.Value; $i++) {
                $CurrentH_Y_Temp = $CurrentH_Y
                $CurrentH_X_Temp = $CurrentH_X
                                
                $CurrentH_X--

                if(($CurrentH_X - $CurrentT_X) -eq -2) {
                    $CurrentT_Y = $CurrentH_Y_Temp
                    $CurrentT_X = $CurrentH_X_Temp
                }

                [void]$TailPositions.Add("[$CurrentT_Y,$CurrentT_X]")

                #Write-Host "Current H [$CurrentH_Y, $CurrentH_X]"
                #Write-Host "Current T [$CurrentT_Y, $CurrentT_X]"
            }            
        }
        "U" {
            for($i = 0; $i -lt $Command.Value; $i++) {
                $CurrentH_Y_Temp = $CurrentH_Y
                $CurrentH_X_Temp = $CurrentH_X

                $CurrentH_Y++

                if(($CurrentH_Y - $CurrentT_Y) -eq 2) {
                    $CurrentT_Y = $CurrentH_Y_Temp
                    $CurrentT_X = $CurrentH_X_Temp
                }

                [void]$TailPositions.Add("[$CurrentT_Y,$CurrentT_X]")

                #Write-Host "Current H [$CurrentH_Y, $CurrentH_X]"
                #Write-Host "Current T [$CurrentT_Y, $CurrentT_X]"
            }
        }
        "D" {
            for($i = 0; $i -lt $Command.Value; $i++) {
                $CurrentH_Y_Temp = $CurrentH_Y
                $CurrentH_X_Temp = $CurrentH_X
                
                $CurrentH_Y--

                if(($CurrentH_Y - $CurrentT_Y) -eq -2) {
                    $CurrentT_Y = $CurrentH_Y_Temp
                    $CurrentT_X = $CurrentH_X_Temp
                }
                
                [void]$TailPositions.Add("[$CurrentT_Y,$CurrentT_X]")

                #Write-Host "Current H [$CurrentH_Y, $CurrentH_X]"
                #Write-Host "Current T [$CurrentT_Y, $CurrentT_X]"
            }
        }
    }
}

$TailPositions.Count
