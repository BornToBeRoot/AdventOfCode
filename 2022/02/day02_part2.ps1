function getRound2Value($o, $m) {
    switch($m) {
        1 { $o - 1 -eq 0 ? 3 : $o - 1 }
        2 { $o }
        3 { $o + 1 -eq 4 ? 1 : $o + 1 }
    }
}

[System.Collections.ArrayList]$Strategie = @{}

foreach($Line in Get-Content -Path $PSScriptRoot\day02_input.txt) {
    $Split = $Line.Split(" ")
    [void]$Strategie.Add([pscustomobject]@{
        Opponent = ([Int][Char]$Split[0] - 64)
        Me = getRound2Value ([Int][Char]$Split[0] - 64) ([Int][Char]$Split[1] - 87)
    })
}

foreach($Round in $Strategie) {
    # Base
    $TotalSum += $Round.Me
    
    # Draw
    # O = M       
    if($Round.Opponent -eq $Round.Me) {
        $TotalSum += 3
        continue
    }

    # Win
    # O < M 
    # 1 - 2 = -1
    # 2 - 3 = -1
    # 3 - 1 = 2
    $x = $Round.Opponent - $Round.Me

    if(($x -eq -1) -or ($x -eq 2 -and $Round.Me -eq 1)) {
        $TotalSum += 6
    }
}

$TotalSum
