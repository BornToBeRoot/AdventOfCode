$Count = 0

:outer foreach ($Text in Get-Content -Path $PSScriptRoot\day04_input.txt) {
    $Group = $Text.Split(',')

    $First = $Group[0].Split('-')
    $Second = $Group[1].Split('-')

    $SecondAsArray = $Second[0]..$Second[1]

    foreach ($x in $First[0]..$First[1]) {
        if ($SecondAsArray.Contains($x)) {
            $Count++   
            continue outer
        }        
    }    
}

$Count