$Text = Get-Content -Path $PSScriptRoot\day05_input.txt

[System.Collections.ArrayList]$InputText = @()
[System.Collections.ArrayList]$ActionText = @()

$ParseCount = 0

# Parse input
foreach ($Line in $Text) {
    if ($ParseCount -eq 0 -and ![String]::IsNullOrEmpty($Line)) {
        if ($Line.Contains("[")) {              
            $LineParsed = $Line.Replace("]         [", ",,,").Replace("]     [", ",,").Replace("        ", ",,").Replace("    [", ",").Replace("]    ", ",").Replace("] [", ",").Replace("]", "").Replace("[", "").Replace(" ", "").Trim()
        }
        else {
            $LineParsed = $Line.Replace("   ", ",").Trim()
        }       
        
        [void]$InputText.Add($LineParsed)
    }

    if ($ParseCount -eq 1 -and ![String]::IsNullOrEmpty($Line)) {
        [void]$ActionText.Add($Line.Trim().Replace("move ", "").Replace(" from ", ",").Replace(" to ", ","))
    }

    if ([String]::IsNullOrEmpty($Line)) {
        $ParseCount++        
    }
}

# Create 2 dimensional array
$InputCount = $InputText[$InputText.Count - 1].Split(",").Count

[System.Collections.ArrayList]$InputArray = @()

for ($i = 0; $i -lt $InputCount; $i++) {
    [System.Collections.ArrayList]$InputArraySub = @()

    # Ignore first line
    for ($y = $InputText.Count - 2; $y -gt -1; $y--) {
        # Add each char
        foreach ($t in $InputText[$y].Split(",")[$i]) {
            # Check for content
            if (-not[String]::IsNullOrEmpty($t)) {
                [void]$InputArraySub.Add($t)
            }
        }        
    }

    [void]$InputArray.Add($InputArraySub)
}

# Actions
foreach ($ActionSplit in $ActionText) {
    # move,from,to (e.g. 1,2,1)
    $Action = $ActionSplit.Split(",")
       
    $OldIndex = $Action[1] - 1
    $NewIndex = $Action[2] - 1    
    $StartIndex = $InputArray[$OldIndex].Count - $Action[0]

    $TempItems = $InputArray[$OldIndex].GetRange($StartIndex, $Action[0])    
    for ($t = $TempItems.Count - 1; $t -gt -1; $t--) {
        [void]$InputArray[$NewIndex].Add($TempItems[$t])
    }    
    [void]$InputArray[$OldIndex].RemoveRange($StartIndex, $Action[0])   
}

# Output
for ($i = 0; $i -lt $InputCount; $i++) {
    Write-Host "$($InputArray[$i][$InputArray[$i].Count - 1])" -NoNewline
}

Write-Host "`n"
