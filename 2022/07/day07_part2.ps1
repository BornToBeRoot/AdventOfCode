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

$DiffFreeSpace = 70000000 - ($Folders | Where-Object { $_.Folder -eq "/" }).Size

$RequiredSpace = (30000000 - $DiffFreeSpace)

($Folders | Where-Object { $_.Size -ge $RequiredSpace } | Sort-Object -Property Size | Select-Object -First 1).Size