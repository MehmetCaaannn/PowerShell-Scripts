# 1. AŞAMA: Eski Domainden veya Mevcut Domainden Kullanıcıları Dışa Aktarma
# Bu script eski domain controller veya mevcut domain controller üzerinde çalıştırılmalıdır.

$ExportPath = "C:\AD_Users_Export.csv"
$SearchOU = "Kullanicilarin_Bulundugu_OU"

Write-Host "Kullanıcı verileri çekiliyor..." -ForegroundColor Cyan

Get-ADUser -Filter * -SearchBase $SearchOU `
-Properties GivenName, Surname, SamAccountName, UserPrincipalName |
Select-Object GivenName, Surname, SamAccountName, UserPrincipalName |
Export-Csv $ExportPath -NoTypeInformation -Encoding UTF8

Write-Host "Aktarım tamamlandı: $ExportPath" -ForegroundColor Green
