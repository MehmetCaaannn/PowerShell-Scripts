# 2. AŞAMA: Domaine Kullanıcıları Aktarma
# CSV dosyasını bu sunucuya kopyaladıktan sonra çalıştırın.

$ImportPath = "C:\AD_Users_Export.csv"
$TargetOU = "Kullanicilarin_Aktarilmak_Istendigi_OU"
$DefaultPassword = ConvertTo-SecureString "Buraya_Parola_Belirle" -AsPlainText -Force

Write-Host "Yeni domaine aktarım başlıyor..." -ForegroundColor Cyan

if (Test-Path $ImportPath) {
    Import-Csv $ImportPath | ForEach-Object {
        try {
            New-ADUser `
            -Name ($_.GivenName + " " + $_.Surname) `
            -GivenName $_.GivenName `
            -Surname $_.Surname `
            -SamAccountName $_.SamAccountName `
            -UserPrincipalName $_.UserPrincipalName `
            -AccountPassword $DefaultPassword `
            -Enabled $true `
            -Path $TargetOU
            
            Write-Host "BAŞARILI: $($_.SamAccountName)" -ForegroundColor Green
        }
        catch {
            Write-Warning "HATA: $($_.SamAccountName) oluşturulamadı. Sebep: $($_.Exception.Message)"
        }
    }
} else {
    Write-Error "Hata: $ImportPath bulunamadı! Lütfen CSV dosyasını kopyalayın."
}
