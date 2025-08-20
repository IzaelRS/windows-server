# Forçar teclado para Inglês Internacional (US-International)

# Código do layout: 00020409 = US-International
$KeyboardLayout = "00020409"

# Caminho no registro para layouts de teclado
$RegPath = "HKU\.DEFAULT\Keyboard Layout\Preload"

# Remove entradas antigas
Get-ItemProperty -Path $RegPath | ForEach-Object {
    $_.PSObject.Properties | Where-Object { $_.Name -match '^\d+$' } | ForEach-Object {
        Remove-ItemProperty -Path $RegPath -Name $_.Name -ErrorAction SilentlyContinue
    }
}

# Define o layout padrão como US-International
Set-ItemProperty -Path $RegPath -Name "1" -Value $KeyboardLayout

# Também aplica para o usuário atual (se houver sessão)
$UserRegPath = "HKCU\Keyboard Layout\Preload"
if (Test-Path $UserRegPath) {
    Get-ItemProperty -Path $UserRegPath | ForEach-Object {
        $_.PSObject.Properties | Where-Object { $_.Name -match '^\d+$' } | ForEach-Object {
            Remove-ItemProperty -Path $UserRegPath -Name $_.Name -ErrorAction SilentlyContinue
        }
    }
    Set-ItemProperty -Path $UserRegPath -Name "1" -Value $KeyboardLayout
}

Write-Output "Layout de teclado forçado para Inglês Internacional (US-International). Reinicie a sessão para aplicar."
