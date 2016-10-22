Function Get-Folder($message) {
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.rootfolder = "MyComputer"
    $foldername.Description = $message

    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }
    return $folder
}

$inputFolder = "C:\Users\18dellingera\Dropbox\11\tsa\software_development\music_samples"
$outputFolder = "C:\Users\18dellingera\Dropbox\11\tsa\software_development\finished_samples"
$freqRange = Read-Host -Prompt "Enter your frequency range"
#$inputFolder = Get-Folder("input folder")
#$outputFolder = Get-Folder("output folder")

Get-ChildItem -Path $inputFolder -Include *.mp3, *.wav -Recurse | 
Foreach-Object {
    Write-Host "filtering " ($_.BaseName + $_.Extension)
    $file = ($_.BaseName + $_.Extension)
    $outpath = Join-Path $outputFolder $file
    .\sox\sox.exe $_ $outpath sinc $freqRange
}