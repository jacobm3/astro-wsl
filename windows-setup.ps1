# wsl --set-default-version 2

# https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package

# apply latest windows updates

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# restart

# https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
