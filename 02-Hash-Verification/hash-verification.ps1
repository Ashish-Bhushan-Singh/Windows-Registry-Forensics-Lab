
# SHA-256 Evidence Verification

$path = "C:\Users\jack\Desktop\forensics"

$report = Get-ChildItem "$path\*.hiv" |
    ForEach-Object {
        $hash = Get-FileHash $_.FullName -Algorithm SHA256

        [PSCustomObject]@{
            FileName = $_.Name
            FullPath = $_.FullName
            Algorithm = $hash.Algorithm
            SHA256 = $hash.Hash
        }
    }

$report | Format-List

$report | Export-Csv `
    "$path\Registry_Hash_Report.csv" `
    -NoTypeInformation
