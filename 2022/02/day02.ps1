$Text = Get-Content -Path $PSScriptRoot\day02_input.txt

[System.Collections.ArrayList]$Strategie = @{}

$MapValues = @{
    A = 1
    B = 2
    C = 3
    X = 1
    Y = 2
    Z = 3
}

foreach ($Line in $Text) {
    $Split = $Line.Split(" ");
    [void]$Strategie.Add([pscustomobject]@{
            Opponent      = $Split[0]
            OpponentValue = $MapValues[$Split[0]]
            Me            = $Split[1]
            MeValue       = $MapValues[$Split[1]]

        })
}

$TotalSum = 0

foreach ($Round in $Strategie) {
    $TotalSum += $Round.MeValue
    
    # Draw
    if ($Round.OpponentValue -eq $Round.MeValue) {
        $TotalSum += 3
        continue
    }

    $x = $Round.OpponentValue - $Round.MeValue
  
    # Win
    # O   M 
    # 1 - 2 = -1
    # 2 - 3 = -1
    # 3 - 1 = 2
    if (($x -eq -1) -or ($x -eq 2 -and $Round.MeValue -eq 1)) {
        $TotalSum += 6
        continue
    }
}

$TotalSum