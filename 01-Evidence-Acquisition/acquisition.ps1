
# Windows Registry Forensics Lab
# Registry Hive Acquisition

$dest = "C:\Users\jack\Desktop\forensics"

New-Item -ItemType Directory -Force -Path $dest

# Note:
# These are working-copy acquisition commands.
# Windows registry hives may be locked.
# For a consistent acquisition, use an appropriate
# forensic acquisition method or Volume Shadow Copy.

Write-Host "Evidence directory:" $dest

Get-ChildItem $dest
