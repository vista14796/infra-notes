# ==============================================================
# Hyper-V Bulk VM Deployment Script (Stable Version)
# NOTE: After running this script, enable TPM manually on each VM.
# ==============================================================

# --------------------------------------------------------------
# 1. Configuration
# --------------------------------------------------------------
$masterPath = "C:\Hyper-v\VM01\Virtual Hard Disks\VM01.vhdx"
$baseFolder = "C:\Hyper-v"
$vmList = @("winser02", "winser03", "winser04", "winser05", "winser06", "winser07", "winser08")
$cpuCount = 8
$ramSize = 4096MB

# Prompt for VM administrator credentials (once, before the loop)
Write-Host "Enter the Administrator password for the virtual machines:" -ForegroundColor Yellow
$cred = Get-Credential

# --------------------------------------------------------------
# 2. Bulk Copy and Hardware Configuration (100% stable)
# --------------------------------------------------------------
foreach ($vmName in $vmList) {
    Write-Host "`n>>> Processing $vmName ..." -ForegroundColor Cyan
    $vmFolder = Join-Path $baseFolder $vmName
    $newVHD = Join-Path $vmFolder "$vmName.vhdx"

    # Create directory and copy VHD
    if (-not (Test-Path $vmFolder)) { New-Item $vmFolder -ItemType Directory | Out-Null }
    Write-Host "   - Copying virtual hard disk..."
    Copy-Item $masterPath $newVHD -Force

    # Create VM and configure hardware
    New-VM -Name $vmName -Generation 2 -VHDPath $newVHD -Path $baseFolder -SwitchName "Default Switch" | Out-Null
    Set-VMMemory $vmName -DynamicMemoryEnabled $false -StartupBytes $ramSize
    Set-VMProcessor $vmName -Count $cpuCount

    # Start VM and wait for OS initialization
    Start-VM $vmName
    Write-Host "   - Waiting for system initialization (60 seconds)..."
    Start-Sleep -Seconds 60

    # --------------------------------------------------------------
    # 3. Remote System Optimization (rename + disable shutdown tracker)
    # --------------------------------------------------------------
    try {
        Invoke-Command -VMName $vmName -Credential $cred -ScriptBlock {
            # A. Disable shutdown event tracker via registry
            $reg = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Reliability"
            if (-not (Test-Path $reg)) { New-Item $reg -Force | Out-Null }
            Set-ItemProperty $reg -Name "ShutdownReasonUI" -Value 0 -Type DWord

            # B. Rename computer and restart
            Rename-Computer -NewName $using:vmName -Force
            Restart-Computer -Force -Confirm:$false
        }
        Write-Host "   [SUCCESS] $vmName has been configured and is restarting." -ForegroundColor Green
    } catch {
        Write-Warning "   [WARNING] Remote configuration failed for $vmName. Please verify the system has booted to the login screen."
    }
}

Write-Host "`nDeployment complete. Please enable TPM manually on each VM." -ForegroundColor Yellow
