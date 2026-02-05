#Requires -Modules Logging
#Requires -Modules Hooks

Invoke-Hook "PreInstallEliteForce"

Write-Log -Message "Installing cMod..."

if (-not (Test-Path -Path "${Env:SERVER_DIR}/cMod-dedicated")) {
    Write-Log "Could not find cMod-dedicated in ${Env:SERVER_DIR}, proceeding with installation."

    $downloadUrl = $Env:cMod_URL

    Write-Log "Downloading cMod from $downloadUrl"

    curl -L --output /tmp/cMod.zip "$downloadUrl"

    unzip /tmp/cMod.zip -d /tmp/cMod

    Move-Item -Force -Path "/tmp/cMod/*" -Destination $Env:SERVER_DIR
} else {
    Write-Log "cMod already installed in ${Env:SERVER_DIR}, skipping installation."
}

chmod +x "${Env:SERVER_DIR}/cMod-dedicated"

Write-Log -Message "cMod installation complete."

Invoke-Hook "PostInstallEliteForce"

Set-Location $Env:SERVER_ROOT