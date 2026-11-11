
# Windows Registry Forensics Lab

## Project Overview

This project documents my practical learning journey in Windows Registry Forensics and Digital Forensics & Incident Response (DFIR).

The objective is to understand Windows registry artifacts, acquire registry hives, verify evidence integrity, investigate USB device activity, and correlate findings with Windows installation logs.

## Tools Used

| Tool | Purpose |
|---|---|
| PowerShell | Evidence acquisition and hashing |
| Registry Explorer | GUI-based registry examination |
| RECmd | Command-line registry analysis |
| SetupAPI.dev.log | Device installation investigation |
| Windows Registry | Source of forensic artifacts |

Official tools:
- [Eric Zimmerman Tools](https://ericzimmerman.github.io/)
- [RECmd](https://github.com/EricZimmerman/RECmd)

## Investigation 1: Registry Hive Acquisition

Acquired the following Windows registry hives:

- SAM
- SECURITY
- SOFTWARE
- SYSTEM

Evidence location: Local forensic evidence directory.

## Investigation 2: SHA-256 Hash Verification

Used PowerShell Get-FileHash to calculate SHA-256 hashes.

Command:

```powershell
$path = "C:\RegistryLab\Evidence"

Get-ChildItem "$path\*.hiv" | ForEach-Object {
    Get-FileHash $_.FullName -Algorithm SHA256
}
```

Purpose:
- Establish evidence integrity baselines.
- Support subsequent integrity verification.
- Document acquired evidence.

## Investigation 3: USB Device Forensics

Analyzed:

```text
SYSTEM\ControlSet001\Enum\USBSTOR
```

Identified these device records:

| Manufacturer | Product |
|---|---|
| Kingston | DataTraveler 3.0 |
| SanDisk | Cruzer Blade |
| Western Digital | My Passport 2626 |
| Western Digital | SES Device |

The WD SES entry is associated with device enclosure/interface functionality.

## Investigation 4: SanDisk Device Instance Analysis

Examined:

```text
ControlSet001\Enum\USBSTOR\
Disk&Ven_SanDisk&Prod_Cruzer_Blade&Rev_1.00
```

Identified two device instance identifiers:

```text
03025016032221104412&0
4C530000070714121483&0
```

Compared the following registry properties:

- DeviceDesc
- FriendlyName
- HardwareID
- CompatibleIDs
- ContainerID
- Driver
- Service
- ConfigFlags
- Address

Both instances reported:

```text
SanDisk Cruzer Blade USB Device
```

They had different instance identifiers and ContainerIDs.

Preliminary conclusion:

Windows maintains two distinct device-instance records associated with the same reported SanDisk product identity. Further evidence is required to establish whether these represent two separate physical devices.

## Investigation 5: SetupAPI Log Analysis

Examined:

```text
C:\Windows\INF\setupapi.dev.log
```

Search command:

```powershell
$log = "C:\Windows\INF\setupapi.dev.log"

Select-String -Path $log -Pattern `
"03025016032221104412|4C530000070714121483" `
-Context 3,5
```

Findings:

- Both SanDisk instance identifiers appeared in the log.
- Both had device installation sections dated September 12, 2026.
- The first installation section began at 14:10:46.
- The second installation section began at 14:17:35.
- Both installation sections reported SUCCESS.
- Both identifiers were associated with USB mass-storage driver configuration entries.

Additional finding:

The log contained volume-device deletion records dated November 9, 2026, with vds.exe as the recorded command.

This does not independently establish physical USB removal or file deletion.

## Important Forensic Lessons

1. Registry LastWrite timestamps are not automatically USB insertion timestamps.
2. A device installation record does not prove a person accessed files.
3. Different device instance identifiers do not independently prove separate physical devices.
4. Evidence should be corroborated using multiple independent artifacts.
5. Original evidence should be preserved and analyzed using working copies.

## Skills Practiced

- Windows registry hive acquisition
- SHA-256 hashing
- Registry artifact interpretation
- USB device identification
- Device instance comparison
- SetupAPI log analysis
- Preliminary forensic reporting

## Next Learning Modules

- SAM hive analysis
- Windows user account investigation
- UserAssist
- BAM/DAM
- Amcache
- Prefetch
- ShellBags
- RecentDocs
- Windows Event Log Forensics
- Forensic timeline construction

## Disclaimer

This repository is for educational and authorized digital forensic investigations.
