# https://adventofcode.com/2022/day/10

$X = 1
$Loops = 0
$CyclesToCheck = @(20, 60, 100, 140, 180, 220)
[System.Collections.ArrayList]$SignalStrengths = @()

function LoopAction() {
    # Part 1
    if ($CyclesToCheck.Contains($Loops)) {        
        [void]$SignalStrengths.Add($Loops * $X)
    }

    # Part 2
    $CrtPixel = ($Loops - 1) % 40
    $PrintValue = "."

    if ([Math]::Abs($CrtPixel - $X) -lt 2) {
        $PrintValue = "X"
    }    

    Write-Host $PrintValue -NoNewline

    if ($CrtPixel -eq 39) {
        Write-Host ""
    }    
}

foreach ($Line in Get-Content $PSScriptRoot\input.txt) {
    $LineValues = $Line.Split(" ")

    if ($LineValues[0] -eq "noop") {
        $Loops++
        LoopAction        
        continue
    }

    if ($LineValues[0] -eq "addx") {
        for ($i = 0; $i -lt 2; $i++) {
            $Loops++
            LoopAction            

            if ($i -eq 0) { continue }

            $X += [Int]::Parse($LineValues[1])
        }
    }
}

# Part 1
Write-Host "Part 1: $(($SignalStrengths | Measure-Object -Sum).Sum)"
