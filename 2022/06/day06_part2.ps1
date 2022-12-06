$Chars = (Get-Content -Path $PSScriptRoot\day06_input.txt).ToCharArray()

for ($i = 0; $i -lt $Chars.Length; $i++) {
    [System.Collections.Generic.HashSet[String]]$Set = $Chars[$i..($i + 13)]

    if ($Set.Count -eq 14) {
        $i + 14
        break
    }
}
