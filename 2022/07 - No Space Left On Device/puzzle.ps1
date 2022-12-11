# https://adventofcode.com/2022/day/7

[System.Collections.ArrayList]$Folders = @()
$CurrentFolder = ""

foreach ($Line in  Get-Content -Path $PSScriptRoot\input.txt) {
    if ($Line.StartsWith("$ cd")) {
        $CommandArray = $Line.Split(" ")

        switch ($CommandArray[2]) {
            "/" { $CurrentFolder = $CommandArray[2] }
            ".." { $CurrentFolder = $CurrentFolder.Substring(0, $CurrentFolder.TrimEnd("/").LastIndexOf("/")) + "/" }
            default { $CurrentFolder += $CommandArray[2] + "/" }
        }       
    }
    elseif (-not $Line.StartsWith("$")) {
        $FileOrDir = $Line.Trim().Split(" ")

        if ($FileOrDir[0] -match "^\d+$") {
            $FileSize = [int]$FileOrDir[0]

            $TempFolder = ""
            $PathSplit = $CurrentFolder.Split("/")
            foreach ($Sub in $PathSplit[0..($PathSplit.Count - 2)]) {
                $TempFolder += $Sub + "/"
                $x = $Folders | Where-Object { $_.Folder -eq $TempFolder }

                $TempSize = $FileSize

                # Remove existing entry / update
                if ($null -ne $x) {
                    $TempSize += $x.Size
                    [void]$Folders.Remove($x)                    
                }

                [void]$Folders.Add([pscustomobject]@{
                        Folder = $TempFolder
                        Size   = $TempSize
                    })
            }           
        }
    }
}

# Part 1
($Folders | Where-Object { $_.Size -le 100000 } | Measure-Object -Sum Size).Sum

# Part 2
$DiffFreeSpace = 70000000 - ($Folders | Where-Object { $_.Folder -eq "/" }).Size
$RequiredSpace = (30000000 - $DiffFreeSpace)
($Folders | Where-Object { $_.Size -ge $RequiredSpace } | Sort-Object -Property Size | Select-Object -First 1).Size
