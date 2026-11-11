
# Forensic Investigation Findings

## Case Information

Case ID: LAB-001
Investigation: Windows USB Device Forensics
Platform: Windows
Analysis tools: RECmd, PowerShell, SetupAPI
Status: Preliminary findings

## Finding 1: USB Device Records

Four USB-related entries were identified:

1. Kingston DataTraveler 3.0
2. SanDisk Cruzer Blade
3. WD My Passport 2626
4. WD SES Device

## Finding 2: SanDisk Device Instances

Two device instance identifiers were identified:

- 03025016032221104412
- 4C530000070714121483

Both reported the same SanDisk Cruzer Blade product identity.

Their ContainerIDs and driver references differed.

## Finding 3: SetupAPI Correlation

Both identifiers were found in setupapi.dev.log.

The log contained successful device installation sections on September 12, 2026.

The log also contained later volume-device deletion records on November 9, 2026.

## Limitations

- Physical device identity has not been conclusively established.
- Physical insertion and removal times have not been established.
- User attribution has not been established.
- File access and copying have not been established.
- Timestamp timezone and conversion require further examination.

## Conclusion

The investigation identified multiple USB storage device records and successfully correlated two SanDisk device instances with Windows SetupAPI installation records.

Further investigation is necessary before making conclusions about physical device identity, user activity, or file transfers.
