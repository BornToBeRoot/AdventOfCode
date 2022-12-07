[System.Collections.ArrayList]$Folders = @()

$CurrentFolder = ""

foreach ($Line in  Get-Content -Path $PSScriptRoot\day07_input.txt) {
    if ($Line.StartsWith("$ cd")) {
        $CommandArray = $Line.Split(" ")

        switch ($CommandArray[2]) {
            "/" {
                $CurrentFolder = $CommandArray[2]
            }
            ".." {          
                $CurrentFolder = $CurrentFolder.Substring(0, $CurrentFolder.TrimEnd("/").LastIndexOf("/")) + "/"
            }
            default {
                $CurrentFolder += $CommandArray[2] + "/"
            }
        }       
    }
    elseif (-not $Line.StartsWith("$")) {
        $FileOrDir = $Line.Trim().Split(" ")

        if ($FileOrDir -match "^\d+$") {
            $FileSize = [int]$FileOrDir[0]

            $TempFolder = ""
            $PathSplit = $CurrentFolder.Split("/")
            foreach ($Sub in $PathSplit[0..($PathSplit.Count - 2)]) {
                $TempFolder += $Sub + "/"
                $x = $Folders | Where-Object { $_.Folder -eq $TempFolder }

                if ($null -eq $x) {                    
                    [void]$Folders.Add([pscustomobject]@{
                            Folder = $TempFolder
                            Size   = $FileSize
                        })
                }
                else {                                        
                    [void]$Folders.Remove($x)
                    [void]$Folders.Add([pscustomobject]@{
                            Folder = $TempFolder
                            Size   = $x.Size + $FileSize
                        })
                }
            }           
        }
    }
}

$TotalSum = 0

foreach ($Folder in $Folders) {
    if ($Folder.Size -lt 100000) {
        $TotalSum += $Folder.Size
    }
}

$TotalSum
